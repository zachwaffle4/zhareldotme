// ---------- Setup ----------
#let accent = rgb("#2B4C6F")

#set document(title: "Zachary Harel – Resume", author: "Zachary Harel")
#set page(paper: "us-letter", margin: (x: 0.6in, y: 0.5in))
#set text(font: ("Fira Sans", "Libertinus Serif"), size: 10pt)
#set par(justify: false, leading: 0.5em)
#set list(indent: 0.4em, body-indent: 0.5em, spacing: 0.5em)

// Section headings: small caps-style uppercase, accent color, rule underneath
#show heading.where(level: 1): it => block(
  above: 0.5em,
  below: 0.25em,
  width: 100%,
  inset: (bottom: 3pt),
  stroke: (bottom: 0.6pt + accent),
  text(size: 10pt, weight: "bold", fill: accent, tracking: 0.08em, upper(it.body)),
)

// One resume entry: "Title, Org" line, italic date line, then bullets
#let entry(title, org, dates, ..items) = block(below: 0.675em, breakable: false)[
  #strong(title), #org \
  #text(size: 9pt, style: "italic", fill: luma(85), dates)
  #list(..items.pos())
]

#let sep = [#h(0.5em)|#h(0.5em)]

// ---------- Header ----------
#block(below: 0.5em, text(size: 20pt, weight: "bold")[ZACHARY HAREL])
#block(below: 0.5em, text(size: 11pt, style: "italic", fill: accent)[CS & Biology Student])
#text(size: 9pt)[
  (516) 460-2295 #sep
  #link("mailto:harel.z@northeastern.edu")[harel.z\@northeastern.edu] #sep
  #link("https://zharel.me")[zharel.me] #sep
  #link("https://github.com/zachwaffle4")[github.com/zachwaffle4]
]

// ---------- Education ----------
= Education

#entry(
  [BS, Computer Science and Biology], [Northeastern University, Boston, MA],
  [September 2025 – May 2029 (Expected)],
  [John Martinson Honors Program Participant],
  [_Relevant Coursework_: Program Design and Implementation I/II, Discrete Structures, Databases, Computer Systems, Algorithms, Genetics and Molecular Biology, Computational Tools for Genome Analysis],
)

#entry(
  [High School Diploma], [Half Hollow Hills High School West, Dix Hills, NY],
  [September 2021 – June 2025],
  [_Academic Research Program_: researched the use of machine learning to aid in diagnoses of diseases including Major Depressive Disorder and Lyme Disease],
)

// ---------- Experience ----------
= Experience

#entry(
  [Machine Learning Intern], [EduBeyond, Remote],
  [December  2023 – February   2024],
  [Created and deployed large language model-backed systems to demonstrate to clients, including use of the ChatGPT API and Flowchat libraries.],
  [Developed company website features using TypeScript and React.],
)

#entry(
  [Teaching Assistant, Program Design and Implementation II], [Northeastern University, Boston, MA],
  [September 2026 – Present],
  [Facilitated weekly recitation sections, including assisting and mentoring students in Java environment and code problems, and leading in-person "codewalk" sessions to verify student understanding of their work.],
  [Led office hours sessions to provide additional programming support to students and answered student questions through the course discussion platform.],
)

#entry(
  [FIRST Technical Advisor (Volunteer)], [New England FIRST and FIRST Long Island],
  [November 2025 – Present],
  [Planned, set up, and ran FIRST Tech Challenge qualifiers and regional championship tournaments for over 135 middle and high-school robotics teams across Massachusetts and Long Island.],
  [Provided support to teams experiencing technical difficulties, particularly with software and electrical issues.],
  [Provided training and support to other technical volunteers.],
)

// ---------- Open-Source ----------
= Open-Source

#entry(
  [Co-Lead Maintainer], [FRC and FTC Software],
  [May 2026 - Present],
  [Led infrastructure and curriculum development for frcsoftware.org, an open-source guide and tutorial for programming FIRST Robotics Competition robots.],
)

#entry(
  [Contributor], [WPILib],
  [August 2025 – Present],
  [Contributed kinematics, motion planning, and robot operation code for the FIRST Robotics Competition and FIRST Tech Challenge standard library.],
)

// ---------- Campus Involvement ----------
= Campus Involvement

#entry(
  [Assistant Command/Data Handling Lead and Website Lead], [Northeastern Satellite Laboratory],
  [January 2026 – Present],
  [Developed flight software for small satellites using the F Prime ecosystem, primarily focusing on board-to-board communication using CAN.],
  [Developed club logo, branding standards, and website for communication with other labs, clubs, universities, and sponsors.],
)

#entry(
  [Assistant Music Director (Fall 2025, Spring 2026), Pit Orchestra (Summer 2026)], [NUStage Musical Theater Company],
  [September 2025 – Present],
  [Directed music for two shows in an assistant capacity, including analyzing scores across multiple genres, leading rehearsals for cast members of varying vocal types and skill levels, and arranging harmonies.],
  [Balanced line-by-line audio levels during performances to ensure an engaging and clear experience for audiences.],
)

// ---------- Skills ----------
= Technical Skills

*Languages:* Python (TensorFlow, PyTorch, NumPy), Java, Kotlin, JavaScript, TypeScript (Svelte, Astro), C, C++, SQL (SQLite, MySQL, PostgreSQL) \
*Tools:* Unix, Git, GitHub, Microsoft 365, Google Workspace, Cloudflare \
*Domains:* Data Analysis, Controls, Machine Learning
