# Bootstrap Vibe Flow

These instructions install Vibe Flow (Plan-Driven Development) in a codebase. They produce a structured documentation set, agent profiles, and PDD workflow scaffolding.

<!-- version: 1.3.0 -->

This bootstrap script is for **initial installation**. For updates, use `update-vibeflow.md`.

Process overview:

1. Initial checks
2. Determine the START_FILE
3. Create directories
4. Move START_FILE to `docs/Unused Instructions.md`
5. Extract and infer documentation
6. Install Vibe Flow Agents
7. Create `AGENTS.md`
8. Handle Links from UNUSED_FILE
9. Refresh instructions files
10. Report to the user

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
│   ├── implement.agent.md
│   ├── test.agent.md
│   └── document.agent.md
├── skills/
│   └── orchestration/
│       └── SKILL.md
├── plans/
│   ├── todo/
│   ├── in-progress/
│   └── finished/
AGENTS.md
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

The PDD Protocol will be fetched from the official repository in step 6 along with the agents.

## 6. Install Vibe Flow Agents

Use `curl` or `wget` to fetch agent profiles from the official repository:
https://github.com/sammykumar/vibe-flow-agent-orchestrator

### 6.1 Fetch Agent Profiles

Download all agents to `.github/agents`:

- Fetch [vibe-flow.agent.md](https://raw.githubusercontent.com/sammykumar/vibe-flow-agent-orchestrator/master/agents/vibe-flow.agent.md) to `.github/agents/vibe-flow.agent.md`
- Fetch [research.agent.md](https://raw.githubusercontent.com/sammykumar/vibe-flow-agent-orchestrator/master/agents/subagents/research.agent.md) to `.github/agents/research.agent.md`
- Fetch [implement.agent.md](https://raw.githubusercontent.com/sammykumar/vibe-flow-agent-orchestrator/master/agents/subagents/implement.agent.md) to `.github/agents/implement.agent.md`
- Fetch [test.agent.md](https://raw.githubusercontent.com/sammykumar/vibe-flow-agent-orchestrator/master/agents/subagents/test.agent.md) to `.github/agents/test.agent.md`
- Fetch [document.agent.md](https://raw.githubusercontent.com/sammykumar/vibe-flow-agent-orchestrator/master/agents/subagents/document.agent.md) to `.github/agents/document.agent.md`
- Fetch [pdd-protocol.md](https://raw.githubusercontent.com/sammykumar/vibe-flow-agent-orchestrator/master/docs/vibeflow/pdd-protocol.md) to `docs/vibeflow/pdd-protocol.md`
- Fetch [orchestrator-manual.md](https://raw.githubusercontent.com/sammykumar/vibe-flow-agent-orchestrator/master/docs/vibeflow/orchestrator-manual.md) to `docs/vibeflow/orchestrator-manual.md`
- Fetch [new-feature.prompt.md](https://raw.githubusercontent.com/sammykumar/vibe-flow-agent-orchestrator/master/prompts/new-feature.prompt.md) to `.github/prompts/new-feature.prompt.md`
- Fetch [update-feature.prompt.md](https://raw.githubusercontent.com/sammykumar/vibe-flow-agent-orchestrator/master/prompts/update-feature.prompt.md) to `.github/prompts/update-feature.prompt.md`

### 6.2 Fetch Skills

Create `.github/skills/orchestration/` directory and download the orchestration skill:

- Fetch [orchestration/SKILL.md](https://raw.githubusercontent.com/sammykumar/vibe-flow-agent-orchestrator/master/.github/skills/orchestration/SKILL.md) to `.github/skills/orchestration/SKILL.md`

### 6.3 Verify Installation

After fetching, verify `.github/agents/vibe-flow.agent.md` contains the `version:` comment (e.g., `<!-- version: 1.0.1 -->`).

Ensure you use the raw content URLs and install them to their respective locations.

## 7. Configure VS Code

You MUST ensure the `.vscode/settings.json` file exists and contains the prompt file recommendations.

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

## 8. Create `AGENTS.md`

Create `AGENTS.md` at git root:

```markdown
# {PROJECT_NAME} Development Agents

## Core Orchestrator

- **@vibe-flow** (.github/agents/vibe-flow.agent.md): Use this agent for ALL complex tasks. It manages the Plan-Driven Development lifecycle.

## Sub-Agents (Managed by Vibe Flow)

- **@research-agent**: Investigation & Spec.
- **@implement-agent**: Code & Refactor.
- **@test-agent**: QA & E2E.
- **@document-agent**: Diagrams & Guides.

## Documentation

- `docs/vibeflow/pdd-protocol.md`: Rules for plans.
- `docs/guides/`: Code and usage guides.
```

## 9. Handle Links from UNUSED_FILE

- Scan UNUSED_FILE for links to deprecated docs.
- If relevant content exists, move links to `AGENTS.md` (manually).

## 10. Refresh instructions files

Delete every file in `INSTRUCTIONS_FILES` (from Step 2) except `AGENTS.md`.

## 11. Report to the User

Fill in the template for **first-time installation**:

````markdown
# Vibe Flow Installed

The {START_FILE} instructions have been migrated to `docs/unused-instructions.md`.
Vibe Flow (Plan-Driven Development) is now active.

**New Structure**:

- `.github/agents/vibe-flow.agent.md` (Orchestrator v1.2.1 - single source of truth for version)
- `docs/vibeflow/pdd:

```markdown
# Vibe Flow Installed

The {START_FILE} instructions have been migrated to `docs/unused-instructions.md`.
Vibe Flow (Plan-Driven Development) is now active.

**New Structure**:

- `.github/agents/vibe-flow.agent.md` (Orchestrator v1.2.1 - single source of truth for version)
- `docs/vibeflow/pdd-protocol.md` (Vibe Flow Protocol)
- `.github/agents/research.agent.md` (Research Agent)
- `.github/agents/implement.agent.md` (Implement Agent)
- `.github/agents/test.agent.md` (Test Agent)
- `.github/agents/document.agent.md` (Document Agent)
- `.github/prompts/` (Interactive Prompts)
- `.github/plans/` (Project Memory)

**Note**: The vibe-flow orchestrator version is the single source of truth. All subagents are versioned together as a suite.

**To start a task**:
"@vibe-flow Implement {feature_name}"
```
````
