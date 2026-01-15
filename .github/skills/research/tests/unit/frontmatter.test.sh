#!/usr/bin/env bash
set -euo pipefail
SKILL_DIR=$(cd "$(dirname "$0")/../../" && pwd)
SKILL_FILE="$SKILL_DIR/SKILL.md"

if [ ! -f "$SKILL_FILE" ]; then
  echo "SKILL.md not found"
  exit 2
fi

# Check for name and description
if ! grep -q '^name:' "$SKILL_FILE"; then
  echo "Missing name"
  exit 3
fi
if ! grep -q '^description:' "$SKILL_FILE"; then
  echo "Missing description"
  exit 4
fi

echo "Frontmatter unit test passed"
exit 0
