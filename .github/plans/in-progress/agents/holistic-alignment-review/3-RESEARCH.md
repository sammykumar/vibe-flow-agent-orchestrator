# Research — Holistic Alignment Review (Incremental Mode)

## Scope & Approach

- Started with [docs/vibeflow/orchestrator-manual.md](docs/vibeflow/orchestrator-manual.md).
- Reviewed relevant repository documentation and agent/skill definitions.
- Excluded any v1 backups from content review (only referenced their existence where already documented).

## Evidence Log (key excerpts)

1. Incremental mode + v1 backup mention in orchestrator manual

- Path: docs/vibeflow/orchestrator-manual.md
- Excerpt: "**Incremental mode notice:** This repository currently ships only the orchestrator, research agent, and implement agent. ... Legacy full-suite agents are backed up in `.github/agents/v1/`."

2. PDD statuses include `todo` in protocol

- Path: docs/vibeflow/pdd-protocol.md
- Excerpt: "Statuses\n\n- `todo`: Work identified but not yet started ...\n- `in-progress`: Actively being researched or implemented ...\n- `finished`: Fully implemented."

3. Orchestrator agent lists status values without `todo`

- Path: .github/agents/vibe-flow.agent.md
- Excerpt: "Status values: `in-progress`, `finished`"

4. Orchestration skill lists status values without `todo`

- Path: .github/skills/orchestration/SKILL.md
- Excerpt: "## Status Values\n\n- `in-progress` - Active work\n- `finished` - Complete and verified"

5. Installer target structure omits implement agent

- Path: install-vibeflow.md
- Excerpt: "`.github/agents/\n│   ├── vibe-flow.agent.md\n│   └── research.agent.md`"

6. Installer fetch list omits implement agent

- Path: install-vibeflow.md
- Excerpt: "Fetch [vibe-flow.agent.md] ... Fetch [research.agent.md] ..."

7. Updater fetch list omits implement agent

- Path: update-vibeflow.md
- Excerpt: "Fetch [vibe-flow.agent.md] ... Fetch [research.agent.md] ..."

8. README structure references AGENTS.md (missing in repo)

- Path: README.md
- Excerpt: "AGENTS.md # Quick reference"

9. README contributor guidance references non-existent `agents/` path

- Path: README.md
- Excerpt: "To modify agents or add features:\n1. Edit agent files in `agents/` or `agents/subagents/`"

10. README lists only Mermaid skill

- Path: README.md
- Excerpt: "## 🧩 Skills Included\n\n- **Mermaid.js v11** ..."

11. Copilot instructions list only orchestration + skill-creator

- Path: .github/copilot-instructions.md
- Excerpt: "### Current Skills\n\n- **orchestration** ...\n- **skill-creator** ..."

12. Research skill docs omit `5-PLAN.md`

- Path: docs/vibeflow/research-skill.md
- Excerpt: "- `3-RESEARCH.md` — findings, alternatives, and evidence\n- `4-SPEC.md` — technical specification and acceptance criteria\n- `2-PROGRESS.md` — progress updates"

13. Research skill metadata omits `5-PLAN.md`

- Path: .github/skills/research/SKILL.md
- Excerpt: "Performs repository research, evidence-driven analysis, and produces PDD deliverables (3-RESEARCH.md, 4-SPEC.md, 2-PROGRESS.md)"

## Findings & Misalignments

### A) Agent installation docs lag behind incremental agent set

- Orchestrator manual and README describe **three installed agents** (vibe-flow, research, implement).
- Installation and update instructions only fetch **vibe-flow + research**, and the target structure omits implement.

### B) PDD status values are inconsistent across docs vs orchestration artifacts

- PDD protocol and orchestrator manual include `todo` as a user-only status.
- The orchestrator agent prompt and orchestration skill list only `in-progress` and `finished`.

### C) Skill inventory is inconsistent across docs

- README lists only Mermaid skill.
- Copilot instructions list orchestration + skill-creator only.
- Repo contains additional skills: research and mermaidjs-v11; those should be listed if they are part of the shipped set.

### D) Research skill docs omit `5-PLAN.md`

- Research agent instructions require 3-RESEARCH, 4-SPEC, and 5-PLAN.
- The research skill docs and metadata omit 5-PLAN.

### E) README references AGENTS.md and outdated paths

- README structure lists AGENTS.md, but there is no AGENTS.md in the repo.
- README contributor guidance references `agents/` or `agents/subagents/`, while the repo uses .github/agents.

## Alternative Matrix

| Approach | Description                                                                | Pros                                                                      | Cons                                                  | Recommendation |
| -------- | -------------------------------------------------------------------------- | ------------------------------------------------------------------------- | ----------------------------------------------------- | -------------- |
| A        | Update docs/instructions to match current incremental agent set and skills | Aligns installer/update/README with actual repo state; minimal disruption | Requires multiple doc edits                           | ✅ Recommended |
| B        | Remove implement agent and extra skills to match installer/update docs     | Fewer updates to docs                                                     | Breaks stated incremental mode and reduces capability | ❌             |

## Recommended Direction

Proceed with **Approach A**: bring install/update docs, README, and skill documentation into alignment with the current incremental mode and installed agent set (vibe-flow + research + implement).
