# Plan-Driven Development (PDD)

## File Contract

All work happens inside: `.github/plans/{status}/{major-area}/{task-name}/`

### Statuses

- `todo`: Work identified but not yet started (**User creates only - agents never work on todo folders**).
- `in-progress`: Actively being researched, implemented, tested. (**Agents always initialize here**).
- `finished`: Fully implemented, tested, and documented. (**User manually moves here after verification**).

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

| File            | Purpose                                     |
| --------------- | ------------------------------------------- |
| `1-OVERVIEW.md` | Business context + goals                    |
| `2-PROGRESS.md` | Append-only execution log (Source of Truth) |
| `3-RESEARCH.md` | Investigation + Alternative Matrix          |
| `4-SPEC.md`     | Tech Spec + Impact Analysis                 |
| `5-PLAN.md`     | Step-by-step implementation plan            |

### Documentation Output

Agents produce documentation in: `docs/{major-area}/{doc}.md`

### Workflow

1. **Initialize**: Create folder in `in-progress`.
2. **Research**: Populate `3-RESEARCH.md` and `4-SPEC.md`.
3. **Plan**: Create `5-PLAN.md`.
4. **Implement**: Execute plan, logging to `2-PROGRESS.md`.
5. **Test**: Verify implementation.
6. **Finish**: User manually moves the folder to `finished`.

### Parallelism Policy (Opt-in)

Parallel execution is optional and **OFF by default**. Enable it only when you can guarantee auditability and lock safety.

- Only run subagents in parallel if they are **read-only** or **partitioned** with explicit, non-overlapping `lock-scope`.
- Each parallel subagent MUST declare: `subagent-id`, `scope` (read-only/write), `lock-scope`, and `expected-outputs`.
- **Single-writer rule**: Only the orchestrator writes to `2-PROGRESS.md` during parallel runs.
- Wait for all subagents in the parallel group to complete; reconcile deterministically (e.g., order in `5-PLAN.md`).
- Summarize each subagent’s outputs separately before synthesis.
- Update the Subagent Ledger section in `2-PROGRESS.md` for each parallel run.

## Progress Log Format (Recommended)

```markdown
# Progress Log

> Purpose: chronological, factual record of what changed, why, and what the result was.

## Quick Index

| Date       | Work Item       |  Status | Key outputs                      |
| ---------- | --------------- | ------: | -------------------------------- |
| 2026-01-12 | Implement Agent | ✅ PASS | API endpoint X, 3 files, 6 tests |
| 2026-01-12 | Test Agent      | ✅ PASS | unit/api, 0 failures             |

---

## Subagent Ledger (Parallel Runs Only)

| subagent-id | purpose | scope | lock-scope | status | start | end   | outputs   |
| ----------- | ------- | ----- | ---------- | ------ | ----- | ----- | --------- |
| research-a1 | Specs   | write | 4-SPEC.md  | ✅     | 09:10 | 09:45 | 4-SPEC.md |
| research-a2 | Plan    | write | 5-PLAN.md  | ✅     | 09:10 | 09:40 | 5-PLAN.md |

> **Single-writer rule**: The orchestrator updates this ledger during parallel runs. Subagents must not edit `2-PROGRESS.md` concurrently.

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

- Test agent to run E2E tests
- Document agent to update API reference

---
```

## Alternative Matrix (Research Phase)

When researching solutions, document alternatives in `3-RESEARCH.md`:

```markdown
## Alternative Matrix

| Approach | Pros             | Cons                | Recommendation |
| -------- | ---------------- | ------------------- | -------------- |
| Option A | Fast, simple     | Limited scalability | ⚠️             |
| Option B | Highly scalable  | Complex setup       | ✅ RECOMMENDED |
| Option C | Best performance | High cost           | ❌             |
```

## Impact Analysis (Spec Phase)

Include in `4-SPEC.md` to identify ripple effects:

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
