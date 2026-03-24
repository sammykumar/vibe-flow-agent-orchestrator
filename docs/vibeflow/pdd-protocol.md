# Plan-Driven Development (PDD)

## File Contract

All work happens inside: `.github/plans/{status}/{domain}/{scope-path}/{task-name}/`

### Statuses

- `todo`: Work identified but not yet started (**User creates only - agents never work on todo folders**).
- `in-progress`: Actively being researched, implemented, or tested. (**Agents always initialize here**).
- `finished`: Fully implemented and tested. (**User manually moves here after verification**).

Use the **plan-only prompt** to create a `todo/` plan without starting research or implementation. Active agent work always starts in `in-progress`.

### Plan Taxonomy

- `domain`: broad top-level functional area, such as `ui`, `app`, `infra`, `data`, `docs`, or `agents`
- `scope-path`: one or more stable grouping folders inside that domain, such as `card-v2`, `navigation`, `media/reddit`, or `deploy/github-actions`
- `task-name`: the specific work item at the leaf

Rules:

1. Agents must inspect existing folders under `.github/plans/{todo,in-progress,finished}/` before creating a new plan.
2. Reuse an existing `domain` when the work belongs in that functional area.
3. Reuse or extend an existing `scope-path` when the work belongs to the same subsystem, feature family, component, or service.
4. Do not flatten hierarchy into synthetic top-level names like `ui-system` when the correct structure is `ui/...`.
5. Agent-created plans must include at least one `scope-path` segment.

Examples:

- `.github/plans/in-progress/ui/card-v2/footer-overlay-actions-2026-03-24/`
- `.github/plans/in-progress/app/navigation/app-shell-refactor/`
- `.github/plans/in-progress/infra/deploy/github-actions-cache/`

### Required Files

| File            | Purpose                                                 |
| --------------- | ------------------------------------------------------- |
| `1-PROGRESS.md` | Task plan + append-only execution log (Source of Truth) |
| `2-RESEARCH.md` | Investigation + Alternative Matrix                      |
| `3-SPEC.md`     | Business context + Tech Spec + Impact Analysis          |

### Documentation Output

When documentation needs the same organization, mirror the plan taxonomy in docs paths such as `docs/{domain}/{scope-path}/{doc}.md`.

### Workflow

1. **Initialize**: Create `1-PROGRESS.md` in the plan folder.
2. **Research**: Populate `2-RESEARCH.md` and `3-SPEC.md`.
3. **Orchestrator Planning**: `vibe-flow` writes task breakdown into `1-PROGRESS.md` from `2-RESEARCH.md` and `3-SPEC.md`.
4. **Implement**: Execute tasks, logging to `1-PROGRESS.md`.
5. **Test**: `test-agent` writes and runs tests proving functionality works. Logs results to `1-PROGRESS.md`.
6. **If tests fail due to implementation bugs**: Return to Implement, fix, then re-run Test.
7. **Final Review**: Plan is complete only when all tests pass.
8. **Finish**: User manually moves the folder to `finished`.

### Parallelism Policy (Default read-only helpers)

Parallel read-only helpers are ON by default in v2. Use parallelism only for read-only research helpers; write-capable subagents must remain sequential.

- Only run subagents in parallel if they are **read-only research helpers** (no file edits, no plan artifacts).
- Write-capable subagents (including `research-agent`, `implement-agent`, and `test-agent`) MUST run sequentially.
- Each parallel subagent MUST declare: `subagent-id`, `scope` (read-only/write), `lock-scope`, and `expected-outputs`.
- **Single-writer rule**: Only the orchestrator writes to `1-PROGRESS.md` during parallel runs.
- Wait for all subagents in the parallel group to complete; reconcile deterministically (e.g., order in task list within `1-PROGRESS.md`).
- Summarize each subagent’s outputs separately before synthesis.
- Update the Subagent Ledger section in `1-PROGRESS.md` for each parallel run.

## Progress Log Format (Recommended)

```markdown
# Progress Log

> Purpose: chronological, factual record of what changed, why, and what the result was.

## Quick Index

| Date       | Work Item           |  Status | Key outputs                      |
| ---------- | ------------------- | ------: | -------------------------------- |
| 2026-01-12 | Implement Agent     | ✅ PASS | API endpoint X, 3 files, 6 tests |
| 2026-01-12 | Test Agent (future) | ✅ PASS | unit/api, 0 failures             |

---

## Subagent Ledger (Parallel Runs)

| subagent-id | purpose           | scope     | lock-scope | status | start | end   | outputs        |
| ----------- | ----------------- | --------- | ---------- | ------ | ----- | ----- | -------------- |
| research-a1 | code scan         | read-only | n/a        | ✅     | 09:10 | 09:20 | findings to VF |
| research-a2 | dependency review | read-only | n/a        | ✅     | 09:10 | 09:25 | findings to VF |

> **Single-writer rule**: The orchestrator updates this ledger during parallel runs. Subagents must not edit `1-PROGRESS.md` concurrently.

## 2026-01-12 — Implement Agent

### Summary

| Field         | Value                                      |
| ------------- | ------------------------------------------ |
| Agent         | implement-agent                            |
| Start         | 09:00                                      |
| End           | 10:30                                      |
| Status        | ✅ PASS                                    |
| Files Changed | 3                                          |
| Tests Written | 6                                          |
| Key Outputs   | `src/api/endpoint.ts`, `tests/api.test.ts` |

### Work Done

- Implemented API endpoint `/api/v1/resource`
- Added request validation middleware
- Created unit and integration tests
- Updated API documentation

### Issues Encountered

None

### Next Steps

- Future test agent to run E2E tests
- Future document agent to update API reference

---
```

## Alternative Matrix (Research Phase)

When researching solutions, document alternatives in `2-RESEARCH.md`:

```markdown
## Alternative Matrix

| Approach | Pros             | Cons                | Recommendation |
| -------- | ---------------- | ------------------- | -------------- |
| Option A | Fast, simple     | Limited scalability | ⚠️             |
| Option B | Highly scalable  | Complex setup       | ✅ RECOMMENDED |
| Option C | Best performance | High cost           | ❌             |
```

## Impact Analysis (Spec Phase)

Include in `3-SPEC.md` to identify ripple effects:

```markdown
## Impact Analysis

### Files to Modify

- `src/core/engine.ts` — Add new method
- `tests/core/engine.test.ts` — Add tests

### Files to Create

- `src/api/resource.ts` — New resource handler

### Breaking Changes

None

### Migration Required

No
```
