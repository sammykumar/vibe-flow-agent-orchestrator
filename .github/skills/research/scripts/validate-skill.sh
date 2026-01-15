#!/usr/bin/env bash
set -euo pipefail
SKILL_DIR=$(cd "$(dirname "$0")/.." && pwd)
SKILL_FILE="$SKILL_DIR/SKILL.md"

echo "Running skill validation for $SKILL_DIR"

# 1) Run skills-ref validate if available
if command -v skills-ref >/dev/null 2>&1 || command -v npx >/dev/null 2>&1; then
  echo "Running: npx skills-ref validate $SKILL_DIR"
  if ! npx skills-ref validate "$SKILL_DIR"; then
    echo "skills-ref validate failed; continuing to run local checks"
  fi
else
  echo "skills-ref not available; skipping"
fi

# 2) Ensure SKILL.md exists and has required frontmatter keys
if [ ! -f "$SKILL_FILE" ]; then
  echo "ERROR: $SKILL_FILE not found"
  exit 2
fi

# Check for required keys
for key in name description; do
  if ! grep -q "^$key:\"\?" "$SKILL_FILE"; then
    echo "ERROR: required frontmatter key '$key' not found in $SKILL_FILE"
    exit 3
  fi
done

# 3) Check for assets
for f in assets/research-template.md assets/spec-template.md assets/progress-log-template.md references/REFERENCE.md; do
  if [ ! -f "$SKILL_DIR/$f" ]; then
    echo "ERROR: required asset $f missing"
    exit 4
  fi
done

echo "Basic validation passed for research skill"
exit 0
