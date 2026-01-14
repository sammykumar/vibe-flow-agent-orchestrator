# Plan-Driven Development (PDD)

## File Contract

All work happens inside: `.github/plans/{status}/{major-area}/{task-name}/`

### Statuses

- `todo`: Work identified but not yet started (Manual use only).
- `in-progress`: Actively being researched, implemented, tested. (Agents initialize here).
- `finished`: Fully implemented, tested, and documented. (User moves here manually).

### Major Area Examples

- `core`
- `agents`
- `skills`
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
