# Research: Parallel Subagent Compatibility for Vibe Flow

## Context

- Goal: Assess VS Code/Copilot Chat parallel subagent changes and define safe orchestration updates for Vibe Flow.
- Stakeholders: Vibe Flow maintainers, users of custom agents in VS Code.
- Audience: Orchestrator/agent prompt authors and workflow maintainers.

## Codebase Analysis

### Key files inspected

- [.github/agents/vibe-flow.agent.md](.github/agents/vibe-flow.agent.md)
- [.github/agents/research.agent.md](.github/agents/research.agent.md)
- [docs/vibeflow/orchestrator-manual.md](docs/vibeflow/orchestrator-manual.md)
- [docs/vibeflow/pdd-protocol.md](docs/vibeflow/pdd-protocol.md)

### Architectural notes

- Orchestrator guidance explicitly mandates sequential subagent execution ("Sequential Execution" and "MANDATORY: Always invoke subagents sequentially").
- PDD workflow assumes a single active subagent at a time, with `2-PROGRESS.md` as the single source of truth for execution ordering.
- Research agent constraints forbid invoking other subagents and emphasize a single-writer model within the plan folder.

### Hotspots / risk areas

- `2-PROGRESS.md` is an append-only log but lacks concurrency metadata (subagent ID, concurrency group, lock scope), which risks interleaving and auditability loss under parallel runs.
- Plan-driven workflow implicitly assumes deterministic ordering of subagent outputs and tool confirmations.

## External Discovery

### Links & evidence (public)

- VS Code issue: https://github.com/microsoft/vscode/issues/286606 (Chat subagent UX, parallel execution goal; describes current synchronous behavior and UX considerations) — accessed 2026-01-16.
- Copilot Chat PR: https://github.com/microsoft/vscode-copilot-chat/pull/2839 (support parallel subagents; refactors subagent tracking to ID-based) — accessed 2026-01-16.

### Extracted findings

1. Current behavior described in issue: subagents run synchronously, and parallel tool calls are serialized. The monthly goal is parallel execution with improved UX. (Issue 286606)
2. Copilot Chat PR introduces `subAgentInvocationId` in place of boolean `isSubagent` / `fromSubAgent` flags. This indicates distinct subagent runs can be tracked and run concurrently. (PR 2839)
3. Tool invocation metadata now carries `subAgentInvocationId` to group tool calls and confirmations by subagent run. (PR 2839)
4. Response stream `beginToolInvocation` accepts `ChatToolInvocationStreamData`, enabling per-invocation data (including `subAgentInvocationId`) to flow into UI rendering. (PR 2839)
5. API version bump to `chatParticipantPrivate@12` indicates a contract update required by clients/extensions. (PR 2839)

## Implications for Vibe Flow

- **Parallel invocation**: The platform can run multiple subagents concurrently; Vibe Flow’s explicit sequential-only rules will conflict with platform capability and may cause confusing behavior if users try to parallelize.
- **Response ordering**: Subagent outputs can arrive out-of-order relative to invocation order, so orchestrator logic must not assume sequential response arrival.
- **Isolation**: No evidence of per-subagent workspace isolation; edits and tool invocations still operate in the same VS Code workspace, implying potential write conflicts.
- **Tool concurrency**: Tool confirmations and outputs can appear in multiple subagent UI panels, increasing the risk of mismatched confirmation or missed prompts.

## Alternative Matrix

| Approach                                                                                              | Pros                                                            | Cons                                                                 | Recommendation              |
| ----------------------------------------------------------------------------------------------------- | --------------------------------------------------------------- | -------------------------------------------------------------------- | --------------------------- |
| A. Keep strict sequential-only execution                                                              | Simple mental model; avoids conflicts                           | Leaves performance gains unused; conflicts with platform UX          | ⚠️ Short-term fallback only |
| B. Allow limited parallelism for read-only tasks (research/analysis) with explicit locking for writes | Safer concurrency; preserves auditability; aligns with platform | Requires prompt and workflow updates; added orchestration complexity | ✅ RECOMMENDED              |
| C. Full parallel execution across phases                                                              | Max performance                                                 | High risk of write conflicts, non-deterministic logs, audit loss     | ❌ Not recommended now      |

## Recommendation

- **Adopt Option B**: Introduce a controlled parallelism model that allows concurrent read-only subagents, while enforcing single-writer constraints for any file edits or plan updates. Add explicit concurrency metadata to progress tracking and require deterministic reconciliation.

## Evidence & Artifacts

- Issue and PR excerpts captured above; PR diff shows `subAgentInvocationId` replacing boolean subagent markers and adding stream data for tool invocation UI.

---

_Generated by `research` skill._
