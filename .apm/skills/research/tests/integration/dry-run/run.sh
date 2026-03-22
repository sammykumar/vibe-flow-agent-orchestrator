#!/usr/bin/env bash
set -euo pipefail
HERE=$(cd "$(dirname "$0")/../../../" && pwd)
SCRIPTS_DIR="$HERE/scripts"
TEST_ROOT=$(mktemp -d)

echo "Running integration dry-run test"

# Run dry run and capture output
DRY_OUT=$(bash "$SCRIPTS_DIR/dry_run.sh" 2>&1 || true)

# Parse output for created path
TMP_PLAN=$(echo "$DRY_OUT" | sed -n 's/^Created sample plan files in //p' | tr -d '\r' | head -n 1)
if [ -z "$TMP_PLAN" ]; then
  # Fallback: try common temp locations
  TMP_PLAN=$(ls -d /tmp/*/sample-plan 2>/dev/null | head -n 1 || true)
fi
if [ -z "$TMP_PLAN" ]; then
  TMP_PLAN=$(find /var/folders -type d -name "sample-plan" 2>/dev/null | head -n 1 || true)
fi
if [ -z "$TMP_PLAN" ]; then
  echo "ERROR: sample-plan not found on disk"
  echo "Dry run output:"
  echo "$DRY_OUT"
  exit 2
fi


for f in 3-RESEARCH.md 4-SPEC.md; do
  if ! grep -q "#" "$TMP_PLAN/$f"; then
    echo "ERROR: expected header in $TMP_PLAN/$f"
    exit 3
  fi
done

echo "Integration dry-run passed"
exit 0
