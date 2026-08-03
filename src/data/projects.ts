export type ProjectLink = { label: string; href: string };

export type Project = {
	name: string;
	category: string;
	role?: string;
	years: string;
	blurb: string;
	tech: string[];
	links: ProjectLink[];
};

export const projects: Project[] = [
	{
		name: 'WPILib',
		category: 'Open Source',
		role: 'Contributor',
		years: '2025 – Present',
		blurb:
			'Kinematics, motion planning, and robot operation code for the standard library used by every FIRST Robotics Competition and FIRST Tech Challenge team.',
		tech: ['C++', 'Java'],
		links: [
			{ label: 'wpilib.org', href: 'https://wpilib.org/' },
			{ label: 'allwpilib', href: 'https://github.com/wpilibsuite/allwpilib' },
		],
	},
	{
		name: 'NextFTC',
		category: 'Open Source',
		role: 'Maintainer & Controls Project Lead',
		years: '2024 – Present',
		blurb:
			'A command-based framework for FIRST Tech Challenge robots. I maintain the project and lead the controls subproject.',
		tech: ['Kotlin'],
		links: [{ label: 'nextftc.dev', href: 'https://nextftc.dev/' }],
	},
	{
		name: 'FRCSoftware.org',
		category: 'Open Source',
		role: 'Project Lead',
		years: '2026 – Present',
		blurb: 'A beginner-friendly tutorial for FRC students and mentors.',
		tech: ['TypeScript'],
		links: [
			{ label: 'FRCSoftware.org', href: 'https://frcsoftware.org/' },
			{ label: 'GitHub', href: 'https://github.com/frcsoftware/frcsoftware.org/' },
		]
	},
	{
		name: 'commandsv3-python',
		category: 'Open Source',
		years: '2026',
		blurb:
			"An unofficial community Python port of WPILib's Commands v3 framework, targeting the OpMode-based robot structure shared by FRC and FTC on the Systemcore control system. A proof of concept rather than a production library.",
		tech: ['Python'],
		links: [{ label: 'GitHub', href: 'https://github.com/zachwaffle4/commandsv3-python' }],
	},
	{
		name: 'FTC Cycle Times',
		category: 'Tools',
		years: '2026',
		blurb:
			'A web app for analyzing how consistently FIRST Tech Challenge events run on schedule. Shows per-match cycle times and schedule deviation for a single event, plus pooled stats across a league, region, month, or season.',
		tech: ['Vue', 'TypeScript'],
		links: [
			{ label: 'cycles.zharel.me', href: 'https://cycles.zharel.me/' },
			{ label: 'GitHub', href: 'https://github.com/zachwaffle4/ftc-cycle-times' }
		],
	},
	{
		name: 'ftcapiv3-client',
		category: 'Tools',
		years: '2026',
		blurb:
			'A published TypeScript client for the FIRST Tech Challenge Scoring API v3, generated from the official OpenAPI specification with full typings.',
		tech: ['TypeScript'],
		links: [
			{ label: 'npm', href: 'https://www.npmjs.com/package/@zach.waffle/ftcapiv3-client' },
			{ label: 'GitHub', href: 'https://github.com/zachwaffle4/ftcapiv3-client-ts' },
		],
	},

	{
		name: 'zharel.me',
		category: 'Misc',
		years: '2026 – Present',
		blurb:
			'This site. A static Astro build deployed to Cloudflare Workers, with content collections for the blog.',
		tech: ['Astro', 'Cloudflare Workers'],
		links: [{ label: 'GitHub', href: 'https://github.com/zachwaffle4/zhareldotme' }],
	},
];

export const categories = [
	'Open Source',
	'Tools',
	'Misc',
] as const satisfies readonly Project['category'][];
