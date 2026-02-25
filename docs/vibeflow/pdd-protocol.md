# Plan-Driven Development (PDD)

## File Contract

All work happens inside: `.github/plans/{status}/{major-area}/{task-name}/`

### Statuses

- `todo`: Work identified but not yet started (**User creates only - agents never work on todo folders**).
- `in-progress`: Actively being researched, implemented, or tested. (**Agents always initialize here**).
- `finished`: Fully implemented and tested. (**User manually moves here after verification**).

Use the **plan-only prompt** to create a `todo/` plan without starting research or implementation. Active agent work always starts in `in-progress`.

### Major Area Examples

- `core`
- `agents`
- `mcp-servers`
- `infrastructure`
- `ci-cd`
- `ui`
- `api`
- `data`
- `observability`
- `documentation`
- `security`

### Required Files

| File            | Purpose                                                 |
| --------------- | ------------------------------------------------------- |
| `1-RESEARCH.md` | Investigation + Alternative Matrix                      |
| `2-SPEC.md`     | Business context + Tech Spec + Impact Analysis          |
| `3-PROGRESS.md` | Task plan + append-only execution log (Source of Truth) |

### Documentation Output

Agents produce documentation in: `docs/{major-area}/{doc}.md`

### Workflow

1. **Initialize**: Create folder in `in-progress`.
2. **Research**: Populate `1-RESEARCH.md` and `2-SPEC.md`.
3. **Orchestrator Planning**: `vibe-flow` writes task breakdown into `3-PROGRESS.md` from `1-RESEARCH.md` and `2-SPEC.md`.
4. **Implement**: Execute tasks, logging to `3-PROGRESS.md`.
5. **Test**: `test-agent` writes and runs tests proving functionality works. Logs results to `3-PROGRESS.md`.
6. **If tests fail due to implementation bugs**: Return to Implement, fix, then re-run Test.
7. **Final Review**: Plan is complete only when all tests pass.
8. **Finish**: User manually moves the folder to `finished`.

### Parallelism Policy (Default read-only helpers)

Parallel read-only helpers are ON by default in v2. Use parallelism only for read-only research helpers; write-capable subagents must remain sequential.

- Only run subagents in parallel if they are **read-only research helpers** (no file edits, no plan artifacts).
- Write-capable subagents (including `research-agent`, `implement-agent`, and `test-agent`) MUST run sequentially.
- Each parallel subagent MUST declare: `subagent-id`, `scope` (read-only/write), `lock-scope`, and `expected-outputs`.
- **Single-writer rule**: Only the orchestrator writes to `3-PROGRESS.md` during parallel runs.
- Wait for all subagents in the parallel group to complete; reconcile deterministically (e.g., order in task list within `3-PROGRESS.md`).
- Summarize each subagent’s outputs separately before synthesis.
- Update the Subagent Ledger section in `3-PROGRESS.md` for each parallel run.

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

> **Single-writer rule**: The orchestrator updates this ledger during parallel runs. Subagents must not edit `3-PROGRESS.md` concurrently.

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

When researching solutions, document alternatives in `1-RESEARCH.md`:

```markdown
## Alternative Matrix

| Approach | Pros             | Cons                | Recommendation |
| -------- | ---------------- | ------------------- | -------------- |
| Option A | Fast, simple     | Limited scalability | ⚠️             |
| Option B | Highly scalable  | Complex setup       | ✅ RECOMMENDED |
| Option C | Best performance | High cost           | ❌             |
```

## Impact Analysis (Spec Phase)

Include in `2-SPEC.md` to identify ripple effects:

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
