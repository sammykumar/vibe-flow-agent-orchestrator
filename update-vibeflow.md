# Update Vibe Flow

These instructions update the Vibe Flow (Plan-Driven Development) agents and documentation to the latest version.

<!-- version: 2.2.2 -->

Process overview:

1. Check for existing installation
2. Check for Latest Version
3. Fetch Agent Profiles
4. Refresh Repo-Specific Skills (Registry + Local)
5. Configure VS Code
6. Migrate 5-PLAN.md → 5-TASKS.md
7. Report to the user

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
- Fetch [plan-writer.agent.md](https://raw.githubusercontent.com/sammykumar/vibe-flow-agent-orchestrator/${LATEST_TAG:-master}/.github/agents/plan-writer.agent.md) to `.github/agents/plan-writer.agent.md`
- Fetch [implement.agent.md](https://raw.githubusercontent.com/sammykumar/vibe-flow-agent-orchestrator/${LATEST_TAG:-master}/.github/agents/implement.agent.md) to `.github/agents/implement.agent.md`
- Fetch [pdd-protocol.md](https://raw.githubusercontent.com/sammykumar/vibe-flow-agent-orchestrator/${LATEST_TAG:-master}/docs/vibeflow/pdd-protocol.md) to `docs/vibeflow/pdd-protocol.md`
- Fetch [orchestrator-manual.md](https://raw.githubusercontent.com/sammykumar/vibe-flow-agent-orchestrator/${LATEST_TAG:-master}/docs/vibeflow/orchestrator-manual.md) to `docs/vibeflow/orchestrator-manual.md`
- Fetch [new-feature.prompt.md](https://raw.githubusercontent.com/sammykumar/vibe-flow-agent-orchestrator/${LATEST_TAG:-master}/.github/prompts/new-feature.prompt.md) to `.github/prompts/new-feature.prompt.md`
- Fetch [update-feature.prompt.md](https://raw.githubusercontent.com/sammykumar/vibe-flow-agent-orchestrator/${LATEST_TAG:-master}/.github/prompts/update-feature.prompt.md) to `.github/prompts/update-feature.prompt.md`
- Fetch [plan-only.prompt.md](https://raw.githubusercontent.com/sammykumar/vibe-flow-agent-orchestrator/${LATEST_TAG:-master}/.github/prompts/plan-only.prompt.md) to `.github/prompts/plan-only.prompt.md`

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

**Research Skill:**

- Fetch `.github/skills/research/SKILL.md` to `.github/skills/research/SKILL.md`
- Fetch `.github/skills/research/assets/research-template.md` to `.github/skills/research/assets/research-template.md`
- Fetch `.github/skills/research/assets/spec-template.md` to `.github/skills/research/assets/spec-template.md`
- Fetch `.github/skills/research/assets/progress-log-template.md` to `.github/skills/research/assets/progress-log-template.md`
- Fetch `.github/skills/research/references/REFERENCE.md` to `.github/skills/research/references/REFERENCE.md`

**Mermaid.js v11 Skill:**

- Fetch `.github/skills/mermaidjs-v11/SKILL.md` to `.github/skills/mermaidjs-v11/SKILL.md`
- Fetch `.github/skills/mermaidjs-v11/references/diagram-types.md` to `.github/skills/mermaidjs-v11/references/diagram-types.md`
- Fetch `.github/skills/mermaidjs-v11/references/configuration.md` to `.github/skills/mermaidjs-v11/references/configuration.md`
- Fetch `.github/skills/mermaidjs-v11/references/cli-usage.md` to `.github/skills/mermaidjs-v11/references/cli-usage.md`
- Fetch `.github/skills/mermaidjs-v11/references/integration.md` to `.github/skills/mermaidjs-v11/references/integration.md`
- Fetch `.github/skills/mermaidjs-v11/references/examples.md` to `.github/skills/mermaidjs-v11/references/examples.md`

**Skills Creator Skill:**

- Fetch `.github/skills/skills-creator/SKILL.md` to `.github/skills/skills-creator/SKILL.md`
- Fetch `.github/skills/skills-creator/LICENSE.txt` to `.github/skills/skills-creator/LICENSE.txt`
- Fetch `.github/skills/skills-creator/references/output-patterns.md` to `.github/skills/skills-creator/references/output-patterns.md`
- Fetch `.github/skills/skills-creator/references/workflows.md` to `.github/skills/skills-creator/references/workflows.md`
- Fetch `.github/skills/skills-creator/scripts/init_skill.py` to `.github/skills/skills-creator/scripts/init_skill.py`
- Fetch `.github/skills/skills-creator/scripts/package_skill.py` to `.github/skills/skills-creator/scripts/package_skill.py`
- Fetch `.github/skills/skills-creator/scripts/quick_validate.py` to `.github/skills/skills-creator/scripts/quick_validate.py`

### 3.2 Verify Update

After fetching, verify the following files exist and were updated:

**Agents:**

- `.github/agents/vibe-flow.agent.md` contains the `version:` comment (e.g., `<!-- version: 2.0.0 -->`)
- `.github/agents/research.agent.md`
- `.github/agents/plan-writer.agent.md`
- `.github/agents/implement.agent.md`

**Skills:**

- `.github/skills/orchestration/SKILL.md`
- `.github/skills/orchestration/assets/overview-template.md`
- `.github/skills/orchestration/assets/progress-log-template.md`
- `.github/skills/orchestration/assets/research-template.md`
- `.github/skills/orchestration/assets/spec-template.md`
- `.github/skills/orchestration/assets/plan-template.md`
- `.github/skills/orchestration/references/workflow.md`
- `.github/skills/research/SKILL.md`
- `.github/skills/research/assets/research-template.md`
- `.github/skills/research/assets/spec-template.md`
- `.github/skills/research/assets/progress-log-template.md`
- `.github/skills/research/references/REFERENCE.md`
- `.github/skills/mermaidjs-v11/SKILL.md`
- `.github/skills/mermaidjs-v11/references/diagram-types.md`
- `.github/skills/mermaidjs-v11/references/configuration.md`
- `.github/skills/mermaidjs-v11/references/cli-usage.md`
- `.github/skills/mermaidjs-v11/references/integration.md`
- `.github/skills/mermaidjs-v11/references/examples.md`
- `.github/skills/skills-creator/SKILL.md`
- `.github/skills/skills-creator/LICENSE.txt`
- `.github/skills/skills-creator/references/output-patterns.md`
- `.github/skills/skills-creator/references/workflows.md`
- `.github/skills/skills-creator/scripts/init_skill.py`
- `.github/skills/skills-creator/scripts/package_skill.py`
- `.github/skills/skills-creator/scripts/quick_validate.py`

**Documentation:**

- `docs/vibeflow/pdd-protocol.md`
- `docs/vibeflow/orchestrator-manual.md`

**Prompts:**

- `.github/prompts/new-feature.prompt.md`
- `.github/prompts/update-feature.prompt.md`
- `.github/prompts/plan-only.prompt.md`

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
    ".github/prompts/update-feature.prompt.md": true,
    ".github/prompts/plan-only.prompt.md": true
  }
}
```

## 6. Migration: 5-PLAN.md → 5-TASKS.md

Existing plan directories may still use `5-PLAN.md`. Migrate them to the new task file name:

1. For each plan folder in `.github/plans/**/` that contains `5-PLAN.md`, rename it to `5-TASKS.md`.
2. Update any internal references within the plan folder (e.g., `2-PROGRESS.md`, `4-SPEC.md`, `1-OVERVIEW.md`) to point to `5-TASKS.md`.
3. Ensure future planning uses `5-TASKS.md` only; do not recreate `5-PLAN.md`.

## 7. Report to the User

Report which agents were upgraded:

```markdown
# Vibe Flow Updated

The following agents have been updated to the latest version (${LATEST_TAG}):

- vibe-flow.agent.md
- research.agent.md
- plan-writer.agent.md
- implement.agent.md
- docs/vibeflow/pdd-protocol.md
- docs/vibeflow/orchestrator-manual.md
- .github/prompts/new-feature.prompt.md
- .github/prompts/update-feature.prompt.md
- .github/skills/orchestration/SKILL.md
- .github/skills/orchestration/assets/ (5 PDD templates)
- .github/skills/orchestration/references/workflow.md
- .github/skills/research/SKILL.md
- .github/skills/mermaidjs-v11/SKILL.md

All agent profiles, prompts, and skills are now in sync with the official repository.
```
