#!/usr/bin/env node
// Syncs .github/{agents,skills,prompts} → .apm/{agents,skills,prompts}
// Run via: npm run sync

import { cpSync, rmSync, existsSync } from "fs";
import { resolve, dirname } from "path";
import { fileURLToPath } from "url";

const root = resolve(dirname(fileURLToPath(import.meta.url)), "..");

const pairs = [
  [".github/agents", ".apm/agents"],
  [".github/skills", ".apm/skills"],
  [".github/prompts", ".apm/prompts"],
];

for (const [src, dest] of pairs) {
  const srcPath = resolve(root, src);
  const destPath = resolve(root, dest);

  if (!existsSync(srcPath)) {
    console.error(`Source not found: ${src}`);
    process.exit(1);
  }

  rmSync(destPath, { recursive: true, force: true });
  cpSync(srcPath, destPath, { recursive: true });
  console.log(`✓ ${src} → ${dest}`);
}
