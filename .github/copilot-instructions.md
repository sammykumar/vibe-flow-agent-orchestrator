# Vibe Flow Agent Development Instructions

This repository defines the **Vibe Flow** agent suite. Your goal here is to maintain, improve, and package these agents for use in *other* repositories.

## 🎯 Repository Purpose
This is the **source code** for the Vibe Flow AI Agents.
- The "Code" is **Markdown** (`*.agent.md`).
- The "Compiler" is the LLM that reads them.
- The "Installer" is `bootstrap-vibeflow.md`.

## 📂 Core Artifacts

### 1. Agent Definitions (`*.agent.md`)
These are the executable agent files. Treat them as production source code.

**Structure:**
- **YAML Frontmatter:** Defines `name`, `description`, `tools`, and `infer` settings.
- **Prompt Body:** Defines the agent's identity, role, and strict execution protocols.

### 2. The Installer (`bootstrap-vibeflow.md`)
This file contains the instructions for an AI to install Vibe Flow into a target repository.
- **Rule:** If you add a new agent or change the architecture, you **MUST** update `bootstrap-vibeflow.md` to reflect these changes (e.g., creating new files, ensuring new agents are copied).

### 3. The Protocol Spec (`spec-vibeflow.md`)
Defines the PDD (Plan-Driven Development) standard that the agents enforce `spec-vibeflow.md`.
- This file is often copied to `docs/vibeflow/PDD Protocol.md` in target repos.
- **Version Tag:** `<!-- version: X.X.X -->` (Source of Truth for Vibe Flow version).

## 🛠️ Development Workflow

### Modifying Agents
1.  **Edit the Prompt:** precise wording matters. Use "YOU MUST" for critical constraints.
2.  **Update Tools:** If an agent needs new capabilities, add them to the `tools` array in YAML.
3.  **Bump Version:**
    - You **MUST** update the version comment in `spec-vibeflow.md`: `<!-- version: 1.0.1 -->`.
    - Run `./version-bump.sh <major|minor|patch>` to automate this and ensure consistency.

### Adding New Agents
1.  Create `new-agent-name.agent.md`.
2.  Add it to `vibe-flow.agent.md`'s orchestration logic (it needs to know the subagent exists).
3.  Add it to `bootstrap-vibeflow.md` so it gets installed.

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

## 🚫 Common Pitfalls
- **Forgetting Version Bumps:** The installer checks versions. If you don't bump, updates won't propagate.
- **Breaking Bootstrap:** If you rename a file, `bootstrap-vibeflow.md` will break.
- **Hallucinating Tools:** Only list tools in YAML that are actually available in the target environment (VS Code / MCP).
