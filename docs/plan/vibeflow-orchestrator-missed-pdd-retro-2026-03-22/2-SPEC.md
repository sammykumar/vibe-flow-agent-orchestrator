# Spec

## Acceptance Criteria

- Root cause of the skipped PDD creation is documented.
- Missing guardrails are identified.
- A concrete prevention rule is proposed.
- A validation step is defined to prove the prevention rule works.

## Output Format

- Short causal summary.
- Preventive controls.
- Follow-up actions, if any.

## Causal Summary

The initial response bypassed the orchestrator bootstrap path and answered directly instead of first creating the plan artifacts required by the PDD workflow. That skipped the branch that should have created either an `in-progress/` plan plus `3-PROGRESS.md` for active work, or a `todo/` plan for an explicit plan-only request.

## Preventive Controls

- Add a preflight gate at the start of the orchestrator flow that classifies the request before any substantive reply.
- For active work, require an `in-progress/` plan directory and `3-PROGRESS.md` before the assistant is allowed to continue.
- For plan-only work, require a `todo/` plan directory, create `3-PROGRESS.md`, and stop without invoking subagents.
- Block free-form explanation or implementation responses until the required plan files exist.

## Validation

Prove the prevention rule by checking both branches:

- Active work request: inspect the orchestration transcript and verify the first non-acknowledgement assistant turn occurs only after the plan exists under `in-progress/` and `3-PROGRESS.md` exists.
- Plan-only request: inspect the orchestration transcript and verify the plan exists under `todo/`, `3-PROGRESS.md` exists, and the transcript contains zero `runSubagent` calls before those files are created.
- The guardrail should fail closed if the required plan files are missing.

## Follow-Up Actions

- Update the orchestrator wording if needed so the preflight gate is explicit in the top-level instructions.
- Keep the progress tracker aligned with the plan state so missed bootstrap steps are visible immediately.
