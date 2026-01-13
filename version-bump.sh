#!/bin/bash

# Version bump script for vibe-flow.agent.md
# Usage: ./version-bump.sh [major|minor|patch]

BUMP_TYPE="${1:-patch}"
AGENT_FILE="vibe-flow.agent.md"

# Extract current version
CURRENT_VERSION=$(sed -n 's/.*<!-- version: \([0-9.]*\) -->.*/\1/p' "$AGENT_FILE")

if [ -z "$CURRENT_VERSION" ]; then
    echo "Error: Could not find version in $AGENT_FILE"
    exit 1
fi

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

# Update version in file
sed -i "" "s/<!-- version: .* -->/<!-- version: $NEW_VERSION -->/" "$AGENT_FILE"

echo "Version bumped from $CURRENT_VERSION to $NEW_VERSION"

# Git operations
git add "$AGENT_FILE"
git commit -m "chore: bump version to $NEW_VERSION"
git push origin

echo "✓ Version $NEW_VERSION committed and pushed"
