# Vibe Flow Agent Development Instructions

This repository defines the **Vibe Flow** agent suite. Your goal here is to maintain, improve, and package these agents for use in _other_ repositories.

## 🎯 Repository Purpose

This is the **source code** for the Vibe Flow AI Agents, distributed as an [APM](https://github.com/microsoft/apm) package.

- The "Code" is **Markdown** (`*.agent.md`).
- The "Compiler" is the LLM that reads them.
- The "Package Manager" is [APM](https://github.com/microsoft/apm).

**Note on Repository Structure**: This repository uses a source-and-mirror layout:

- `.github/agents/` (and `.github/skills/`, `.github/prompts/`) — the **authoring source** for agent, skill, and prompt content. VS Code reads agents from `.github/agents/`, so this is the place to edit behavior.
- `.apm/` — the **generated distribution mirror** that APM reads when consumers run `apm install sammykumar/vibe-flow-agent-orchestrator`.

When you modify an agent, skill, or prompt, edit the `.github/` copy first, then run `npm run sync` to copy those changes into `.apm/`.

## ✅ Source of Truth

Use these locations as the authoritative sources for behavior and workflow details:

- `.github/agents/`, `.github/skills/`, and `.github/prompts/` (authoring source)
- `.apm/agents/`, `.apm/skills/`, and `.apm/prompts/` (generated mirror; keep in sync via `npm run sync`)
- `apm.yml` (package manifest — version must match `vibe-flow.agent.md`)
- `docs/vibeflow/`

## 📂 Core Artifacts

### 1. Agent Definitions (`*.agent.md`)

These are the executable agent files. Treat them as production source code.

**Structure:**

- **YAML Frontmatter:** Defines `name`, `description`, `tools`, and `infer` settings.
- **Prompt Body:** Defines the agent's identity, role, and strict execution protocols.

### 2. The Protocol Spec (`orchestrator-manual.md`)

Defines the PDD (Plan-Driven Development) standard that the agents enforce in `docs/vibeflow/orchestrator-manual.md`.

- This file is often copied to `docs/vibeflow/orchestrator-manual.md` in target repos, along with `docs/vibeflow/pdd-protocol.md`.

## 🛠️ Development Workflow

### Modifying Agents

1.  **Edit the Prompt:** precise wording matters. Use "YOU MUST" for critical constraints.
2.  **Edit the `.github/` copy first:** treat `.github/` as the working source and `npm run sync` as the publishing step.
3.  **Update Tools:** If an agent needs new capabilities, add them to the `tools` array in YAML.
4.  **Task Management:** All agents include guidance to use `#tool:todo` for tracking work. Ensure new agents or major updates maintain this pattern.
5.  **Bump Version:** Run `npm run version:patch` (or `version:minor` / `version:major`). This bumps `package.json` and `apm.yml` in sync, then commits, tags, and pushes.

### Adding New Agents

1.  Create `new-agent-name.agent.md` in `.github/agents/`.
2.  Run `npm run sync` so the new agent is mirrored into `.apm/agents/`.
3.  Add it to `vibe-flow.agent.md`'s orchestration logic (it needs to know the subagent exists).

### Change Checklist (Agents)

When changing agents or workflow:

1. Update `.github/agents/` (authoring source).
2. Run `npm run sync` to refresh `.apm/agents/`.
3. Update docs/vibeflow/pdd-protocol.md and docs/vibeflow/orchestrator-manual.md
4. Update `.github/prompts/` and run `npm run sync` if prompts reference the new flow
5. Run `npm run version:patch` (or `minor`/`major`) to bump both `package.json` and `apm.yml`, commit, tag, and push

## 🧪 Testing & Validation

There is no `npm test` for prompts. Validation is behavioral.

- **Review:** Check that strict negative constraints ("You do NOT...") are clear.
- **Simulation:** Mentally "play" the agent to see if logic gaps exist.
- **Integration:** Ensure `vibe-flow.agent.md` correctly delegates to the subagent using `runSubagent`.

## 🧩 Architecture Summary

This repository is authored in `.github/` and mirrored into `.apm/` for distribution. For behavior details, defer to the agent definitions and documentation:

- Agent definitions in `.github/agents/` (authoring source) and `.apm/agents/` (distribution mirror)
- PDD protocol in docs/vibeflow/pdd-protocol.md
- Orchestrator manual in docs/vibeflow/orchestrator-manual.md

## 🚫 Common Pitfalls

- **Forgetting `.apm/` sync:** If you edit agent/skill/prompt files in `.github/`, you MUST run `npm run sync` so the mirrored `.apm/` copy stays current.
- **Hallucinating Tools:** Only list tools in YAML that are actually available in the target environment (VS Code / MCP).
- **Inconsistent Task Management:** All agents should use `#tool:todo` consistently for tracking work

## 🧠 Skills

Skills live in .github/skills/. For behavior and usage details, defer to the skill definitions and docs under docs/vibeflow/.
