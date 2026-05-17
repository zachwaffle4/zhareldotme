---
title: "A Closer Look at OpModes"
description: "A more detailed look at OpModes, what they are and options for using them"
pubDate: "May 16 2026"
---

Note for FTC Readers: the concept of an OpMode in WPILib is very different from the concept of an OpMode in the FTC SDK

WPILib 2027 includes the concept of an OpMode, but what exactly is an OpMode? 

At its core, an OpMode is simply a packet of data communicated between the Driver Station and the robot. It contains the following information: name, description, group, and robot mode (autonomous, teleop, or utility), and an id that is calculated based on its name and robot mode. Robot code can create a list of these OpMode packets and send them to the Driver Station, which will display them by mode:

![OpMode Selection Screen](/ds-opmodes.jpg)

Users can then determine what OpMode is selected using the `RobotState.getOpModeId()` method, which returns the id of the selected OpMode, or `RobotState.getOpMode()`, which returns the name. Note that the robot has to be in the appropriate mode (autonomous, teleop, or utility) for the OpMode to be selected. For example, if the robot is in teleop mode, only teleop OpModes can be selected.

# What can you do with this?

WPILib 2027 also includes two major ways to use `OpMode`s, `OpModeRobot` and `OpModeTriggers`. `OpModeRobot` is a base class that you can extend to create a robot that runs different periodic code based on which OpMode is selected. It will automatically call the appropriate methods when the OpMode is selected, started, stopped, etc. `OpModeTriggers` is a more flexible way to use OpModes with the Commands v3 framework, allowing you to create triggers that are activated when a specific OpMode is selected or started. This allows you to run code in response to OpMode changes without having to extend `OpModeRobot`.

## `OpModeRobot` and the `OpMode` interface

The `OpModeRobot` class is a base class that you can extend to create a robot that runs different programs based on which OpMode is selected. These programs are also called `OpMode`s, and they extend the `OpMode` interface. Most users should have their OpMode programs extend `PeriodicOpMode` instead, though. `PeriodicOpMode` has the following methods:
- `start()`
- `periodic()`
- `end()`
- `disabledPeriodic()`
- `close()` (Java only)

When the robot is running, the `OpModeRobot` will automatically manage the lifecycle of your OpMode for you, calling the appropriate methods at the right times. 

### The OpMode Lifecycle

Here's how the lifecycle of an OpMode works in practice:

**When the operator selects an OpMode on the Driver Station**, a new instance of your OpMode class is created. This is a fresh object, so you can initialize any state you need in the constructor.

**While an OpMode is selected but the robot disabled**, the library calls `disabledPeriodic()` regularly (as determined by `OpModeRobot#getPeriod()`. This is a great place to update dashboard displays, read sensors, or preview what you're about to do. The library guarantees that `disabledPeriodic()` will be called at least once before the robot transitions to enabled state, so you can count on any initialization logic here being run.

**When the robot transitions from disabled to enabled**, `start()` is called exactly once. 

**While the robot is enabled**, `periodic()` is called repeatedly at regular intervals (determined by `OpModeRobot#getPeriod()`). This is the heartbeat of your OpMode where most of your robot logic happens. You also have the option to register additional callbacks via `getCallbacks()` that run at their own configured rates.

**When the robot disables or a different OpMode is selected while enabled**, the library calls `end()` first, giving you a chance to clean up and send one final update to your actuators. Then `close()` is called (in Java) or the object is destroyed (in C++ or Python). The object is never reused; a new one is created if the same OpMode is still selected upon disabling.

Notably, if a different OpMode is selected while the robot is enabled, the robot will automatically disable first before switching OpModes.

**If a different OpMode is selected while disabled**, the old OpMode object simply has `close()` called on it and is destroyed. No `end()` call happens since it was never enabled.

After the old OpMode is closed, a brand new OpMode object is constructed based on what the Driver Station is showing. In teleop, autonomous, and utility modes, the dropdown selection stays the same as before, so you'll typically construct the same OpMode class again. In match mode (or when connected to the FMS), only the selected autonomous OpMode is constructed initially. Once autonomous completes, the selected teleop OpMode is then constructed. This design ensures that only one OpMode object is ever alive at a time.

## Commands v3 and `OpModeTriggers`

The new Commands v3 library includes automatic scoping of command and triggers to the currently active OpMode. This means that you can create triggers that are only active when a specific OpMode is selected or started. This allows you to run code in response to OpMode changes without having to extend `OpModeRobot`.

The `OpModeTriggers` class also provides access to three triggers for a given OpMode:
- `loaded()`: Triggered when the OpMode is selected on the Driver Station, regardless of whether the robot is enabled or disabled.
- `enabled()`: Triggered when the OpMode transitions from disabled to enabled.
- `disabled()`: Triggered when the OpMode transitions from enabled to disabled.

`OpModeTriggers` objects are created from the `CommandOpModes.create*OpMode` methods:
- `OpModeTriggers CommandOpModes.createAutoOpMode(String name, String description, String group)`
- `OpModeTriggers CommandOpModes.createTeleopOpMode(String name, String description, String group)`
- `OpModeTriggers CommandOpModes.createUtilityOpMode(String name, String description, String group`)
  (Note that the `description` and `group` parameters are optional and can be left out)

This allows you to structure your robot project in the usual command-based way, without having to extend `OpModeRobot` or implement the `OpMode` interface at all. You can simply create your OpModes using the `CommandOpModes` factory methods in your robot constructor, and then use the returned `OpModeTriggers` to run commands.

```java
public class Robot extends TimedRobot {
  // actuators (Mechanism derived)
  public final Drive drive = new Drive();
  public final Intake intake = new Intake();
  public final Storage storage = new Storage();

  // sensors (not Mechanism derived)
  public final Vision vision = new Vision();

  public Robot() {
    // Automatically disable and retract the intake whenever the ball storage is full.
    storage.hasCargo.onTrue(intake.retractCommand());

    // Create auto opmodes
    addSimpleAuto();
    addPathAuto("drive and turn");

    // Create teleop opmodes
    addArcadeTeleop();

    // Publish opmodes to the Driver Station
    RobotState.publishOpModes();
  }

  private void addSimpleAuto() {
    // A simple autonomous opmode
    createAutoOpMode("Simple Auto").enabled().whileTrue(simpleAutoCommand());
  }

  private void addPathAuto(String path) {
    // A complex autonomous opmode that loads a path when selected in the DS while still disabled
    OpModeTriggers opmode = createAutoOpMode(path, "Follow Path");
    opmode.loaded().onTrue(Commands.runOnce(() -> Paths.loadPath(path)));
    opmode.enabled().whileTrue(Autos.followPath(this, path));
  }

  private void addArcadeTeleop() {
    // A teleop opmode with joystick and button controls
    OpModeTriggers opmode = createTeleopOpMode("teleop");

    var driverController = new CommandXboxController(1);

    // Control the drive with split-stick arcade controls
    opmode.setDefaultCommand(
        drive,
        drive.arcadeDriveCommand(
            () -> -driverController.getLeftY(), () -> -driverController.getRightX()));

    // Deploy the intake with the X button
    opmode.enabled(driverController.x()).onTrue(intake.intakeCommand());
    // Retract the intake with the Y button
    opmode.enabled(driverController.y()).onTrue(intake.retractCommand());
  }
}
```

### `CommandRobot`

Commands v3 also includes a `CommandRobot` base class that extends `OpModeRobot` and provides additional functionality for command-based programming. The `CommandRobot` class has the same methods as `CommandOpModes`, but it registers the OpModes with the superclass's OpMode registrar so that both command-based and `PeriodicOpMode`-based OpModes can be used in the same robot project. 