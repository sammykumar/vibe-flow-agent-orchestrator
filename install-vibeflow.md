# Bootstrap Vibe Flow

These instructions install Vibe Flow (Plan-Driven Development) in a codebase. They produce a structured documentation set, agent profiles, and PDD workflow scaffolding.

<!-- version: 2.2.1 -->

This bootstrap script is for **initial installation**. For updates, use `update-vibeflow.md`.

Process overview:

1. Initial checks
2. Determine the START_FILE
3. Create directories
4. Move START_FILE to `docs/Unused Instructions.md`
5. Extract and infer documentation
6. Check for Latest Version
7. Install Vibe Flow Agents
8. Install Repo-Specific Skills (Registry + Local)
9. Configure VS Code
10. Create repo-wide Copilot instructions
11. Handle Links from UNUSED_FILE
12. Refresh instructions files
13. Report to the user

When complete, the repository will include a Vibe Flow agent architecture. The target structure is:

```text
docs/
├── architecture/
│   └── diagrams/
├── api/
├── guides/
│   ├── code-style.md
│   └── testing-strategy.md
├── vibeflow/
│   ├── pdd-protocol.md
│   └── orchestrator-manual.md
├── unused-instructions.md
└── writing-documentation.md
.github/
├── agents/
│   ├── vibe-flow.agent.md
│   ├── research.agent.md
│   ├── plan-writer.agent.md
│   └── implement.agent.md
├── skills/
│   └── orchestration/
│       └── SKILL.md
├── plans/
│   ├── todo/
│   ├── in-progress/
│   └── finished/
.github/copilot-instructions.md
```

## 1. Initial Checks

- If this is a git repository, verify the working tree is clean. DO NOT PROCEED WITHOUT CONFIRMATION IF THERE ARE UNCOMMITTED CHANGES.
- Check if `docs/vibeflow/` directory exists. If it already exists, assume Vibe Flow is installed and ask how to proceed.
- Check if `.github/plans/` exists. If so, PDD is already active.

## 2. Determine the local START_FILE

The **START_FILE** is the primary, local AI instructions file used by this repository.

Search the codebase for candidate files using this glob pattern: `**/{.github/copilot-instructions.md,AGENT.md,AGENTS.md,CLAUDE.md,.cursorrules,.windsurfrules,.clinerules,.cursor/rules/**,.windsurf/rules/**,.clinerules/**,GEMINI.md}`.

- If one or more files are found, pick the most complete and up-to-date as the START_FILE.
- If none are found:
  - If you are GitHub Copilot in VS Code: you MUST STOP NOW and ask the user to press CTRL+SHIFT+P (or CMD+SHIFT+P), then run "Chat: Generate Workspace Instructions File".
  - Otherwise, create an empty `.github/copilot-instructions.md` and use it as START_FILE.

## 3. Create Directories & Migrate Legacy Structure

**Migrate Legacy Folders**:

- If `_docs` folder exists:
  - If `docs` does not exist: Rename `_docs` to `docs`.
  - If `docs` exists: Move `_docs/*` to `docs/` and remove `_docs`.
- If `_plans` folder exists:
  - Ensure `.github` directory exists.
  - If `.github/plans` does not exist: Rename `_plans` to `.github/plans`.
  - If `.github/plans` exists: Move `_plans/*` to `.github/plans/` and remove `_plans`.

**Establish Vibe Flow Structure**:

- Create directories `docs`, `.github/plans`, `.github/agents`, and `.github/prompts` at the repository root if they do not exist.
- Create subdirectories `docs/vibeflow`, `docs/guides`, `docs/architecture`, `docs/architecture/diagrams`.
- Create PDD state folders: `.github/plans/todo`, `.github/plans/in-progress`, `.github/plans/finished`.
- Create `.github/plans/.gitkeep`.

If `.gitignore` exists, ensure it includes:

```text
# Vibe Flow Plans (Do NOT Ignore plans, they are project memory)
# Ignore temp files if any
```

## 4. Move START_FILE to `docs/unused-instructions.md`

1. Check if `docs/unused-instructions.md` already exists. If it exists, stop.
2. Move START_FILE content into `docs/unused-instructions.md` with title `# Unused Instructions`. Remove START_FILE.
3. Call this **UNUSED_FILE**.

## 5. Extract and Infer Documentation

Extract documents from UNUSED_FILE and infer project conventions.

### 5.1. Code Style

Create `docs/guides/code-style.md` with code style rules. Extract from UNUSED_FILE and infer from codebase.

### 5.2. Testing Strategy

Create `docs/guides/testing-strategy.md` explaining how tests are written and run. Extract from UNUSED_FILE and infer from codebase.

### 5.3. PDD Protocol

The PDD Protocol will be fetched from the official repository in step 7 along with the agents.

## 6. Check for Latest Version

Before fetching, check the latest version tag from GitHub:

```bash
# Fetch tags, filter for those starting with "v" (to ignore "latest"), pick the top one
LATEST_TAG=$(curl -s https://api.github.com/repos/sammykumar/vibe-flow-agent-orchestrator/tags | grep '"name": "v' | head -n 1 | cut -d '"' -f 4)
echo "Latest Vibe Flow version: $LATEST_TAG"
```

## 7. Install Vibe Flow Agents

Use `curl` or `wget` to fetch agent profiles from the official repository:
https://github.com/sammykumar/vibe-flow-agent-orchestrator

### 7.1 Fetch Agent Profiles

Download the incremental agent set to `.github/agents`:

- Fetch [vibe-flow.agent.md](https://raw.githubusercontent.com/sammykumar/vibe-flow-agent-orchestrator/${LATEST_TAG:-master}/.github/agents/vibe-flow.agent.md) to `.github/agents/vibe-flow.agent.md`
- Fetch [research.agent.md](https://raw.githubusercontent.com/sammykumar/vibe-flow-agent-orchestrator/${LATEST_TAG:-master}/.github/agents/research.agent.md) to `.github/agents/research.agent.md`
- Fetch [plan-writer.agent.md](https://raw.githubusercontent.com/sammykumar/vibe-flow-agent-orchestrator/${LATEST_TAG:-master}/.github/agents/plan-writer.agent.md) to `.github/agents/plan-writer.agent.md`
- Fetch [implement.agent.md](https://raw.githubusercontent.com/sammykumar/vibe-flow-agent-orchestrator/${LATEST_TAG:-master}/.github/agents/implement.agent.md) to `.github/agents/implement.agent.md`
- Fetch [pdd-protocol.md](https://raw.githubusercontent.com/sammykumar/vibe-flow-agent-orchestrator/${LATEST_TAG:-master}/docs/vibeflow/pdd-protocol.md) to `docs/vibeflow/pdd-protocol.md`
- Fetch [orchestrator-manual.md](https://raw.githubusercontent.com/sammykumar/vibe-flow-agent-orchestrator/${LATEST_TAG:-master}/docs/vibeflow/orchestrator-manual.md) to `docs/vibeflow/orchestrator-manual.md`
- Fetch [new-feature.prompt.md](https://raw.githubusercontent.com/sammykumar/vibe-flow-agent-orchestrator/${LATEST_TAG:-master}/.github/prompts/new-feature.prompt.md) to `.github/prompts/new-feature.prompt.md`
- Fetch [update-feature.prompt.md](https://raw.githubusercontent.com/sammykumar/vibe-flow-agent-orchestrator/${LATEST_TAG:-master}/.github/prompts/update-feature.prompt.md) to `.github/prompts/update-feature.prompt.md`
- Fetch [plan-only.prompt.md](https://raw.githubusercontent.com/sammykumar/vibe-flow-agent-orchestrator/${LATEST_TAG:-master}/.github/prompts/plan-only.prompt.md) to `.github/prompts/plan-only.prompt.md`

### 7.2 Fetch Skills

Create `.github/skills/orchestration/` directory (with subdirectories `assets/` and `references/`) and download the orchestration skill:

**Main Skill File:**

- Fetch [orchestration/SKILL.md](https://raw.githubusercontent.com/sammykumar/vibe-flow-agent-orchestrator/${LATEST_TAG:-master}/.github/skills/orchestration/SKILL.md) to `.github/skills/orchestration/SKILL.md`

**PDD Templates (assets/):**

- Fetch [orchestration/assets/overview-template.md](https://raw.githubusercontent.com/sammykumar/vibe-flow-agent-orchestrator/${LATEST_TAG:-master}/.github/skills/orchestration/assets/overview-template.md) to `.github/skills/orchestration/assets/overview-template.md`
- Fetch [orchestration/assets/progress-log-template.md](https://raw.githubusercontent.com/sammykumar/vibe-flow-agent-orchestrator/${LATEST_TAG:-master}/.github/skills/orchestration/assets/progress-log-template.md) to `.github/skills/orchestration/assets/progress-log-template.md`
- Fetch [orchestration/assets/research-template.md](https://raw.githubusercontent.com/sammykumar/vibe-flow-agent-orchestrator/${LATEST_TAG:-master}/.github/skills/orchestration/assets/research-template.md) to `.github/skills/orchestration/assets/research-template.md`
- Fetch [orchestration/assets/spec-template.md](https://raw.githubusercontent.com/sammykumar/vibe-flow-agent-orchestrator/${LATEST_TAG:-master}/.github/skills/orchestration/assets/spec-template.md) to `.github/skills/orchestration/assets/spec-template.md`
- Fetch [orchestration/assets/plan-template.md](https://raw.githubusercontent.com/sammykumar/vibe-flow-agent-orchestrator/${LATEST_TAG:-master}/.github/skills/orchestration/assets/plan-template.md) to `.github/skills/orchestration/assets/plan-template.md`

**Research Skill:**

- Fetch `.github/skills/research/SKILL.md` to `.github/skills/research/SKILL.md`
- Fetch `.github/skills/research/assets/research-template.md` to `.github/skills/research/assets/research-template.md`
- Fetch `.github/skills/research/assets/spec-template.md` to `.github/skills/research/assets/spec-template.md`
- Fetch `.github/skills/research/assets/progress-log-template.md` to `.github/skills/research/assets/progress-log-template.md`
- Fetch `.github/skills/research/references/REFERENCE.md` to `.github/skills/research/references/REFERENCE.md`
- Fetch `.github/skills/research/scripts/validate-skill.sh` to `.github/skills/research/scripts/validate-skill.sh` (run it as a post-install verification step)

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

**Workflow Patterns (references/):**

- Fetch [orchestration/references/workflow.md](https://raw.githubusercontent.com/sammykumar/vibe-flow-agent-orchestrator/${LATEST_TAG:-master}/.github/skills/orchestration/references/workflow.md) to `.github/skills/orchestration/references/workflow.md`

### 7.3 Verify Installation

After fetching, verify the following files exist:

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

Ensure you use the raw content URLs and install them to their respective locations.

## 8. Install Repo-Specific Skills (Registry + Local)

This step implements **Option A**: discover skills at install/update time (no runtime scanning).

### 8.1 Discovery (signals)

Scan the repo for common technology signals and create a short list of candidate skills. Examples:

- **Node/TypeScript**: `package.json`, `tsconfig.json`, dependencies like `typescript`, `ts-node`, `eslint`
- **Python**: `pyproject.toml`, `requirements.txt`, `Pipfile`, `poetry.lock`
- **Infrastructure**: `terraform/`, `*.tf`, `docker-compose.yml`, `kubernetes/`
- **Cloud**: `azure-pipelines.yml`, `bicep/`, `arm-templates/`, `aws/`, `gcp/`
- **Cosmos DB**: dependencies like `@azure/cosmos` or `azure-cosmos`, config entries containing `cosmos` or `CosmosClient`

### 8.2 Map signals → skills

Maintain a small mapping table (inline or in `docs/vibeflow/skills-map.md`) that connects signals to skills. Keep it human-editable.

### 8.3 Registry options

Install skills from one or more registries/sources:

- **Skills Directory**: https://www.skillsdirectory.com/skills
  - Each skill page provides a copy-paste install command (often a Git clone).
- **Agent Skills example repo**: https://github.com/anthropics/skills
- **Internal/private repos**: team skills or org-specific workflows

### 8.4 Install location

Install skills into `.github/skills/<skill-name>/` within the target repo.

### 8.5 Record a manifest

Create or update `.github/skills/skills-manifest.json` with entries like:

- `name`
- `source` (Skills Directory URL, Git repo URL, or internal reference)
- `installCommand` (if available)
- `detectedBy` (signals that triggered installation)
- `version` (tag/commit if known)
- `installedAt`

### 8.6 Update available skills metadata

If your agent surface supports an `<available_skills>` section (as in `vibe-flow.agent.md`), append the installed skills’ **name**, **description**, and **location** to that list so discovery is fast and activation remains on-demand.

## 9. Configure VS Code

You MUST ensure the `.vscode/settings.json` file exists and contains the prompt file recommendations.

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

## 10. Create repo-wide Copilot instructions

Follow the GitHub Copilot standard for repository-wide instructions:
https://docs.github.com/en/copilot/how-tos/configure-custom-instructions/add-repository-instructions#creating-repository-wide-custom-instructions-1

Create `.github/copilot-instructions.md` and populate it with repo-specific guidance.

**If `AGENTS.md` exists**, migrate any relevant content into `.github/copilot-instructions.md` and then delete `AGENTS.md`.

### Content guidelines (best practices)

Your repo-wide instructions should be concise, actionable, and grounded in facts from the repo. Include:

1. **Project context & goals**

- One paragraph summary of the repo’s purpose.

2. **Preferred workflows**

- Reference Vibe Flow: use `@vibe-flow` for complex tasks.
- Mention the Plan-Driven Development flow and where plan files live.

3. **Code style & conventions**

- Link to [docs/guides/code-style.md](docs/guides/code-style.md) and summarize key points.

4. **Testing strategy**

- Link to [docs/guides/testing-strategy.md](docs/guides/testing-strategy.md) and specify how to run tests.

5. **Repository structure & key docs**

- Mention `docs/vibeflow/pdd-protocol.md` and `docs/vibeflow/orchestrator-manual.md`.

6. **Constraints & non-goals**

- Call out anything the install inferred (e.g., no tests yet, or required tools).

7. **Instruction scope**

- Clarify that instructions should be followed and that unspecified changes should preserve existing patterns.

### Content sources (what install-vibeflow learned)

Use these as authoritative inputs when writing instructions:

- **UNUSED_FILE** content (former START_FILE)
- `docs/guides/code-style.md`
- `docs/guides/testing-strategy.md`
- `docs/vibeflow/pdd-protocol.md`
- `docs/vibeflow/orchestrator-manual.md`
- Any detected tech signals from Step 8 (e.g., `package.json`, build tools)

## 11. Handle Links from UNUSED_FILE

- Scan UNUSED_FILE for links to deprecated docs.
- If relevant content exists, move links to `.github/copilot-instructions.md` (manually).

## 12. Refresh instructions files

Delete every file in `INSTRUCTIONS_FILES` (from Step 2) except `.github/copilot-instructions.md`.

## 13. Report to the User

Fill in the template for **first-time installation**:

````markdown
# Vibe Flow Installed

The {START_FILE} instructions have been migrated to `docs/unused-instructions.md`.
Vibe Flow (Plan-Driven Development) is now active.

**New Structure**:

- `.github/agents/vibe-flow.agent.md` (Orchestrator v${LATEST_TAG} - single source of truth for version)
- `.github/copilot-instructions.md` (Repo-wide Copilot instructions)
- `docs/vibeflow/pdd:

```markdown
# Vibe Flow Installed

The {START_FILE} instructions have been migrated to `docs/unused-instructions.md`.
Vibe Flow (Plan-Driven Development) is now active.

**New Structure**:

- `.github/agents/vibe-flow.agent.md` (Orchestrator v${LATEST_TAG} - single source of truth for version)
- `.github/copilot-instructions.md` (Repo-wide Copilot instructions)
- `docs/vibeflow/pdd-protocol.md` (Vibe Flow Protocol)
- `.github/agents/research.agent.md` (Research Agent)
- `.github/agents/plan-writer.agent.md` (Plan Writer Agent)
- `.github/agents/implement.agent.md` (Implement Agent)
- `.github/skills/orchestration/` (Orchestration skill with PDD templates and workflow patterns)
- `.github/prompts/` (Interactive Prompts)
- `.github/plans/` (Project Memory)

**Note**: The vibe-flow orchestrator version is the single source of truth. All subagents are versioned together as a suite.

**To start a task**:
"@vibe-flow Implement {feature_name}"
```
````
