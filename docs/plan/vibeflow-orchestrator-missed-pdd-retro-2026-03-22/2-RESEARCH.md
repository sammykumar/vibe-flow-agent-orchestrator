# Research

## Goal

Explain why the initial response skipped creating PDD artifacts and identify guardrails to prevent repeats.

## Evidence

The repository instructions make PDD bootstrap mandatory before any deeper work. The orchestrator is explicitly responsible for creating the plan structure and invoking subagents, not for answering in free-form first. See [vibe-flow.agent.md](../../../.github/agents/vibe-flow.agent.md#L41), [vibe-flow.agent.md](../../../.github/agents/vibe-flow.agent.md#L44), and [vibe-flow.agent.md](../../../.github/agents/vibe-flow.agent.md#L120).

Both execution lanes require plan initialization up front. Fast Track says to initialize the plan folder and create `3-PROGRESS.md` before the task breakdown, and Full PDD says to create the plan folder and `3-PROGRESS.md` before invoking research. See [vibe-flow.agent.md](../../../.github/agents/vibe-flow.agent.md#L120), [vibe-flow.agent.md](../../../.github/agents/vibe-flow.agent.md#L130), and [vibe-flow.agent.md](../../../.github/agents/vibe-flow.agent.md#L131).

The orchestration skill repeats the same rule in a more operational form: initialize `.github/plans/in-progress/{major-area}/{task-name}/`, initialize `3-PROGRESS.md`, and keep active agent work in `in-progress/`. It also states that `todo/` is only for plan-only/manual requests, and that plan-only requests should stop after creating a `todo/` plan without invoking subagents. See [SKILL.md](../../../.github/skills/orchestration/SKILL.md#L66), [SKILL.md](../../../.github/skills/orchestration/SKILL.md#L81), [SKILL.md](../../../.github/skills/orchestration/SKILL.md#L89), and [SKILL.md](../../../.github/skills/orchestration/SKILL.md#L219).

The prompt layer aligns with that split. A new-feature request must initialize a new plan folder in `in-progress/` and begin research, while the plan-only prompt is the only path that intentionally creates a `todo/` plan and stops. See [new-feature.prompt.md](../../../.github/prompts/new-feature.prompt.md#L17) and [plan-only.prompt.md](../../../.github/prompts/plan-only.prompt.md#L18).

The active plan files confirm the retrospective is still at the scaffold stage: `1-RESEARCH.md` contains only the goal/questions, `2-SPEC.md` contains only acceptance criteria, and `3-PROGRESS.md` contains only unchecked status items. See [1-RESEARCH.md](1-RESEARCH.md#L1), [2-SPEC.md](2-SPEC.md#L1), and [3-PROGRESS.md](3-PROGRESS.md#L1).

## Root Cause

The initial response appears to have bypassed the PDD bootstrap path entirely and answered as a normal chat response instead of first creating the plan artifacts. That skipped the mandatory initialization branch that should have either:

1. created an `in-progress/` plan and `3-PROGRESS.md` for active work, or
2. created a `todo/` plan via the plan-only prompt if the request was meant to be planning-only.

Because neither branch ran, there was no earlier filesystem checkpoint to force the work into the PDD workflow.

## Missing Guardrails

The most important missed check is a preflight gate at the very start of the orchestrator flow: classify the request, then require the appropriate plan folder and `3-PROGRESS.md` to exist before any explanatory or implementation-oriented response is allowed.

For active work, the gate should enforce these conditions:

- If the request is not explicitly plan-only, create `.github/plans/in-progress/{major-area}/{task-name}/`.
- Create `3-PROGRESS.md` immediately after folder creation.
- In Full PDD, do not proceed past research until `1-RESEARCH.md` and `2-SPEC.md` exist.
- Do not let the assistant emit a normal answer if the plan artifacts have not been initialized.

For plan-only work, the gate should enforce the opposite branch:

- Create `.github/plans/todo/{major-area}/{task-name}/`.
- Create `3-PROGRESS.md` as the plan context file.
- Stop there and do not invoke subagents.

## Detect Earlier Next Time

The earliest reliable detection point is before the first non-acknowledgement reply. A simple preflight checklist should fail closed if the request requires PDD but no plan directory exists yet.

Recommended detection rule:

- If a task is being handled by `vibe-flow` and the response would involve any work beyond a brief acknowledgment, verify that the active plan folder exists and that `3-PROGRESS.md` exists.
- If the request is active work, verify that the plan lives under `in-progress/`.
- If the request is plan-only, verify that the plan lives under `todo/` and that no subagents were invoked.

This can be enforced as a first-turn orchestration assertion: “no plan file, no progress file, no continued response.” That would have surfaced the mistake immediately instead of allowing a plain-answer path to proceed.

## Alternative Matrix

| Approach                                | Pros                                                                                                                                                             | Cons                                                                                                                             | Recommendation          |
| --------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------- | ----------------------- |
| Strict orchestrator preflight gate      | Catches the failure before any plan discussion or implementation begins; easy to reason about; aligns with the existing single-writer and source-of-truth rules. | Requires the orchestrator to classify every request up front and reject free-form answers until the filesystem state is correct. | ✅ Recommended          |
| Prompt-only bootstrap guidance          | Lower friction to add; can be embedded in new-feature/update-feature/plan-only prompts.                                                                          | Easier to bypass because it depends on the user selecting the right prompt path; weaker as a universal guardrail.                | ⚠️ Secondary control    |
| Post-response linting of plan artifacts | Can detect missing files after the fact and provide a repair signal.                                                                                             | Too late to prevent the skipped response; catches symptoms rather than the cause.                                                | ❌ Not sufficient alone |

## Prevention Summary

The durable fix is to treat plan-file creation as a required precondition, not a follow-up step. The orchestrator should refuse to continue unless it has either created the `in-progress/` plan plus `3-PROGRESS.md` or intentionally branched into `todo/` plan-only mode.
