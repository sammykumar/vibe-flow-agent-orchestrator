# Implementation Plan: README Parallel Subagents Explanation (v2)

**Date**: 2026-01-16  
**Agent**: research.agent  
**Status**: Draft  
**Related Plan**: [.github/plans/in-progress/docs/parallel-subagents-visualization/](.github/plans/in-progress/docs/parallel-subagents-visualization/)  
**Based on Spec**: [4-SPEC.md](.github/plans/in-progress/docs/parallel-subagents-visualization/4-SPEC.md)

---

## Overview

### Goal

Update the README with a plain-language explanation of v2 parallel subagents and a Mermaid diagram showing sequential flow plus an opt-in read-only parallel branch.

### Approach

Add a new subsection immediately after the existing workflow diagram and before Quick Start, using the final text and Mermaid content defined in the spec.

### Estimated Effort

**Total**: 1–2 hours  
**Complexity**: 🟢 Low

---

## Pre-Implementation Checklist

- [ ] Spec reviewed and approved ([4-SPEC.md](.github/plans/in-progress/docs/parallel-subagents-visualization/4-SPEC.md))
- [ ] Research findings validated ([3-RESEARCH.md](.github/plans/in-progress/docs/parallel-subagents-visualization/3-RESEARCH.md))
- [ ] Mermaid diagram content finalized

---

## Implementation Tasks

### ✅ Task 1: Insert README subsection and diagram

**Goal**: Add the v2 parallel subagent explanation and Mermaid diagram.

**Files**:

- [README.md](README.md#L79-L81) (modify)

**Steps**:

1. Insert a new subsection after the existing workflow diagram block and before Quick Start.
2. Paste the plain-language explanation text from the spec.
3. Insert the Mermaid diagram block from the spec immediately below the explanation.

**Verification**:

- [ ] Markdown preview renders the new diagram correctly
- [ ] Text explicitly scopes to v2 and read-only parallel behavior
- [ ] Existing workflow diagram remains unchanged

**Dependencies**: None

**Estimated Time**: 1–2 hours

**Status**: ✅ Complete

**Notes**: Use the exact content in [4-SPEC.md](.github/plans/in-progress/docs/parallel-subagents-visualization/4-SPEC.md).

---

## Progress Tracking

### Summary

| Status         | Count | Tasks  |
| -------------- | ----- | ------ |
| ✅ Complete    | 1     | Task 1 |
| 🔄 In Progress | 0     | -      |
| ⬜ Not Started | 0     | -      |
| **Total**      | **1** | -      |

### Completion Criteria

- [x] Task 1 marked as ✅ Complete
- [ ] Mermaid diagram renders correctly in README
- [ ] Plain-language explanation is clear and v2-scoped

---

## Notes for Implement Agent

### Documentation Conventions

- Keep the new subsection short and readable.
- Use the same Mermaid style patterns as existing diagrams.

### Key Files to Reference

- [README.md](README.md#L21-L81)
- [4-SPEC.md](.github/plans/in-progress/docs/parallel-subagents-visualization/4-SPEC.md)

---

## Handoff to Implement Agent

When `implement.agent` picks up this plan:

1. **Read**: This plan + [4-SPEC.md](.github/plans/in-progress/docs/parallel-subagents-visualization/4-SPEC.md) + [3-RESEARCH.md](.github/plans/in-progress/docs/parallel-subagents-visualization/3-RESEARCH.md)
2. **Execute**: Task 1
3. **Verify**: Diagram renders in Markdown preview
4. **Update**: [2-PROGRESS.md](.github/plans/in-progress/docs/parallel-subagents-visualization/2-PROGRESS.md) with completion status

---

## Metadata

**Created By**: research.agent  
**Last Updated**: 2026-01-16  
**Version**: 1.0  
**Status**: Ready for implementation
