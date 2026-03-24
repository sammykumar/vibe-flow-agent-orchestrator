---
name: plan-only
description: Create a plan-only PDD folder without starting execution
agent: vibe-flow
argument-hint: "What do you want to plan?"
---

# Plan Only (No Execution)

I want to create a plan-only PDD folder without starting execution.

**Plan Name**: ${input:planName}
**Plan Scope Path**: ${input:majorArea}
**Description**: ${input:description}

Please:

1. Create a new plan folder in `.github/plans/todo/{domain}/{scope-path}/{plan-name}/`.
2. Treat the provided scope as a hierarchy such as `ui/card-v2`, `app/navigation`, or `infra/deploy`.
3. Reuse an existing top-level domain when the work belongs under it; do not create flattened siblings like `ui-system` when the correct placement is under `ui/...`.
4. Initialize `1-PROGRESS.md` to capture the plan context.
5. If needed, create placeholders for `2-RESEARCH.md` and `3-SPEC.md` without invoking subagents.
6. Stop after plan creation. Do not start research or implementation.
