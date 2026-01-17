# Implementation Plan: version-bump script fix

**Date**: 2026-01-17  
**Agent**: research.agent  
**Status**: Draft  
**Related Plan**: .github/plans/in-progress/versioning/script-fix/  
**Based on Spec**: 4-SPEC.md

---

## Overview

### Goal

Fix the version bump script to reference the correct agent file path and fail clearly when missing.

### Approach

Update [version-bump.sh](version-bump.sh) to resolve the repo root from the script location, set AGENT_FILE to .github/agents/vibe-flow.agent.md, and add a file existence guard.

### Estimated Effort

**Total**: 1-2 hours  
**Complexity**: 🟢 Low

---

## Pre-Implementation Checklist

- [ ] Spec reviewed and approved (4-SPEC.md)
- [ ] Research findings validated (3-RESEARCH.md)
- [ ] Test strategy defined

---

## Implementation Tasks

### ✅ Task 1: Update script path resolution

**Goal**: Ensure the script points to the canonical agent file location.

**Files**:

- [version-bump.sh](version-bump.sh) (modify)

**Steps**:

1. Resolve the repository root from the script directory.
2. Set AGENT_FILE to .github/agents/vibe-flow.agent.md under that root.

**Verification**:

- [ ] Run ./version-bump.sh patch from the repo root and confirm version updates.

**Dependencies**: None

**Estimated Time**: 30 minutes

**Status**: ⬜ Not Started

---

### ✅ Task 2: Add file existence guard and messaging

**Goal**: Provide a clear error when the agent file is missing.

**Files**:

- [version-bump.sh](version-bump.sh) (modify)

**Steps**:

1. Add a check that the agent file exists before parsing.
2. Print an actionable error that includes the expected path.

**Verification**:

- [ ] Run ./version-bump.sh patch from a non-repo working directory and confirm path anchoring.

**Dependencies**: Task 1

**Estimated Time**: 30 minutes

**Status**: ⬜ Not Started

---

## Risk Mitigation

| Task   | Risk                  | Impact | Mitigation                                             | Status      |
| ------ | --------------------- | ------ | ------------------------------------------------------ | ----------- |
| Task 1 | Path resolution wrong | Medium | Anchor to script directory and test from multiple CWDs | 🔄 Planning |

---

## Progress Tracking

### Summary

| Status         | Count | Tasks     |
| -------------- | ----- | --------- |
| ✅ Complete    | 0     | -         |
| 🔄 In Progress | 0     | -         |
| ⬜ Not Started | 2     | Tasks 1-2 |
| **Total**      | **2** | -         |

---

## Notes for Implement Agent

### Code Conventions

- Keep script logic minimal and consistent with existing Bash style.
- Avoid introducing external dependencies.

### Key Files to Reference

- [version-bump.sh](version-bump.sh)
- [.github/agents/vibe-flow.agent.md](.github/agents/vibe-flow.agent.md)

---

## Handoff to Implement Agent

When implement.agent picks up this plan:

1. Read this plan, 4-SPEC.md, and 3-RESEARCH.md.
2. Execute Task 1, then Task 2.
3. After each task, run manual verification steps and update 2-PROGRESS.md.

---

## Metadata

**Created By**: research.agent  
**Last Updated**: 2026-01-17  
**Version**: 1.0  
**Status**: Ready for implementation
