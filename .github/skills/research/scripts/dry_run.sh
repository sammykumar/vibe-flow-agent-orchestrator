#!/usr/bin/env bash
set -euo pipefail
SKILL_DIR=$(cd "$(dirname "$0")/.." && pwd)
TMPDIR=$(mktemp -d)
PLAN_DIR="$TMPDIR/sample-plan"
mkdir -p "$PLAN_DIR"

# Copy templates into a plan skeleton
cp "$SKILL_DIR/assets/research-template.md" "$PLAN_DIR/3-RESEARCH.md"
cp "$SKILL_DIR/assets/spec-template.md" "$PLAN_DIR/4-SPEC.md"
echo "Created sample plan files in $PLAN_DIR"

# Basic checks
for f in 3-RESEARCH.md 4-SPEC.md; do
  if [ ! -f "$PLAN_DIR/$f" ]; then
    echo "ERROR: $PLAN_DIR/$f missing"
    exit 2
  fi
done

echo "$PLAN_DIR/3-RESEARCH.md contents:"
head -n 40 "$PLAN_DIR/3-RESEARCH.md" || true

echo "Dry-run succeeded: sample plan contains expected files"
exit 0
