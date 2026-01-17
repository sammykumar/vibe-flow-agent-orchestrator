---
name: orchestration
description: "Plan-Driven Development (PDD) orchestration workflow for managing multi-step development tasks through a structured pipeline (Research → Plan → Implement). Use when managing complex feature development, bug fixes, or any work requiring coordination across research and implementation phases. This skill defines how to delegate to specialized subagents, maintain progress tracking, and ensure quality through systematic verification."
---

# Orchestration & Delegation

This skill defines the orchestration workflow for managing complex development tasks through specialized subagents in a Plan-Driven Development (PDD) pipeline.

## Core Principles

**Verification over Implementation**: Focus on coordinating subagents, not performing implementation yourself.

**Audit Mindset**: Before closing any task, verify every subagent fulfilled its duties (test coverage, diagrams, documentation).

**Progress-Driven**: The single source of truth is `.github/plans/in-progress/{major-area}/{task-name}/2-PROGRESS.md`.

**Sequential Execution (write-capable)**: Call write-capable subagents sequentially until ALL tasks are declared complete in the progress file.

**Parallel Read-only Helpers (default)**: Read-only research helpers may run in parallel by default; write-capable subagents remain sequential.

**High Signal Updates**: Prefer concise, outcome-focused updates. Use diffs and test logs over verbose narrative.

## Subagent Roster (v2)

- `research.agent` - Investigation & specification writing
- `implement.agent` - Code changes & bug fixes

## PDD File Structure

All work tracked in: `.github/plans/{status}/{major-area}/{task-name}/`

Required files:

- `1-OVERVIEW.md` - Business goal and context
- `2-PROGRESS.md` - **Single source of truth** for current state
- `3-RESEARCH.md` - Investigation findings
- `4-SPEC.md` - Technical specification
- `5-PLAN.md` - Step-by-step execution tasks

**Templates**: PDD file templates are available in [assets/](assets/) directory:

- [overview-template.md](assets/overview-template.md)
- [progress-log-template.md](assets/progress-log-template.md)
- [research-template.md](assets/research-template.md)
- [spec-template.md](assets/spec-template.md)
- [plan-template.md](assets/plan-template.md)

## Orchestration Workflow

### STEP 1: Initialize

**New Task:**

1. Create `.github/plans/in-progress/{major-area}/{task-name}/`
2. Initialize `1-OVERVIEW.md` (goals) and `2-PROGRESS.md` (logs)
3. Initialize task tracking with phases: Research, Implement, Final Review

**Existing Task:**

1. Read `2-PROGRESS.md` to determine current state
2. Resume task tracking state

**Critical**: All agent-created tasks must be created in `in-progress/` directory. Use `todo/` only for user plan-only/manual planning requests (no execution).

### STEP 2: Research Phase

1. **Invoke**: Call research agent with absolute path to plan directory
2. **Wait**: For signal "Research phase complete"
3. **Verify**: Confirm `3-RESEARCH.md`, `4-SPEC.md`, AND `5-PLAN.md` exist
4. **Review**: Ask user to review `4-SPEC.md` and `5-PLAN.md` if changes are critical
5. **Update**: Mark Research phase complete in task tracking

### STEP 3: Implementation Phase

1. **Invoke**: Call implement agent with absolute path to plan directory
2. **Loop**: Continue calling until `2-PROGRESS.md` shows all tasks complete
3. **Monitor**: Check progress file after each invocation
4. **Update**: Mark tasks complete in task tracking as progress is made

### STEP 4: Stop after Implement (v2)

1. **Summarize**: Review `2-PROGRESS.md` for completion signals and evidence.
2. **Confirm**: Ask the user whether to add the next subagent (Test/Document are future phases).
3. **Update**: Mark Final Review complete in task tracking.

**Final Review Checklist (v2):**

1. **Progress Status**: `2-PROGRESS.md` shows completion signals
2. **README**: Updated to reflect new state (if required)
3. **Cleanup**: All temporary POC or test files removed

**Note**: Task folder remains in `in-progress/`. User manually moves to `.github/plans/finished/{major-area}/{task-name}/` after verification.

**Report**: Notify user of completion and that they can archive the plan.

**Update**: Mark Final Review complete in task tracking.

## Subagent Invocation Pattern

When invoking a subagent:

1. **Provide Context**: Include absolute path to active plan directory
2. **Be Explicit**: Use plain language prompts, not code/pseudocode
3. **Be Specific**: Clearly state what the subagent must accomplish
4. **Sequential for write-capable**: Wait for completion before invoking next write-capable subagent; read-only helpers may run in parallel

Example invocation:

```
research.agent: "Investigate the authentication flow in the codebase.
The plan directory is at /absolute/path/to/.github/plans/in-progress/auth/oauth-integration.
Create research findings, technical spec, and execution plan."
```

## Stopping Rules

**Stop immediately** if you consider:

- Editing source code or fixing bugs yourself (ONLY subagents do this)
- Running tests locally yourself (no test agent in v2)
- Investigating file content to solve problems (ONLY research agent does this)
- Skipping PDD structure creation
- Calling write-capable subagents in parallel or violating the single-writer rule

## Task Tracking Requirements

Use task tracking tool to maintain visibility:

1. Create tasks for each orchestration phase
2. Mark ONE task as in-progress before starting
3. Mark completed IMMEDIATELY after finishing
4. Never batch completions

Phases to track:

- Research
- Implement (may have multiple tasks based on plan)
- Final Review

## Failure Handling

**If subagent fails:**

1. Review the error/incomplete output
2. Ask clarifying questions to user if needed
3. Re-invoke subagent with additional context
4. Do not proceed to next phase until current phase succeeds

**If critical tool unavailable:**

- Fail fast and report to user immediately

## Quality Verification Checklist

Before marking task complete, verify:

- [ ] All PDD files exist and are complete
- [ ] Implementation complete per `5-PLAN.md`
- [ ] Happy-path verification recorded by implement agent
- [ ] README reflects changes
- [ ] Cleanup performed (no temp files)
- [ ] Progress file shows `finished` status

## Status Values

- `todo` - Plan-only/manual requests (user-created; no execution)
- `in-progress` - Active work (agents always initialize here)
- `finished` - Complete and verified (but still in in-progress folder until user manually archives)

Plan-only requests should use the **plan-only prompt** to create a `todo/` plan and stop without invoking subagents.
