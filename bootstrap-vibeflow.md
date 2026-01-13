# Bootstrap Vibe Flow

These instructions install Vibe Flow (Plan-Driven Development) in a codebase. They produce a structured documentation set, agent profiles, and PDD workflow scaffolding.

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
├── api/
├── guides/
│   ├── Code Style.md
│   └── Testing Strategy.md
├── vibeflow/
│   ├── PDD Protocol.md
│   └── Orchestator Manual.md
├── Unused Instructions.md
└── Writing Documentation.md
.github/
├── agents/
│   ├── vibe-flow.agent.md
│   ├── research.agent.md
│   ├── implement.agent.md
│   ├── test.agent.md
│   └── document.agent.md
├── plans/
│   ├── todo/
│   ├── in-progress/
│   └── finished/
└── skills/
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

- Create directories `docs`, `.github/plans`, `.github/skills`, and `.github/agents` at the repository root if they do not exist.
- Create subdirectories `docs/vibeflow`, `docs/guides`, `docs/architecture`.
- Create PDD state folders: `.github/plans/todo`, `.github/plans/in-progress`, `.github/plans/finished`.
- Create `.github/plans/.gitkeep`.

If `.gitignore` exists, ensure it includes:

```text
# Vibe Flow Plans (Do NOT Ignore plans, they are project memory)
# Ignore temp files if any
```

## 4. Move START_FILE to `docs/Unused Instructions.md`

1. Check if `docs/Unused Instructions.md` already exists. If it exists, stop.
2. Move START_FILE content into `docs/Unused Instructions.md` with title `# Unused Instructions`. Remove START_FILE.
3. Call this **UNUSED_FILE**.

## 5. Extract and Infer Documentation

Extract documents from UNUSED_FILE and infer project conventions.

### 5.1. Code Style

Create `docs/guides/Code Style.md` with code style rules. Extract from UNUSED_FILE and infer from codebase.

### 5.2. Testing Strategy

Create `docs/guides/Testing Strategy.md` explaining how tests are written and run. Extract from UNUSED_FILE and infer from codebase.

### 5.3. PDD Protocol

Create `docs/vibeflow/PDD Protocol.md` with the following content:

```markdown
# Plan-Driven Development (PDD)

## File Contract

All work happens inside: `.github/plans/{status}/{major-area}/{task-name}/`

### Statuses

- `todo`: Work identified but not started.
- `in-progress`: Actively being researched, implemented, tested.
- `finished`: Fully implemented, tested, and documented.

### Required Files

| File            | Purpose                                     |
| --------------- | ------------------------------------------- |
| `1-OVERVIEW.md` | Business context + goals                    |
| `2-PROGRESS.md` | Append-only execution log (Source of Truth) |
| `3-RESEARCH.md` | Investigation + Alternative Matrix          |
| `4-SPEC.md`     | Tech Spec + Impact Analysis                 |
| `5-PLAN.md`     | Step-by-step implementation plan            |

### Workflow

1. **Initialize**: Create folder in `todo`.
2. **Research**: Populate `3-RESEARCH.md` and `4-SPEC.md`.
3. **Plan**: Create `5-PLAN.md`.
4. **Implement**: Execute plan, logging to `2-PROGRESS.md`.
5. **Test**: Verify implementation.
6. **Finish**: Move to `finished`.
```

## 6. Install Vibe Flow Agents

Use `curl` or `wget` to fetch the master agent profiles from the official repository:
https://github.com/sammykumar/vibe-flow-agent-orchestrator

Execute the following commands to download the agents to `.github/agents`:

- Fetch [vibe-flow.agent.md](https://raw.githubusercontent.com/sammykumar/vibe-flow-agent-orchestrator/main/vibe-flow.agent.md) to `.github/agents/vibe-flow.agent.md`
- Fetch [research.agent.md](https://raw.githubusercontent.com/sammykumar/vibe-flow-agent-orchestrator/main/research.agent.md) to `.github/agents/research.agent.md`
- Fetch [implement.agent.md](https://raw.githubusercontent.com/sammykumar/vibe-flow-agent-orchestrator/main/implement.agent.md) to `.github/agents/implement.agent.md`
- Fetch [test.agent.md](https://raw.githubusercontent.com/sammykumar/vibe-flow-agent-orchestrator/main/test.agent.md) to `.github/agents/test.agent.md`
- Fetch [document.agent.md](https://raw.githubusercontent.com/sammykumar/vibe-flow-agent-orchestrator/main/document.agent.md) to `.github/agents/document.agent.md`

Ensure you use the raw content URLs and install them to `.github/agents/`.

## 7. Create `AGENTS.md`

Create `AGENTS.md` at git root:

```markdown
# {PROJECT_NAME} Development Agents

## Core Orchestrator

- **@vibe-flow** (.github/agents/vibe-flow.agent.md): Use this agent for ALL complex tasks. It manages the Plan-Driven Development lifecycle.

## Sub-Agents (Managed by Vibe Flow)

- **@research-agent**: Investigation & Spec.
- **@implement-agent**: Code & Refactor (Beast).
- **@test-agent**: QA & E2E.
- **@document-agent**: Diagrams & Guides.

## Documentation

- `docs/vibeflow/PDD Protocol.md`: Rules for plans.
- `docs/guides/`: Code and usage guides.
```

## 8. Handle Links from UNUSED_FILE

- Scan UNUSED_FILE for links to deprecated docs.
- If relevant content exists, move links to `AGENTS.md` (manually).

## 9. Refresh instructions files

Delete every file in `INSTRUCTIONS_FILES` (from Step 2) except `AGENTS.md`.

## 10. Report to the User

Fill in the template:

```markdown
# Vibe Flow Installed

The {START_FILE} instructions have been migrated to `docs/Unused Instructions.md`.
Vibe Flow (Plan-Driven Development) is now active.

**New Structure**:

- `.github/agents/vibe-flow.agent.md` (Orchestrator)
- `.github/plans/` (Project Memory)
- `docs/vibeflow/` (Protocol)

**To start a task**:
"@vibe-flow Implement {feature_name}"
```
