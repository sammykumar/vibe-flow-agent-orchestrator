# Update Vibe Flow

These instructions update the Vibe Flow (Plan-Driven Development) agents and documentation to the latest version.

<!-- version: 2.0.0 -->

Process overview:

1. Check for existing installation
2. Check for Latest Version
3. Fetch Agent Profiles
4. Refresh Repo-Specific Skills (Registry + Local)
5. Report to the user

## 1. Check for existing installation

- Verify that `.github/agents/vibe-flow.agent.md` exists.
- If it does not exist, STOP and advise the user to run `install-vibeflow.md` instead.

## 2. Check for Latest Version

Before fetching, check the latest version tag from GitHub:

```bash
# Fetch tags, filter for those starting with "v" (to ignore "latest"), pick the top one
LATEST_TAG=$(curl -s https://api.github.com/repos/sammykumar/vibe-flow-agent-orchestrator/tags | grep '"name": "v' | head -n 1 | cut -d '"' -f 4)
echo "Latest Vibe Flow version: $LATEST_TAG"
```

## 3. Fetch Agent Profiles

Download the incremental agent set to `.github/agents`. Existing agents will be overwritten with the latest versions:

- Fetch [vibe-flow.agent.md](https://raw.githubusercontent.com/sammykumar/vibe-flow-agent-orchestrator/${LATEST_TAG:-master}/.github/agents/vibe-flow.agent.md) to `.github/agents/vibe-flow.agent.md`
- Fetch [research.agent.md](https://raw.githubusercontent.com/sammykumar/vibe-flow-agent-orchestrator/${LATEST_TAG:-master}/.github/agents/research.agent.md) to `.github/agents/research.agent.md`
- Fetch [pdd-protocol.md](https://raw.githubusercontent.com/sammykumar/vibe-flow-agent-orchestrator/${LATEST_TAG:-master}/docs/vibeflow/pdd-protocol.md) to `docs/vibeflow/pdd-protocol.md`
- Fetch [orchestrator-manual.md](https://raw.githubusercontent.com/sammykumar/vibe-flow-agent-orchestrator/${LATEST_TAG:-master}/docs/vibeflow/orchestrator-manual.md) to `docs/vibeflow/orchestrator-manual.md`
- Fetch [new-feature.prompt.md](https://raw.githubusercontent.com/sammykumar/vibe-flow-agent-orchestrator/${LATEST_TAG:-master}/prompts/new-feature.prompt.md) to `.github/prompts/new-feature.prompt.md`
- Fetch [update-feature.prompt.md](https://raw.githubusercontent.com/sammykumar/vibe-flow-agent-orchestrator/${LATEST_TAG:-master}/prompts/update-feature.prompt.md) to `.github/prompts/update-feature.prompt.md`

### 3.1 Fetch Skills

Create `.github/skills/orchestration/` directory (with subdirectories `assets/` and `references/`) if it doesn't exist and download the orchestration skill:

**Main Skill File:**

- Fetch [orchestration/SKILL.md](https://raw.githubusercontent.com/sammykumar/vibe-flow-agent-orchestrator/${LATEST_TAG:-master}/.github/skills/orchestration/SKILL.md) to `.github/skills/orchestration/SKILL.md`

**PDD Templates (assets/):**

- Fetch [orchestration/assets/overview-template.md](https://raw.githubusercontent.com/sammykumar/vibe-flow-agent-orchestrator/${LATEST_TAG:-master}/.github/skills/orchestration/assets/overview-template.md) to `.github/skills/orchestration/assets/overview-template.md`
- Fetch [orchestration/assets/progress-log-template.md](https://raw.githubusercontent.com/sammykumar/vibe-flow-agent-orchestrator/${LATEST_TAG:-master}/.github/skills/orchestration/assets/progress-log-template.md) to `.github/skills/orchestration/assets/progress-log-template.md`
- Fetch [orchestration/assets/research-template.md](https://raw.githubusercontent.com/sammykumar/vibe-flow-agent-orchestrator/${LATEST_TAG:-master}/.github/skills/orchestration/assets/research-template.md) to `.github/skills/orchestration/assets/research-template.md`
- Fetch [orchestration/assets/spec-template.md](https://raw.githubusercontent.com/sammykumar/vibe-flow-agent-orchestrator/${LATEST_TAG:-master}/.github/skills/orchestration/assets/spec-template.md) to `.github/skills/orchestration/assets/spec-template.md`
- Fetch [orchestration/assets/plan-template.md](https://raw.githubusercontent.com/sammykumar/vibe-flow-agent-orchestrator/${LATEST_TAG:-master}/.github/skills/orchestration/assets/plan-template.md) to `.github/skills/orchestration/assets/plan-template.md`

**Workflow Patterns (references/):**

- Fetch [orchestration/references/workflow.md](https://raw.githubusercontent.com/sammykumar/vibe-flow-agent-orchestrator/${LATEST_TAG:-master}/.github/skills/orchestration/references/workflow.md) to `.github/skills/orchestration/references/workflow.md`

### 3.2 Verify Update

After fetching, verify the following files exist and were updated:

**Agents:**

- `.github/agents/vibe-flow.agent.md` contains the `version:` comment (e.g., `<!-- version: 2.0.0 -->`)
- `.github/agents/research.agent.md`

**Skills:**

- `.github/skills/orchestration/SKILL.md`
- `.github/skills/orchestration/assets/overview-template.md`
- `.github/skills/orchestration/assets/progress-log-template.md`
- `.github/skills/orchestration/assets/research-template.md`
- `.github/skills/orchestration/assets/spec-template.md`
- `.github/skills/orchestration/assets/plan-template.md`
- `.github/skills/orchestration/references/workflow.md`

**Documentation:**

- `docs/vibeflow/pdd-protocol.md`
- `docs/vibeflow/orchestrator-manual.md`

**Prompts:**

- `.github/prompts/new-feature.prompt.md`
- `.github/prompts/update-feature.prompt.md`

## 4. Refresh Repo-Specific Skills (Registry + Local)

Re-run the install-time discovery to keep repo-specific skills in sync as the project evolves.

1. Scan for new or removed technology signals (same rules as installation).
2. Compare with `.github/skills/skills-manifest.json`.
3. For new skills, install from registries (Skills Directory, internal repo, or other curated source).
4. For removed signals, mark the skill as inactive in the manifest or remove it if it’s no longer needed.
5. Refresh the `<available_skills>` list in `vibe-flow.agent.md` so metadata stays current.

Registry options:

- Skills Directory: https://www.skillsdirectory.com/skills
- Agent Skills examples: https://github.com/anthropics/skills
- Internal/private repos

## 5. Configure VS Code

You MUST ensure the `.vscode/settings.json` file is configured to suggest the PDD prompts.

1.  **Check for Existence**: Check if `.vscode/settings.json` exists.
2.  **Create if Missing**: If it does not exist, create it with `{}`.
3.  **Merge Settings**: Read the file and merge the following configuration into it. Do NOT overwrite existing unrelated settings.

```json
{
  "chat.promptFilesRecommendations": {
    ".github/prompts/new-feature.prompt.md": true,
    ".github/prompts/update-feature.prompt.md": true
  }
}
```

## 6. Report to the User

Report which agents were upgraded:

```markdown
# Vibe Flow Updated

The following agents have been updated to the latest version (${LATEST_TAG}):

- vibe-flow.agent.md
- research.agent.md
- docs/vibeflow/pdd-protocol.md
- docs/vibeflow/orchestrator-manual.md
- .github/prompts/new-feature.prompt.md
- .github/prompts/update-feature.prompt.md
- .github/skills/orchestration/SKILL.md
- .github/skills/orchestration/assets/ (5 PDD templates)
- .github/skills/orchestration/references/workflow.md

All agent profiles, prompts, and skills are now in sync with the official repository.
```
