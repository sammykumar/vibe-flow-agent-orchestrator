#!/usr/bin/env node
// Usage: node scripts/version.js [patch|minor|major]
// Bumps version in package.json and apm.yml, then commits, tags, and pushes.

import { readFileSync, writeFileSync } from "fs";
import { resolve, dirname } from "path";
import { fileURLToPath } from "url";
import { execSync } from "child_process";
import { createRequire } from "module";

const root = resolve(dirname(fileURLToPath(import.meta.url)), "..");
const require = createRequire(import.meta.url);

const bumpType = process.argv[2] ?? "patch";
if (!["patch", "minor", "major"].includes(bumpType)) {
  console.error(`Invalid bump type "${bumpType}". Use patch, minor, or major.`);
  process.exit(1);
}

// --- Read current version from package.json ---
const pkgPath = resolve(root, "package.json");
const pkg = require(pkgPath);
const [major, minor, patch] = pkg.version.split(".").map(Number);

let newMajor = major,
  newMinor = minor,
  newPatch = patch;
if (bumpType === "major") {
  newMajor++;
  newMinor = 0;
  newPatch = 0;
}
if (bumpType === "minor") {
  newMinor++;
  newPatch = 0;
}
if (bumpType === "patch") {
  newPatch++;
}

const newVersion = `${newMajor}.${newMinor}.${newPatch}`;
console.log(`${pkg.version} → ${newVersion}`);

// --- Update package.json ---
pkg.version = newVersion;
writeFileSync(pkgPath, JSON.stringify(pkg, null, 2) + "\n", "utf8");
console.log("✓ package.json");

// --- Update apm.yml ---
const apmPath = resolve(root, "apm.yml");
const updatedApm = readFileSync(apmPath, "utf8").replace(
  /^version: [\d.]+/m,
  `version: ${newVersion}`,
);
writeFileSync(apmPath, updatedApm, "utf8");
console.log("✓ apm.yml");

// --- Git commit, tag, push ---
const run = (cmd) => execSync(cmd, { cwd: root, stdio: "inherit" });

run(`git add package.json apm.yml`);
run(`git commit -m "chore: release v${newVersion}"`);
run(`git tag -m "Version ${newVersion}" v${newVersion}`);
run(`git push origin`);
run(`git push origin v${newVersion}`);
run(`git tag -f -m "Latest version" latest`);
run(`git push -f origin latest`);

console.log(`\n✓ Released v${newVersion}`);
