#!/bin/bash

# Version bump script for Vibe Flow orchestrator (single source of truth)
# Usage: ./version-bump.sh [major|minor|patch]

BUMP_TYPE="${1:-patch}"
AGENT_FILE="agents/vibe-flow.agent.md"

# Extract current version from main orchestrator (single source of truth)
CURRENT_VERSION=$(sed -n 's/.*<!-- version: \([0-9.]*\) -->.*/\1/p' "$AGENT_FILE")

if [ -z "$CURRENT_VERSION" ]; then
    echo "Error: Could not find version in $AGENT_FILE"
    exit 1
fi

echo "Current version: $CURRENT_VERSION"

# Parse version
IFS="." read -r MAJOR MINOR PATCH <<< "$CURRENT_VERSION"

# Bump version based on type
case $BUMP_TYPE in
    major)
        MAJOR=$((MAJOR + 1))
        MINOR=0
        PATCH=0
        ;;
    minor)
        MINOR=$((MINOR + 1))
        PATCH=0
        ;;
    patch)
        PATCH=$((PATCH + 1))
        ;;
    *)
        echo "Error: Invalid bump type '$BUMP_TYPE'. Use major, minor, or patch."
        exit 1
        ;;
esac

NEW_VERSION="$MAJOR.$MINOR.$PATCH"

echo "Bumping to version: $NEW_VERSION"

# Update version in orchestrator file (single source of truth)
sed -i "" "s/<!-- version: .* -->/<!-- version: $NEW_VERSION -->/" "$AGENT_FILE"

echo "Version bumped from $CURRENT_VERSION to $NEW_VERSION in $AGENT_FILE"

# Git operations
git add "$AGENT_FILE"
git commit -m "chore: bump version to $NEW_VERSION"
git push origin

echo "✓ Version $NEW_VERSION committed and pushed"

# Create and push tag
git tag -m "Version $NEW_VERSION" "v$NEW_VERSION"
git push origin "v$NEW_VERSION"

echo "✓ Tag v$NEW_VERSION created and pushed"