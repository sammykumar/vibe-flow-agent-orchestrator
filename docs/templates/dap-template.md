# Destructive Action Plan (DAP)

**Task**: {Brief description of the risky change}  
**Date**: YYYY-MM-DD  
**Agent**: implement.agent  
**Risk Level**: 🔴 High / 🟡 Medium / 🟢 Low

---

## Overview

### What are we changing?

{Clear description of the destructive action - refactoring, deletion, breaking change, infrastructure change}

### Why is this risky?

- {Risk 1: e.g., Breaking existing API contracts}
- {Risk 2: e.g., Data loss potential}
- {Risk 3: e.g., Affects multiple dependent systems}

---

## Pre-Action Checklist

- [ ] **Backup created**: {Location of backup, e.g., git branch, database snapshot}
- [ ] **Dependencies mapped**: {List of affected files/modules/services}
- [ ] **Rollback plan defined**: {How to undo this change}
- [ ] **Tests reviewed**: {Existing tests that might break}
- [ ] **Stakeholders notified**: {Team members/users affected}

---

## Affected Components

| Component      | Change Type          | Breaking? | Mitigation             |
| -------------- | -------------------- | --------- | ---------------------- |
| {File/Module}  | Delete/Refactor/Move | Yes/No    | {How to handle}        |
| {API Endpoint} | Signature change     | Yes/No    | {Deprecation strategy} |
| {Database}     | Schema change        | Yes/No    | {Migration script}     |

---

## Rollback Plan

### If something goes wrong:

1. **Immediate action**: {First step to stop damage, e.g., revert commit}
2. **Restore state**: {How to restore previous working state}
3. **Verify rollback**: {Tests to confirm rollback worked}

### Rollback commands:

```bash
# Example:
git revert <commit-hash>
npm run db:rollback
# etc.
```

---

## Execution Steps

### Step 1: Preparation

- [ ] Create feature branch: `git checkout -b refactor/{name}`
- [ ] Run all tests baseline: `npm test`
- [ ] Document current state: {Metrics, logs, screenshots}

### Step 2: Execute Change

- [ ] {Specific action 1}
- [ ] {Specific action 2}
- [ ] Run `get_errors` after each file change
- [ ] Commit incrementally with clear messages

### Step 3: Verification

- [ ] All tests pass: `npm test`
- [ ] Lint clean: `npm run lint`
- [ ] Build successful: `npm run build`
- [ ] Manual smoke test: {List critical paths to verify}

### Step 4: Documentation

- [ ] Update affected documentation
- [ ] Update migration guide (if breaking)
- [ ] Update changelog

---

## Post-Action Report

### What actually happened?

{Fill in after execution}

### Issues encountered?

{Any problems, how they were resolved}

### Rollback used?

Yes / No - {If yes, why?}

### Lessons learned?

{What would we do differently next time?}

---

## Sign-off

- [ ] Changes complete and verified
- [ ] Tests passing
- [ ] Documentation updated
- [ ] Ready for peer review / merge

**Notes**: {Any additional context}
