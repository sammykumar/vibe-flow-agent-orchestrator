---
name: plan-only
description: Create a plan-only PDD folder without starting execution
agent: vibe-flow
argument-hint: "What do you want to plan?"
---

# Plan Only (No Execution)

I want to create a plan-only PDD folder without starting execution.

**Plan Name**: ${input:planName}
**Major Area**: ${input:majorArea}
**Description**: ${input:description}

Please:

1. Create a new plan folder in `.github/plans/todo/{major-area}/{plan-name}/`.
2. Initialize `1-OVERVIEW.md` and `2-PROGRESS.md` to capture the plan context.
3. If needed, create placeholders for `3-RESEARCH.md`, `4-SPEC.md`, and `5-TASKS.md` without invoking subagents.
4. Stop after plan creation. Do not start research or implementation.
