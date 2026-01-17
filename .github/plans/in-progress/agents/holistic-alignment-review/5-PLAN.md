# Implementation Plan — Documentation Alignment

> This plan lists **file-level recommendations** to align docs and instructions with incremental mode (vibe-flow + research-agent + implement-agent only).

## Task 1 — Align installer/update with incremental agent set ✅

- [x] Update install instructions to include `implement.agent.md` in fetch list and target structure.
  - File: install-vibeflow.md
- [x] Update update instructions to include `implement.agent.md` in fetch list and verification list.
  - File: update-vibeflow.md

## Task 2 — Normalize PDD status values across docs and orchestration artifacts ✅

- [x] Add `todo` status (user-only) to orchestrator agent prompt status list (or align protocol/manually remove it if deprecated).
  - File: .github/agents/vibe-flow.agent.md
- [x] Add `todo` status (user-only) to orchestration skill status list.
  - File: .github/skills/orchestration/SKILL.md
- [x] Clarify `todo` usage for plan-only/manual creation vs `in-progress` for active agent work.
  - Files: docs/vibeflow/orchestrator-manual.md, docs/vibeflow/pdd-protocol.md
- [x] Add a plan-only prompt that creates a `todo/` plan without starting execution.
  - File: .github/prompts/plan-only.prompt.md
- [x] Add the plan-only prompt to prompt recommendations for install/update instructions.
  - Files: install-vibeflow.md, update-vibeflow.md
- [x] Confirm `docs/vibeflow/orchestrator-manual.md` and `docs/vibeflow/pdd-protocol.md` remain consistent after above edits.
  - Files: docs/vibeflow/orchestrator-manual.md, docs/vibeflow/pdd-protocol.md

## Task 3 — Align skill inventory documentation

- Update README skills list to include all shipped skills (or explicitly call out which are packaged vs internal-only).
  - File: README.md
- Update copilot instructions “Current Skills” list to match actual skills present.
  - File: .github/copilot-instructions.md
- Decide on `skills-creator` packaging:
  - If shipped, add to install/update instructions and README/copilot instructions.
  - If internal-only, remove from README/copilot instructions (or label as internal-only).
  - Files: install-vibeflow.md, update-vibeflow.md, README.md, .github/copilot-instructions.md

## Task 4 — Update research skill docs to include `5-PLAN.md`

- Add `5-PLAN.md` to research skill docs and metadata.
  - Files: docs/vibeflow/research-skill.md, .github/skills/research/SKILL.md

## Task 5 — Fix README structure and contributor guidance

- Remove or replace `AGENTS.md` reference if the file is not present.
- Update agent file path references to `.github/agents/`.
  - File: README.md
