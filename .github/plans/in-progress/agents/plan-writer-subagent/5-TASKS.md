# Task Plan: plan-writer subagent

**Date**: 2026-01-17  
**Agent**: plan-writer.agent  
**Status**: Draft  
**Related Plan**: `.github/plans/in-progress/agents/plan-writer-subagent/`  
**Based on Spec**: 4-SPEC.md

---

## Overview

### Goal

Introduce a plan-writer subagent, update the workflow to insert a planning phase between research and implement, and rename 5-PLAN.md to 5-TASKS.md across canonical docs/prompts/templates.

### Approach

Add a new plan-writer agent definition, update orchestrator workflow references, and update all documentation and prompts to use 5-TASKS.md. Require 5-TASKS.md going forward and preserve historical plan artifacts.

### Estimated Effort

**Total**: 1–2 days  
**Complexity**: 🟡 Medium

---

## Pre-Implementation Checklist

- [ ] Spec reviewed and approved (4-SPEC.md)
- [ ] Research findings validated (3-RESEARCH.md)
- [ ] Migration strategy agreed for 5-PLAN.md → 5-TASKS.md (no fallback)

---

## Implementation Tasks

### ✅ Task 1: Add plan-writer subagent definition

**Goal**: Define a plan-writer agent with scope limited to producing the task file.

**Files**:

- .github/agents/plan-writer.agent.md (create)
- .github/agents/vibe-flow.agent.md (update: subagent list + workflow)

**Steps**:

1. Create plan-writer agent file with clear scope, outputs, and handoff signal.
2. Update orchestrator to call plan-writer after research and before implement.
3. Update orchestrator subagent roster to include plan-writer.

**Verification**:

- [ ] Orchestrator text mentions plan-writer phase and expected outputs
- [ ] Plan-writer agent references 5-TASKS.md

**Dependencies**: None

**Estimated Time**: 2–4 hours

**Status**: ⬜ Not Started

---

### ✅ Task 2: Update research and implement agent responsibilities

**Goal**: Move ownership of the task file to plan-writer and align implement agent to 5-TASKS.md.

**Files**:

- .github/agents/research.agent.md (update outputs)
- .github/agents/implement.agent.md (update to read/write 5-TASKS.md)
- .github/agents/v1/research.agent.md (optional update or note as legacy)
- .github/agents/v1/implement.agent.md (optional update or note as legacy)

**Steps**:

1. Remove 5-PLAN.md from research agent required outputs.
2. Add 5-TASKS.md as the implement agent source of truth.
3. Require 5-TASKS.md as the sole task source of truth.

**Verification**:

- [ ] Research agent outputs list excludes 5-PLAN.md
- [ ] Implement agent references 5-TASKS.md as the sole task source

**Dependencies**: Task 1

**Estimated Time**: 2–4 hours

**Status**: ⬜ Not Started

---

### ✅ Task 3: Update orchestration skill, protocol, and workflow docs

**Goal**: Reflect the new plan-writer phase and file naming.

**Files**:

- .github/skills/orchestration/SKILL.md
- .github/skills/orchestration/references/workflow.md
- docs/vibeflow/pdd-protocol.md
- docs/vibeflow/orchestrator-manual.md
- docs/vibeflow/research-skill.md

**Steps**:

1. Replace references to 5-PLAN.md with 5-TASKS.md where appropriate.
2. Insert plan-writer phase between research and implement.
3. Update subagent roles and outputs accordingly.

**Verification**:

- [ ] Protocol describes plan-writer phase
- [ ] Docs consistently reference 5-TASKS.md

**Dependencies**: Task 1

**Estimated Time**: 3–6 hours

**Status**: ⬜ Not Started

---

### ✅ Task 4: Update prompts and templates

**Goal**: Align prompts and templates to the new plan file name.

**Files**:

- .github/prompts/update-feature.prompt.md
- .github/prompts/plan-only.prompt.md
- .github/skills/orchestration/assets/overview-template.md
- .github/skills/orchestration/assets/progress-log-template.md
- .github/skills/orchestration/assets/spec-template.md
- .github/skills/research/SKILL.md
- .github/skills/research/assets/spec-template.md
- docs/templates/plan-template.md
- docs/templates/progress-log-template.md
- docs/templates/spec-template.md

**Steps**:

1. Replace 5-PLAN.md references with 5-TASKS.md.
2. Ensure plan-only prompt creates placeholders for 5-TASKS.md.
3. Ensure spec templates link to 5-TASKS.md.

**Verification**:

- [ ] Prompts point to 5-TASKS.md
- [ ] Templates consistently reference 5-TASKS.md

**Dependencies**: Task 3

**Estimated Time**: 3–6 hours

**Status**: ⬜ Not Started

---

### ✅ Task 5: Update README and installer/update prompts

**Goal**: Keep public docs and install/update flows in sync with the new agent.

**Files**:

- README.md
- install-vibeflow.md
- update-vibeflow.md

**Steps**:

1. Add plan-writer agent to README list and workflow diagrams.
2. Update install and update instructions to fetch plan-writer agent.
3. Ensure any mention of 5-PLAN.md is replaced with 5-TASKS.md.

**Verification**:

- [ ] README shows plan-writer flow and 5-TASKS.md
- [ ] install/update instructions include plan-writer agent

**Dependencies**: Task 1

**Estimated Time**: 2–4 hours

**Status**: ⬜ Not Started

---

## Risk Mitigation

### High-Risk Tasks

| Task   | Risk                         | Impact | Mitigation                         | Status     |
| ------ | ---------------------------- | ------ | ---------------------------------- | ---------- |
| Task 2 | Compatibility with old plans | Medium | Document migration to 5-TASKS.md   | ⬜ Planned |
| Task 3 | Inconsistent doc references  | Medium | Use a single reference checklist   | ⬜ Planned |
| Task 5 | Installer drift              | Medium | Explicitly list new agent in steps | ⬜ Planned |

### Destructive Actions

No destructive actions planned.

---

## Progress Tracking

### Summary

| Status         | Count | Tasks     |
| -------------- | ----- | --------- |
| ✅ Complete    | 0     | -         |
| 🔄 In Progress | 0     | -         |
| ⬜ Not Started | 5     | Tasks 1-5 |
| **Total**      | **5** | -         |

---

## Handoff to Implement Agent

When implement.agent picks up this plan:

1. **Read**: This plan + 4-SPEC.md + 3-RESEARCH.md.
2. **Start**: With Task 1 (sequential execution).
3. **After Each Task**:
   - Update 2-PROGRESS.md
   - Mark task as ✅ Complete in this file
4. **Continue**: Until all tasks complete.
5. **Signal**: "Implementation complete" back to orchestrator.

---

## Metadata

**Created By**: research.agent  
**Last Updated**: 2026-01-17  
**Version**: 1.0  
**Status**: Ready for implementation
