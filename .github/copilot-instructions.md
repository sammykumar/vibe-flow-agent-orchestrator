# Vibe Flow Agent Development Instructions

This repository defines the **Vibe Flow** agent suite. Your goal here is to maintain, improve, and package these agents for use in _other_ repositories.

## 🎯 Repository Purpose

This is the **source code** for the Vibe Flow AI Agents.

- The "Code" is **Markdown** (`*.agent.md`).
- The "Compiler" is the LLM that reads them.
- The "Installer" is `install-vibeflow.md`.

**Note on Repository Structure**: This repository now uses `.github/agents/` (flat structure) to dogfood Vibe Flow in the same way it's deployed to target repositories. VS Code only reads agents from `.github/agents/`, so this allows us to test the agents in this source repository before publishing.

## 📂 Core Artifacts

### 1. Agent Definitions (`*.agent.md`)

These are the executable agent files. Treat them as production source code.

**Structure:**

- **YAML Frontmatter:** Defines `name`, `description`, `tools`, and `infer` settings.
- **Prompt Body:** Defines the agent's identity, role, and strict execution protocols.
- **Version Tag:** `<!-- version: X.X.X -->` in `vibe-flow.agent.md` ONLY (single source of truth for the entire suite).

### 2. The Installer (`install-vibeflow.md`)

This file contains the instructions for an AI to install Vibe Flow into a target repository.

- **Rule:** If you add a new agent or change the architecture, you **MUST** update `install-vibeflow.md` to reflect these changes (e.g., creating new files, ensuring new agents are copied).

### 3. The Protocol Spec (`orchestrator-manual.md`)

Defines the PDD (Plan-Driven Development) standard that the agents enforce in `docs/vibeflow/orchestrator-manual.md`.

- This file is often copied to `docs/vibeflow/orchestrator-manual.md` in target repos, along with `docs/vibeflow/pdd-protocol.md`.

## 🛠️ Development Workflow

### Modifying Agents

1.  **Edit the Prompt:** precise wording matters. Use "YOU MUST" for critical constraints.
2.  **Update Tools:** If an agent needs new capabilities, add them to the `tools` array in YAML.
3.  **Task Management:** All agents include guidance to use `#tool:todo` for tracking work. Ensure new agents or major updates maintain this pattern.
4.  **Bump Version:**
    - You **MUST** update the version comment in `vibe-flow.agent.md`: `<!-- version: 1.0.1 -->`.
    - This is the **single source of truth** for the entire agent suite. Subagents do NOT have individual version tags.
    - Run `./version-bump.sh <major|minor|patch>` to automate this.

### Adding New Agents

1.  Create `new-agent-name.agent.md` in `.github/agents/`.
2.  Add it to `vibe-flow.agent.md`'s orchestration logic (it needs to know the subagent exists).
3.  Add it to `install-vibeflow.md` so it gets installed in target repositories.

## 🧪 Testing & Validation

There is no `npm test` for prompts. Validation is behavioral.

- **Review:** Check that strict negative constraints ("You do NOT...") are clear.
- **Simulation:** Mentally "play" the agent to see if logic gaps exist.
- **Integration:** Ensure `vibe-flow.agent.md` correctly delegates to the subagent using `runSubagent`.

## 🧩 Architecture Summary

- **`vibe-flow` (Orchestrator):** The entry point. Manages state in `.github/plans/`. Delegates work.
- **`research-agent`:** Read-only analysis. Writes specs.
- **`implement-agent`:** The "Do-er". Writes code.
- **`test-agent`:** The QA. Writes/Runs tests.
- **`document-agent`:** The Scribe. Updates docs.

## 🚫 Common Pitfalls in `vibe-flow.agent.md` only. If you don't bump, updates won't propagate. All agents are versioned as a suite.

- **Breaking Installer:** If you rename a file, `install-vibeflow.md` will break.
- **Hallucinating Tools:** Only list tools in YAML that are actually available in the target environment (VS Code / MCP).
- **Inconsistent Task Management:** All agents should use `#tool:todo` consistently for tracking work

## 🧠 Skills

Skills are modular, reusable knowledge packages that extend agent capabilities. Skills live in `.github/skills/` and follow the agentskills.io spec.

### Adding New Skills

1. Create `skill-name/SKILL.md` in `.github/skills/`
2. Follow the skill-creator guidance for proper structure
3. Add skill reference to `install-vibeflow.md` if it should be deployed to target repos
4. Update this file to document the skill's purpose

### Current Skills

- **orchestration** - PDD workflow and subagent delegation patterns used by vibe-flow orchestrator. Includes PDD file templates in `assets/` (overview, progress, research, spec, plan) and detailed workflow patterns in `references/workflow.md`.
- **skill-creator** - Guide for creating and updating skills following agentskills.io specification
