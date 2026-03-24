---
name: orchestration
description: "Plan-Driven Development (PDD) orchestration workflow for managing multi-step development tasks through a structured pipeline (Fast Track or Research → Orchestrator Planning → Implement → Test). Use when managing complex feature development, bug fixes, or any work requiring coordination across research, planning, implementation, and testing phases. This skill defines how to delegate to specialized subagents, maintain progress tracking, and ensure quality through systematic verification."
---

# Orchestration & Delegation

This skill defines the orchestration workflow for managing complex development tasks through specialized subagents in a Plan-Driven Development (PDD) pipeline.

The workflow has two lanes:

- **Fast Track** for small to medium, bounded, low-risk changes that can move straight from plan initialization to implementation and testing.
- **Full PDD** for larger, ambiguous, cross-cutting, or risky changes that need research and approval gates before implementation.

Both lanes still create and maintain the PDD files under `.github/plans/{status}/{domain}/{scope-path}/{task-name}/`.

For implementation, prefer sequential `implement.agent` runs on isolated tasks with non-overlapping file ownership. Only parallelize work when the tasks are read-only or clearly disjoint.

## Core Principles

**Verification over Implementation**: Focus on coordinating subagents, not performing implementation yourself.

**Audit Mindset**: Before closing any task, verify every subagent fulfilled its duties (test coverage, diagrams, documentation).

**Progress-Driven**: The single source of truth is `.github/plans/in-progress/{domain}/{scope-path}/{task-name}/1-PROGRESS.md`.

**Sequential Execution (write-capable)**: Call write-capable subagents sequentially until ALL tasks are declared complete in the progress file.

**Parallel Read-only Helpers (default)**: Read-only research helpers may run in parallel by default; write-capable subagents remain sequential.

**High Signal Updates**: Prefer concise, outcome-focused updates. Use diffs and test logs over verbose narrative.

## Subagent Roster

- `research.agent` - Investigation & specification writing
- `implement.agent` - Code changes & bug fixes
- `test.agent` - QA: writes and runs tests to prove functionality

## PDD File Structure

All work tracked in: `.github/plans/{status}/{domain}/{scope-path}/{task-name}/`

### Plan Taxonomy

- `domain`: stable top-level functional area such as `ui`, `app`, `infra`, `data`, `docs`, or `agents`
- `scope-path`: one or more reusable grouping folders under the domain, such as `card-v2`, `navigation`, `media/reddit`, or `deploy/github-actions`
- `task-name`: the concrete plan slug for a single unit of work

Rules:

1. Inspect existing folders across `.github/plans/{todo,in-progress,finished}/` before creating a new plan.
2. Reuse an existing `domain` when the work fits inside it.
3. Reuse or extend an existing `scope-path` when the work belongs to the same subsystem, feature family, component, or service.
4. Do not create synthetic top-level folders that collapse hierarchy, such as `ui-system`, when the correct placement is `ui/...`.
5. Agent-created plans MUST include at least one `scope-path` segment.

Examples:

- `.github/plans/in-progress/ui/card-v2/footer-overlay-actions-2026-03-24/`
- `.github/plans/in-progress/app/navigation/app-shell-refactor/`
- `.github/plans/in-progress/infra/deploy/github-actions-cache/`

Required files:

- `1-PROGRESS.md` - **Single source of truth** for tasks and current state
- `2-RESEARCH.md` - Investigation findings
- `3-SPEC.md` - Business context + technical specification

**Templates**: PDD file templates are available in [assets/](assets/) directory:

- [research-template.md](assets/research-template.md)
- [spec-template.md](assets/spec-template.md)
- [progress-log-template.md](assets/progress-log-template.md)

The files under `assets/` are the runtime templates used by the skill. The copies in `docs/templates/` are reference material only and are not read automatically by the agents.

## Orchestration Workflow

### Lane Selection

Before starting, classify the request:

1. Use **Fast Track** when the requested change is bounded, low-risk, and the implementation path is already clear.
2. Use **Full PDD** when the change is large, ambiguous, cross-cutting, high-risk, or the user explicitly asks for research or approval checkpoints.

### Fast Track PDD

1. Initialize `.github/plans/in-progress/{domain}/{scope-path}/{task-name}/`
2. Initialize `1-PROGRESS.md` with a compact task plan
3. Split work into isolated implementation tasks where possible
4. Invoke the implement agent sequentially for each isolated task
5. Use parallel helpers only for read-only discovery or clearly disjoint work
6. Invoke the test agent
7. Review results and complete the task

### Full PDD

### STEP 1: Initialize

**New Task:**

1. Create `.github/plans/in-progress/{domain}/{scope-path}/{task-name}/`
2. Initialize `1-PROGRESS.md` (tasks and progress log)
3. Initialize task tracking with phases: Research, Orchestrator Planning, Implement, Test, Final Review

**Existing Task:**

1. Read `1-PROGRESS.md` to determine current state
2. Resume task tracking state

**Critical**: All agent-created tasks must be created in `in-progress/` directory. Use `todo/` only for user plan-only/manual planning requests (no execution).

### STEP 2: Research Phase

1. **Invoke**: Call research agent with absolute path to plan directory
2. **Wait**: For signal "Research phase complete"
3. **Verify**: Confirm `2-RESEARCH.md` and `3-SPEC.md` exist
4. **Review**: Use `#tool:agent/askQuestions` to ask the user whether to proceed with orchestrator-authored planning (keeps the PDD cycle in a single chat turn)
5. **Update**: Mark Research phase complete in task tracking

### STEP 3: Orchestrator Planning Phase

1. **Author**: Orchestrator writes task breakdown into `1-PROGRESS.md` directly from `2-RESEARCH.md` and `3-SPEC.md`
2. **Verify**: Confirm `1-PROGRESS.md` includes task list with file targets, verification steps, and dependencies
3. **Review**: Use `#tool:agent/askQuestions` to ask the user whether to proceed with implementation (keeps the PDD cycle in a single chat turn)
4. **Update**: Mark Orchestrator Planning phase complete in task tracking

### STEP 4: Implementation Phase

1. **Invoke**: Call implement agent with absolute path to plan directory
2. **Scope**: Prefer one isolated task per invocation when file ownership is narrow and non-overlapping
3. **Loop**: Continue calling until `1-PROGRESS.md` shows all tasks complete
4. **Monitor**: Check progress file after each invocation
5. **Update**: Mark tasks complete in task tracking as progress is made

### STEP 5: Test Phase

1. **Invoke**: Call test agent with absolute path to plan directory and summary of what was implemented
2. **Wait**: For signal "Testing complete" or "Testing blocked"
3. **If blocked**: Re-invoke implement agent to fix reported bugs, then re-invoke test agent
4. **Loop**: Continue implement→test cycle until all tests pass
5. **Verify**: Confirm `1-PROGRESS.md` contains test results with pass/fail evidence
6. **Update**: Mark Test phase complete in task tracking

### STEP 6: Final Review

1. **Summarize**: Review `1-PROGRESS.md` for completion signals, implementation evidence, AND passing test evidence.
2. **Gate**: A plan is NOT complete unless the test agent confirms all tests pass.
3. **Update**: Mark Final Review complete in task tracking.

**Final Review Checklist:**

1. **Progress Status**: `1-PROGRESS.md` shows completion signals
2. **Tests Passing**: Test agent confirmed all tests pass with evidence logged
3. **README**: Updated to reflect new state (if required)
4. **Cleanup**: All temporary POC or test files removed

**Note**: Task folder remains in `in-progress/`. User manually moves to `.github/plans/finished/{domain}/{scope-path}/{task-name}/` after verification.

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
The plan directory is at /absolute/path/to/.github/plans/in-progress/app/auth/oauth-integration.
Create research findings, technical spec, and execution plan."
```

## Stopping Rules

**Stop immediately** if you consider:

- Editing source code or fixing bugs yourself (ONLY subagents do this)
- Running tests locally yourself (delegate to test-agent)
- Investigating file content to solve problems (ONLY research agent does this)
- Skipping PDD structure creation
- Calling write-capable subagents in parallel or violating the single-writer rule
- Skipping the Test phase after implementation

## Task Tracking Requirements

Use task tracking tool to maintain visibility:

1. Create tasks for each orchestration phase
2. Mark ONE task as in-progress before starting
3. Mark completed IMMEDIATELY after finishing
4. Never batch completions

Phases to track:

- Research
- Orchestrator Planning
- Implement (may have multiple tasks based on plan)
- Test
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

- `todo` - Plan-only/manual requests (user-created; no execution)
- `in-progress` - Active work (agents always initialize here)
- `finished` - Complete and verified (but still in in-progress folder until user manually archives)

Plan-only requests should use the **plan-only prompt** to create a `todo/` plan and stop without invoking subagents.
