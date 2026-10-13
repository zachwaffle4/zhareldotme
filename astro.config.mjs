// @ts-check
import { defineConfig } from "astro/config";
import mdx from "@astrojs/mdx";
import sitemap from "@astrojs/sitemap";

import cloudflare from "@astrojs/cloudflare";
import { unified } from "@astrojs/markdown-remark";
import remarkGithubBlockquoteAlert from "remark-github-blockquote-alert";

// https://astro.build/config
export default defineConfig({
    site: "https://zharel.me",
    markdown: {
        processor: unified({
            remarkPlugins: [remarkGithubBlockquoteAlert],
        }),
    },
    integrations: [mdx(), sitemap()],
    adapter: cloudflare(),
});