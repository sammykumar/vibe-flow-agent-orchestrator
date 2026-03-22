# Vibe Flow Agent Development Instructions

This repository defines the **Vibe Flow** agent suite. Your goal here is to maintain, improve, and package these agents for use in _other_ repositories.

## 🎯 Repository Purpose

This is the **source code** for the Vibe Flow AI Agents, distributed as an [APM](https://github.com/microsoft/apm) package.

- The "Code" is **Markdown** (`*.agent.md`).
- The "Compiler" is the LLM that reads them.
- The "Package Manager" is [APM](https://github.com/microsoft/apm).

**Note on Repository Structure**: This repository uses a dual-directory layout:

- `.apm/` — the **distribution source** that APM reads when consumers run `apm install sammykumar/vibe-flow-agent-orchestrator`
- `.github/agents/` (and `.github/skills/`, `.github/prompts/`) — **committed deployed copies** for dogfooding in this source repo. VS Code only reads agents from `.github/agents/`, so these files are kept in sync with `.apm/` to allow testing before publishing.

When you modify an agent, skill, or prompt, update it in **both** `.apm/` and `.github/` to keep them in sync.

## ✅ Source of Truth

Use these locations as the authoritative sources for behavior and workflow details:

- `.apm/agents/` and `.github/agents/` (keep in sync)
- `.apm/skills/` and `.github/skills/` (keep in sync)
- `.apm/prompts/` and `.github/prompts/` (keep in sync)
- `apm.yml` (package manifest — version must match `vibe-flow.agent.md`)
- `docs/vibeflow/`

## 📂 Core Artifacts

### 1. Agent Definitions (`*.agent.md`)

These are the executable agent files. Treat them as production source code.

**Structure:**

- **YAML Frontmatter:** Defines `name`, `description`, `tools`, and `infer` settings.
- **Prompt Body:** Defines the agent's identity, role, and strict execution protocols.
- **Version Tag:** `<!-- version: X.X.X -->` in `vibe-flow.agent.md` ONLY (single source of truth for the entire suite).

### 2. The Protocol Spec (`orchestrator-manual.md`)

Defines the PDD (Plan-Driven Development) standard that the agents enforce in `docs/vibeflow/orchestrator-manual.md`.

- This file is often copied to `docs/vibeflow/orchestrator-manual.md` in target repos, along with `docs/vibeflow/pdd-protocol.md`.

## 🛠️ Development Workflow

### Modifying Agents

1.  **Edit the Prompt:** precise wording matters. Use "YOU MUST" for critical constraints.
2.  **Update Tools:** If an agent needs new capabilities, add them to the `tools` array in YAML.
3.  **Task Management:** All agents include guidance to use `#tool:todo` for tracking work. Ensure new agents or major updates maintain this pattern.
4.  **Bump Version:**
    - Update `version` in `apm.yml` — this is the authoritative version for APM consumers.
    - Also update the `<!-- version: X.X.X -->` comment in `vibe-flow.agent.md` to keep it readable.
    - No script needed; just edit both fields manually.

### Adding New Agents

1.  Create `new-agent-name.agent.md` in `.github/agents/`.
2.  Copy it to `.apm/agents/` as well.
3.  Add it to `vibe-flow.agent.md`'s orchestration logic (it needs to know the subagent exists).

### Change Checklist (Agents)

When changing agents or workflow:

1. Update .apm/agents/ (distribution source — this is what APM deploys to consumers)
2. Update .github/agents/ (dogfood copy — keep in sync)
3. Update docs/vibeflow/pdd-protocol.md and docs/vibeflow/orchestrator-manual.md
4. Update .github/prompts/ and .apm/prompts/ if prompts reference the new flow
5. Bump `version` in `apm.yml` (and the `<!-- version -->` comment in `vibe-flow.agent.md`)

## 🧪 Testing & Validation

There is no `npm test` for prompts. Validation is behavioral.

- **Review:** Check that strict negative constraints ("You do NOT...") are clear.
- **Simulation:** Mentally "play" the agent to see if logic gaps exist.
- **Integration:** Ensure `vibe-flow.agent.md` correctly delegates to the subagent using `runSubagent`.

## 🧩 Architecture Summary

This repository is the **source of truth** for the Vibe Flow agent suite. For behavior details, defer to the agent definitions and documentation:

- Agent definitions in .apm/agents/ (distribution) and .github/agents/ (dogfood)
- PDD protocol in docs/vibeflow/pdd-protocol.md
- Orchestrator manual in docs/vibeflow/orchestrator-manual.md

## 🚫 Common Pitfalls in `vibe-flow.agent.md` only. If you don't bump, updates won't propagate. All agents are versioned as a suite.

- **Forgetting `.apm/` sync:** If you edit agent/skill/prompt files in `.github/`, you MUST also update the corresponding file in `.apm/`. Both are canonical sources for different consumers.
- **Hallucinating Tools:** Only list tools in YAML that are actually available in the target environment (VS Code / MCP).
- **Inconsistent Task Management:** All agents should use `#tool:todo` consistently for tracking work

## 🧠 Skills

Skills live in .github/skills/. For behavior and usage details, defer to the skill definitions and docs under docs/vibeflow/.
