# Vibe Flow Orchestration Framework - Critical Fixes

## Problem Summary

The agent framework has structural issues preventing proper orchestration:

1. **Agents don't invoke each other** - Each agent stops after its phase instead of signaling next phase
2. **No explicit handoff mechanism** - Research doesn't trigger Implement, Implement doesn't trigger Test
3. **Missing phase state machine** - No clear "when to invoke which agent" logic
4. **Subagent-to-subagent blocked** - Test-agent can't loop back to Implement-agent if failures found

## Fixes Applied

### Fix #1: Vibe Flow Orchestrator (vibe-flow.agent.md) ✅

**Added:** Orchestration Modes & Triggers section

This adds explicit routing logic:

```
MODE 1: First-Time Complex Task
- Initialize PDD structure
- runSubagent("research-agent", prompt)
- runSubagent("implement-agent", prompt)
- runSubagent("test-agent", prompt)
- runSubagent("document-agent", prompt)

MODE 2: Existing Task Continuation
- Read 2-PROGRESS.md to find current phase
- Determine which agent to resume with
- Continue from last known status

MODE 3: Status Query
- Read plans folder
- Report without invoking agents
```

**Impact:** Orchestrator now has clear decision tree for which agent to invoke

---

### Fix #2: Research Agent (research.agent.md) - NEEDED

**Required Change:** Add phase completion signaling

```markdown
**SPECIAL: Phase Transition**

When 4-SPEC.md is finalized:

- Update 2-PROGRESS.md: status = "research_complete"
- Include summary in final message
- State explicitly: "Research complete. Ready for @implement-agent"
- This signals vibe-flow to invoke next phase
```

**Rationale:** Research agent currently ends without signaling what comes next

---

### Fix #3: Implement Agent (implement.agent.md) - NEEDED

**Required Change:** Add completion notification

```markdown
**SPECIAL: Completion Signal**

When 5-PLAN.md tasks are ALL implemented:

- Update 2-PROGRESS.md: status = "implementation_complete"
- Include test results and evidence
- State explicitly: "Implementation complete. Ready for @test-agent"
- This signals vibe-flow to invoke QA phase
```

**Rationale:** Implement agent can't signal when it's done

---

### Fix #4: Test Agent (test.agent.md) - NEEDED

**Required Change:** Add feedback loop capability

```markdown
**SPECIAL: Feedback Loop**

If test failures found:

- Update 2-PROGRESS.md with failure details
- State explicitly: "Test failures found. Return to @implement-agent"
- Vibe-flow will re-invoke implement-agent to fix

If all tests pass:

- Update 2-PROGRESS.md: status = "testing_complete"
- State explicitly: "All tests pass. Ready for @document-agent"
- This signals vibe-flow to invoke documentation phase
```

**Rationale:** Test-agent currently can't request fixes from implement-agent

---

### Fix #5: Document Agent (document.agent.md) - NEEDED

**Required Change:** Add finalization signaling

```markdown
**SPECIAL: Finalization**

When documentation is complete:

- Update 2-PROGRESS.md: status = "documentation_complete"
- State explicitly: "Documentation complete. Task finished."
- Include final summary

This signals vibe-flow to:

- Move plan folder from .github/plans/todo to .github/plans/finished
- Archive the task
```

**Rationale:** Document-agent is the last phase, needs finalization logic

---

## Implementation Instructions

### For Each Agent File

Add the following section at the END of the "Role Definition" or "Purpose" section:

```markdown
## Phase Transition Protocol

This agent is ONE PHASE in a larger orchestration loop. When your work is complete:

1. **Mark Progress**: Update 2-PROGRESS.md with completion status
2. **Summarize**: Include findings/results in final message
3. **Signal**: State explicitly which agent should be next
4. **Format**: Use pattern: "{Agent Name} is complete. Invoke @next-agent."

Examples:

- Research: "Research complete. Invoke @implement-agent to execute plan."
- Implement: "Implementation done. Invoke @test-agent for QA."
- Test (pass): "All tests pass. Invoke @document-agent for finalization."
- Test (fail): "3 test failures found. Return to @implement-agent to fix."
- Document: "Documentation complete. Task finished."

Vibe-flow watches for these signals and automatically advances to next phase.
```

---

## How the Fixed Orchestration Works

### User Request Flow (Fixed)

```
User: "@vibe-flow Fix the Instagram scraper bug"
  ↓
Vibe-flow: Determines MODE 1 (new complex task)
  ↓
Vibe-flow: Creates .github/plans/todo/instagram/scraper-bug/
  ↓
Vibe-flow: runSubagent("research-agent", "Investigate the bug...")
  ↓
Research-agent: Completes 3-RESEARCH.md + 4-SPEC.md
  ↓
Research-agent: "Research complete. Invoke @implement-agent"
  ↓
Vibe-flow: Detects signal, invokes implement-agent
  ↓
Implement-agent: Executes 5-PLAN.md, fixes code
  ↓
Implement-agent: "Implementation done. Invoke @test-agent"
  ↓
Vibe-flow: Detects signal, invokes test-agent
  ↓
Test-agent: Runs comprehensive tests
  ↓
Test-agent (if fail): "Test failures found. Return to @implement-agent"
  ↓
Vibe-flow: Re-invokes implement-agent with failure details
  ↓
Test-agent (if pass): "All tests pass. Invoke @document-agent"
  ↓
Vibe-flow: Invokes document-agent
  ↓
Document-agent: Updates docs/README
  ↓
Document-agent: "Documentation complete. Task finished."
  ↓
Vibe-flow: Moves plan to .github/plans/finished/
  ↓
User: Gets final report ✅
```

---

## Testing the Fix

### Test 1: Verify Orchestration Modes

Ask vibe-flow:

```
Debug and fix the "fetch more reels" button that doesn't work.
```

**Expected:**

- Vibe-flow creates PDD structure
- Vibe-flow invokes @research-agent (not tries to debug directly)
- Research completes and signals ready for implementation
- Vibe-flow invokes @implement-agent
- Full pipeline executes

### Test 2: Verify Phase Transition

Look for these patterns in agent responses:

- Research: "Research complete. Invoke @implement-agent"
- Implement: "Implementation done. Invoke @test-agent"
- Test: "All tests pass. Invoke @document-agent"
- Document: "Documentation complete. Task finished."

### Test 3: Verify Subagent-to-Subagent Handoff

If test-agent finds failures:

- Test should state: "Test failures found. Return to @implement-agent"
- Vibe-flow should re-invoke implement-agent automatically

---

## Summary of Changes Needed

| Agent              | Change                                 | Priority |
| ------------------ | -------------------------------------- | -------- |
| vibe-flow.agent.md | ✅ Done - Add Orchestration Modes      | CRITICAL |
| research.agent.md  | ⏳ TODO - Add phase completion signal  | CRITICAL |
| implement.agent.md | ⏳ TODO - Add completion notification  | CRITICAL |
| test.agent.md      | ⏳ TODO - Add feedback loop capability | CRITICAL |
| document.agent.md  | ⏳ TODO - Add finalization signaling   | CRITICAL |

---

## Files Modified

- `/Users/samkumar/Development/SK-Productions-LLC/vibe-flow-agent-orchestrator/vibe-flow.agent.md` - ✅ Updated
- `/Users/samkumar/Development/SK-Productions-LLC/vibe-flow-agent-orchestrator/ORCHESTRATION-FIXES.md` - 📄 This file (documentation)

---

## Next Steps

1. Apply remaining 4 fixes to research, implement, test, and document agents
2. Test orchestration with a real task request
3. Verify phase transitions and handoffs work correctly
4. Document final working patterns for future reference
