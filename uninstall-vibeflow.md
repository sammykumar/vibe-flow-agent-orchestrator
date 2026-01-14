# Uninstall Vibe Flow

These instructions remove Vibe Flow (Plan-Driven Development) from a codebase and optionally restore the previous instruction file structure.

⚠️ **WARNING**: This process will delete Vibe Flow agents and documentation. If you have active plans in `.github/plans/`, they will be preserved by default, but you may choose to remove them.

## 1. Confirm Uninstallation

Ask the user to confirm before proceeding:

```
⚠️ You are about to uninstall Vibe Flow from this repository.

This will remove:
- All agents from .github/agents/
- All prompts from .github/prompts/
- Vibe Flow documentation from docs/vibeflow/
- AGENTS.md file

Your plans in .github/plans/ will be PRESERVED by default.
Would you like to proceed? (yes/no)
```

If user confirms, continue. If not, exit.

## 2. Backup Current State (Optional but Recommended)

Offer to create a backup before uninstalling:

```bash
# Create a backup directory with timestamp
BACKUP_DIR="vibe-flow-backup-$(date +%Y%m%d-%H%M%S)"
mkdir -p "$BACKUP_DIR"

# Backup agent files
if [ -d ".github/agents" ]; then
    cp -r .github/agents "$BACKUP_DIR/"
fi

# Backup prompt files
if [ -d ".github/prompts" ]; then
    cp -r .github/prompts "$BACKUP_DIR/"
fi

# Backup Vibe Flow docs
if [ -d "docs/vibeflow" ]; then
    cp -r docs/vibeflow "$BACKUP_DIR/"
fi

# Backup AGENTS.md
if [ -f "AGENTS.md" ]; then
    cp AGENTS.md "$BACKUP_DIR/"
fi

echo "✓ Backup created in $BACKUP_DIR"
```

## 3. Remove Agent Files

Delete the `.github/agents/` directory:

```bash
if [ -d ".github/agents" ]; then
    rm -rf .github/agents
    echo "✓ Removed .github/agents/"
else
    echo "ℹ️ .github/agents/ not found"
fi
```

## 4. Remove Prompt Files

Delete the `.github/prompts/` directory:

```bash
if [ -d ".github/prompts" ]; then
    rm -rf .github/prompts
    echo "✓ Removed .github/prompts/"
else
    echo "ℹ️ .github/prompts/ not found"
fi
```

## 5. Remove Vibe Flow Documentation

Delete Vibe Flow-specific documentation:

```bash
if [ -d "docs/vibeflow" ]; then
    rm -rf docs/vibeflow
    echo "✓ Removed docs/vibeflow/"
else
    echo "ℹ️ docs/vibeflow/ not found"
fi
```

## 6. Remove AGENTS.md

```bash
if [ -f "AGENTS.md" ]; then
    rm AGENTS.md
    echo "✓ Removed AGENTS.md"
else
    echo "ℹ️ AGENTS.md not found"
fi
```

## 7. Handle Plans Directory

Ask the user what to do with existing plans:

```
What would you like to do with .github/plans/?

1. Keep plans (RECOMMENDED - preserves project history)
2. Archive plans to vibe-flow-backup/
3. Delete plans permanently (⚠️ DATA LOSS)

Choice (1/2/3):
```

Based on user choice:

**Option 1 (Keep):**

```bash
echo "✓ Plans preserved in .github/plans/"
```

**Option 2 (Archive):**

```bash
if [ -d ".github/plans" ]; then
    cp -r .github/plans "$BACKUP_DIR/"
    rm -rf .github/plans
    echo "✓ Plans archived to $BACKUP_DIR/plans/"
fi
```

**Option 3 (Delete):**

```bash
if [ -d ".github/plans" ]; then
    rm -rf .github/plans
    echo "✓ Plans deleted"
fi
```

## 8. Restore Previous Instructions (Optional)

Check if `docs/unused-instructions.md` exists and offer to restore it:

```bash
if [ -f "docs/unused-instructions.md" ]; then
    echo "Found docs/unused-instructions.md"
    echo "Would you like to restore this as .github/copilot-instructions.md? (yes/no)"
    read RESTORE_CHOICE

    if [ "$RESTORE_CHOICE" = "yes" ]; then
        mkdir -p .github
        cp docs/unused-instructions.md .github/copilot-instructions.md
        rm docs/unused-instructions.md
        echo "✓ Restored .github/copilot-instructions.md"
    fi
fi
```

## 9. Clean Up Empty Directories

Remove empty directories created by Vibe Flow:

```bash
# Remove empty docs subdirectories
if [ -d "docs/architecture" ] && [ -z "$(ls -A docs/architecture)" ]; then
    rmdir docs/architecture
    echo "✓ Removed empty docs/architecture/"
fi

if [ -d "docs/guides" ] && [ -z "$(ls -A docs/guides)" ]; then
    rmdir docs/guides
    echo "✓ Removed empty docs/guides/"
fi

# Remove docs/ if it's now empty
if [ -d "docs" ] && [ -z "$(ls -A docs)" ]; then
    rmdir docs
    echo "✓ Removed empty docs/"
fi

# Remove .github/ if it's now empty
if [ -d ".github" ] && [ -z "$(ls -A .github)" ]; then
    rmdir .github
    echo "✓ Removed empty .github/"
fi
```

## 10. Git Operations (Optional)

Ask if the user wants to commit the changes:

```
Would you like to commit these changes? (yes/no)
```

If yes:

```bash
git add -A
git commit -m "chore: uninstall Vibe Flow agents"
echo "✓ Changes committed"
```

## 11. Report Completion

```markdown
# Vibe Flow Uninstalled

Vibe Flow has been successfully removed from this repository.

**Removed:**

- ✓ .github/agents/ (all agent files)
- ✓ docs/vibeflow/ (Vibe Flow documentation)
- ✓ AGENTS.md

**Preserved:**

- [List based on user choices]

**Backup Location:**

- [Path to backup directory if created]

**Next Steps:**

- If you want to reinstall Vibe Flow in the future, use the install-vibeflow.md instructions.
- Your backup is available at [backup location] if you need to restore anything.
```

## Notes

- **Graceful Degradation**: Handle missing files/directories gracefully (don't error if already deleted).
- **User Confirmation**: Always confirm before destructive operations, especially plan deletion.
- **Backup First**: Strongly encourage creating a backup before proceeding.
- **Preserve History**: Default behavior should preserve plans since they contain valuable project context.
