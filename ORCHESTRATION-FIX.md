# Vibe Flow Orchestration Fix

**Date**: 2026-01-13  
**Issue**: Vibe Flow orchestrator was not invoking subagents via `runSubagent()`, instead solving problems directly  
**Root Cause**: Instructions were suggestive rather than mandatory; agents lacked clear scope boundaries

## Problem Analysis

From logs (`copilot_all_prompts_2026-01-13T01-40-39.chatreplay.json`):

- User requested debug of Instagram reel fetch functionality with instruction "be sure to leverage subagents"
- Model recognized available agents (`@vibe-flow`, `@research-agent`, `@implement-agent`, etc.)
- **Never invoked `runSubagent()` tool**
- Instead performed direct investigation via `grep_search`, `semantic_search`, `read_file`
- Result: Problem-solving mode, not orchestration mode

**Why it happened**:

1. Instructions were permissive ("use runSubagent for technical work") not mandatory
2. No explicit pattern for "when to delegate"
3. Subagents had no clear scope boundaries preventing them from attempting orchestration

## Solution Implemented

### 1. Vibe Flow Orchestrator (`vibe-flow.agent.md`)

**Added strong directive preamble:**

```markdown
**YOU ARE AN ORCHESTRATOR, NOT AN IMPLEMENTER.**

Your ONLY job is to:

1. Understand the user's request
2. Create the PDD plan structure
3. Invoke subagents via `runSubagent()` to do the actual work
4. Monitor progress and report status

**You do NOT:**

- Edit source code
- Debug directly
- Run tests locally
- Search for implementation details
- Solve technical problems yourself
```

**Added Immediate Action Trigger:**

```markdown
**EVERY USER REQUEST GETS ONE OF TWO PATHS:**

Path A: Complex Multi-Phase Task (MOST REQUESTS)
User Request → Initialize PDD → runSubagent(research-agent) →
Review Spec → runSubagent(implement-agent) →
runSubagent(test-agent) → runSubagent(document-agent) → Done

Path B: Status Check or Query
User Request → Read existing .github/plans/ → Report Status

**If unsure which path, default to Path A and use runSubagent immediately.**
```

**Made pattern explicit and mandatory:**

```markdown
### MANDATORY PATTERN: Orchestration Loop

**YOU MUST FOLLOW THIS EXACT SEQUENCE FOR EVERY REQUEST:**

1. **Analyze Request** → Determine task scope and required phases
2. **Initialize PDD** → Create `.github/plans/todo/{area}/{task}/` with `1-OVERVIEW.md` + `2-PROGRESS.md`
3. **Invoke Research** → `runSubagent("research-agent", detailed_prompt)`
4. **Await Specification Review** → Confirm spec is correct with user
5. **Invoke Implementation** → `runSubagent("implement-agent", task_prompt)` iteratively
6. **Invoke Testing** → `runSubagent("test-agent", qa_prompt)`
7. **Invoke Documentation** → `runSubagent("document-agent", doc_prompt)`
8. **Move to Finished** → Relocate plan folder
```

**Added explicit DO/DON'T list:**

```markdown
### CRITICAL: Never Skip Subagent Delegation

- ❌ DO NOT perform code edits yourself
- ❌ DO NOT investigate files directly (subagents do this)
- ❌ DO NOT attempt to "just quickly fix" something
- ✅ DO invoke `runSubagent()` with the full task context
- ✅ DO wait for subagent completion and review results
- ✅ DO report progress to the user between phases
```

### 2. Subagent Scope Clarification

**Added preamble to each subagent** (`research.agent.md`, `implement.agent.md`, `test.agent.md`, `document.agent.md`):

```markdown
**YOU ARE [ROLE], NOT ORCHESTRATION.**

You are only invoked by vibe-flow orchestrator. You do NOT:

- Plan multiple phases
- Invoke other subagents
- [Role-specific don'ts]

You ONLY:

- [Role-specific responsibilities]
```

This prevents any agent from:

- Attempting to orchestrate its own workflow
- Calling other subagents
- Making decisions outside its scope

## Expected Behavior Change

### Before Fix

```
User: "Debug the Instagram reels issue, use subagents"
└─ Model analyzes request
   ├─ Searches for relevant code (grep_search)
   ├─ Reads implementation files (read_file)
   ├─ Searches semantically (semantic_search)
   └─ Returns summary without ever invoking subagent
```

### After Fix

```
User: "Debug the Instagram reels issue, use subagents"
└─ Vibe Flow recognizes as Path A (complex task)
   ├─ Creates `.github/plans/todo/media-integration/fetch-reels-download-fix/`
   ├─ Invokes: runSubagent("research-agent", prompt)
   │   └─ research-agent investigates and returns 3-RESEARCH.md + 4-SPEC.md
   ├─ Reports findings to user
   ├─ Invokes: runSubagent("implement-agent", spec_prompt)
   │   └─ implement-agent fixes issue and returns 2-PROGRESS.md with evidence
   ├─ Invokes: runSubagent("test-agent", qa_prompt)
   │   └─ test-agent validates fix
   ├─ Invokes: runSubagent("document-agent", doc_prompt)
   │   └─ document-agent updates docs
   └─ Moves plan to `.github/plans/finished/`
```

## Testing the Fix

To validate the orchestration now works correctly:

1. Activate vibe-flow agent (with updated instructions)
2. Request a multi-phase task: "Debug the Instagram reels download issue on localhost:3000/media/instagram/abbyy.irl and fix it"
3. Verify:
   - ✅ PDD structure created at `.github/plans/todo/media-integration/fetch-reels-download-fix/`
   - ✅ First `runSubagent("research-agent", ...)` is called (not direct file reads)
   - ✅ Once research completes, progress is reported and implementation phase starts
   - ✅ Implementation-agent makes code changes (not orchestrator)
   - ✅ Testing and documentation phases follow
   - ✅ Plan moves to `finished/` folder

## Files Modified

1. `vibe-flow.agent.md` - Mandatory orchestration pattern + explicit DO/DON'T rules
2. `research.agent.md` - Scope preamble added
3. `implement.agent.md` - Scope preamble added
4. `test.agent.md` - Scope preamble added
5. `document.agent.md` - Scope preamble added

## Key Principles

1. **Orchestration is Mandatory**: Vibe Flow must ALWAYS use `runSubagent()` for technical work
2. **Clear Scope Boundaries**: Each agent knows exactly what it should and shouldn't do
3. **Progressive Delegation**: Work flows through agents sequentially with clear handoffs
4. **Verification over Implementation**: Orchestrator verifies work, never implements
5. **Progress Tracking**: `.github/plans/*/2-PROGRESS.md` is single source of truth

## Next Steps

1. Test with the Instagram reels debugging task
2. Monitor that `runSubagent()` is properly invoked
3. Verify each agent completes its phase before next phase starts
4. Document any edge cases or improvements needed
