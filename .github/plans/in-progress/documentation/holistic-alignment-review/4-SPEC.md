# Specification — Holistic Alignment Updates (Incremental Mode)

## Objective

Align repository documentation, installer/update instructions, and skill metadata with the current incremental mode: **only `vibe-flow`, `research-agent`, and `implement-agent` are installed**, with test/document agents explicitly marked as future.

## Scope

- Documentation and instruction files only.
- No code changes.
- Exclude v1 backups from content edits.

## Requirements

### R1: Installer and updater must reflect three-agent incremental set

- `install-vibeflow.md` and `update-vibeflow.md` must include **implement agent** in fetch lists and target structure.

### R2: PDD status values must be consistent

- `todo`, `in-progress`, `finished` should be consistently described across:
  - `docs/vibeflow/pdd-protocol.md`
  - `docs/vibeflow/orchestrator-manual.md`
  - `.github/agents/vibe-flow.agent.md`
  - `.github/skills/orchestration/SKILL.md`
- If `todo` remains user-only, state that consistently.
- Clarify that `todo` is for user-created plans or plan-only requests (no implementation), while agents default to `in-progress` for active work.

### R2.1: Plan-only prompt for todo creation

- Add a custom prompt for “plan-only” requests that instructs the orchestrator to create a plan in `todo/` without starting research/implementation.
- Ensure the prompt is discoverable alongside existing prompts.

### R3: Skill inventory must be consistent

- README and copilot instructions must list all shipped skills in this repo.
- Decide whether `skills-creator` is intended to ship. If yes, include it in install/update docs and skills lists; if no, remove/mark as internal-only consistently.

### R4: Research skill documentation must include `5-PLAN.md`

- Update both the doc-facing description and the skill metadata to reflect all required deliverables.

### R5: README structure and contributor guidance must match repo layout

- Remove or replace `AGENTS.md` reference if file is not present.
- Update agent path references to `.github/agents/`.

## Non-Goals

- No changes to agent logic or behavior.
- No changes to v1 backups or legacy content.

## Acceptance Criteria

- Installer/updater explicitly include `implement.agent.md` (and skill-creator if intended to ship).
- Status values are consistent across the protocol, manual, orchestrator prompt, and orchestration skill.
- `todo` status meaning (plan-only/manual) is explicitly stated and consistent.
- A plan-only prompt exists and is referenced in prompt recommendations.
- README and copilot instructions list the correct skill set.
- Research skill docs and metadata list `5-PLAN.md` as a required output.
- README no longer references missing `AGENTS.md` or outdated `agents/` paths.

## Impact Analysis

### Files to Modify

- install-vibeflow.md
- update-vibeflow.md
- docs/vibeflow/orchestrator-manual.md (only if status value alignment needs adjustment)
- docs/vibeflow/pdd-protocol.md (only if status value alignment needs adjustment)
- .github/agents/vibe-flow.agent.md
- .github/skills/orchestration/SKILL.md
- .github/prompts/plan-only.prompt.md
- docs/vibeflow/research-skill.md
- .github/skills/research/SKILL.md
- README.md
- .github/copilot-instructions.md

### Files Not in Scope

- Any content under `.github/agents/v1/`

## Verification Plan

- Re-read updated files and confirm alignment with acceptance criteria.
- Confirm README and instructions match repo structure and agent set.
- Ensure no references to uninstalled agents except as “future”.
