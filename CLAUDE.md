# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is an Astro-based blog website deployed to Cloudflare Workers. It uses Astro's static site generation capabilities with MDX support for content creation.

## Essential Commands

### Development
- `bun run dev` - Start local dev server at localhost:4321
- `bun run preview` - Build and preview with Wrangler dev server

### Build & Deploy
- `bun run build` - Build production site to ./dist/
- `bun run check` - Build, type-check, and dry-run deploy validation
- `bun run deploy` - Deploy to Cloudflare Workers

### Utilities
- `bun run cf-typegen` - Generate Cloudflare types
- `bun run astro` - Run Astro CLI commands
- `bun install` - Install dependencies

## Architecture & Key Components

### Content System
The blog uses Astro's content collections API defined in `src/content.config.ts`. Blog posts are loaded from `src/content/blog/` directory using the glob loader pattern. Each post requires frontmatter with:
- title (string)
- description (string)
- pubDate (date)
- updatedDate (optional date)
- heroImage (optional string)

### Cloudflare Workers Integration
The site is configured as a static Cloudflare Workers site via `@astrojs/cloudflare` adapter. Key configurations:
- `wrangler.json` defines the Workers deployment settings
- Assets are served from the ASSETS binding
- Node.js compatibility is enabled for broader package support
- Observability logging is enabled for production monitoring

### Page Routing
Astro file-based routing in `src/pages/`:
- Static pages (`.astro` files) are exposed as routes based on filename
- Dynamic blog post routes are handled via content collections
- RSS feed is generated at `/rss.xml` endpoint

### Build Output
The build process generates:
- Static HTML/CSS/JS in `./dist/`
- Worker script at `./dist/_worker.js/index.js`
- Source maps for debugging (uploaded to Cloudflare)