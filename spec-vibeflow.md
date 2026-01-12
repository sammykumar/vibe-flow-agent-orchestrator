# Vibe Flow – Multi-Agent AI Development Workflow (PDD)

## 1. Overview

This document defines the architecture and best-practice design for a VS Code Copilot multi-agent workflow using:

- **One orchestrator agent:** `vibe-flow`
- **Multiple specialist sub-agents**
- **Plan-Driven Development (PDD)** as the execution model
- **VS Code Custom Agents + Skills + MCP servers**

Goals:

- Enforce structured engineering research agent (spec & plan) → beast mode agent (implement) → test agent → document agent)
- Reduce hallucinated implementation
- Preserve project memory via filesystem artifacts
- Enable scalable, auditable AI-assisted development

---

## 2. Plan-Driven Development (PDD) File Contract

All work happens inside:

```
.github/plans/{status}/{major-area}/{task-name}/
```

Status Options

```
- todo
- in-progress
- finished 
```

Major Area Examples:

```
- core
- agents
- skills
- mcp-servers
- infrastructure
- ci-cd
- ui
- api
- data
- observability
- documentation
- security
```

Required files:

```
1-OVERVIEW.md
2-PROGRESS.md
3-RESEARCH.md
4-SPEC.md
5-PLAN.md
```

Documentation output:

```
docs/{major-area}/{doc}.md
```

### File semantics

| File          | Purpose                                |
| ------------- | -------------------------------------- |
| 1-OVERVIEW.md | Business context + goals               |
| 2-PROGRESS.md | Append-only execution log              |
| 3-RESEARCH.md | Investigation + **Alternative Matrix** |
| 4-SPEC.md     | Tech Spec + **Impact Analysis**        |
| 5-PLAN.md     | Step-by-step implementation plan       |

### Progress file format (recommended)

```markdown
# Progress Log

> Purpose: chronological, factual record of what changed, why, and what the result was.

## Quick Index

| Date       | Work Item       |  Status | Key outputs                      |
| ---------- | --------------- | ------: | -------------------------------- |
| 2026-01-12 | Implement Agent | ✅ PASS | API endpoint X, 3 files, 6 tests |
| 2026-01-12 | Test Agent      | ✅ PASS | unit/api, 0 failures             |

---

## 2026-01-12 — Implement Agent

### Summary

| Field   | Value                                                |
| ------- | ---------------------------------------------------- |
| Goal    | Implement API endpoint X                             |
| Scope   | Agent core + routing                                 |
| Status  | ✅ PASS                                              |
| Owner   | (optional)                                           |
| Related | Issue: #**_ • PR: #_** • Plan: `./.github/plans/...` |

### Changes

| Area              | Details                                                                               |
| ----------------- | ------------------------------------------------------------------------------------- |
| What changed      | - Added endpoint `POST /api/x`<br>- Wired handler into router<br>- Updated validation |
| Notes / decisions | - Chose approach Y because **_<br>- Known limitation: _**                             |

**Files changed**

- `path/to/file1.ts`
- `path/to/file2.ts`
- `path/to/file3.ts`

### Tests

| Type | Location        | Added/Updated | Result |
| ---- | --------------- | ------------: | -----: |
| Unit | `test/unit/...` |             4 |     ✅ |
| API  | `test/api/...`  |             2 |     ✅ |

### Run Output (optional)

| Command     | Result  |
| ----------- | ------- |
| `pnpm test` | ✅ PASS |
| `pnpm lint` | ✅ PASS |

### Risks

| Risk   | Impact       | Likelihood   | Mitigation | Owner  | Link            |
| ------ | ------------ | ------------ | ---------- | ------ | --------------- |
| \_\_\_ | Low/Med/High | Low/Med/High | \_\_\_     | \_\_\_ | Issue/PR \_\_\_ |

### Follow-ups

| Item   | Priority | Owner  | Due        | Link         |
| ------ | -------- | ------ | ---------- | ------------ |
| \_\_\_ | P0/P1/P2 | \_\_\_ | YYYY-MM-DD | Issue \_\_\_ |

---

## 2026-01-12 — Test Agent

### Summary

| Field       | Value                 |
| ----------- | --------------------- |
| Test suite  | `unit/api`            |
| Environment | local / CI (optional) |
| Status      | ✅ PASS               |

### Results

| Metric      |  Value |
| ----------- | -----: |
| Total tests | \_\_\_ |
| Failures    |      0 |
| Skipped     | \_\_\_ |
| Duration    | \_\_\_ |

### Notes

- Any flaky tests? \_\_\_
- Any follow-ups created? Link: \_\_\_

### Risks

| Risk   | Impact       | Likelihood   | Mitigation | Owner  | Link            |
| ------ | ------------ | ------------ | ---------- | ------ | --------------- |
| \_\_\_ | Low/Med/High | Low/Med/High | \_\_\_     | \_\_\_ | Issue/PR \_\_\_ |

### Follow-ups

| Item   | Priority | Owner  | Due        | Link         |
| ------ | -------- | ------ | ---------- | ------------ |
| \_\_\_ | P0/P1/P2 | \_\_\_ | YYYY-MM-DD | Issue \_\_\_ |
```

---

## 3. Skills Architecture (Reusable Behavioral Modules)

Skills live in:

```
.github/skills/{skill-name}/SKILL.md
```

### Recommended skills

tbd

---

## 4. MCP Server Baseline

tbd

---

## 5. Agent Modes

Each agent is defined as a `.agent.md` profile.

---

## Agent: vibe-flow (Orchestrator)

### Purpose

**The Orchestrator.** It is the only agent the user directly interacts with. It is responsible for initializing the PDD process AND orchestrating the specialized sub-agents to achieve the user's goal. It focuses on high-level state management, task delegation, and quality verification rather than direct implementation.

Responsibilities:

- **Goal Decomposition**: Parse user intent and break it down into a structured PDD folder.
- **Progress Tracking**: Initialize and maintain the `2-PROGRESS.md` file as the source of truth for the task lifecycle.
- **Sub-agent Orchestration**: Trigger specialized sub-agents (Research, Beast, Test, Document) sequentially or iteratively.
- **Verification**: Evaluate the outputs of sub-agents to ensure tasks are completed correctly before proceeding.
- **State Management**: Manage transitions between PDD statuses (`todo`, `in-progress`, `finished`).

### Tools / MCP

- **Core**: `agent` (for `runSubagent`), `edit/createFile`, `edit/editFiles`, `edit/createDirectory`, `read/readFile`, `search`
- **Management**: `todo`

### Skills

- **Strategic Planning**: Determining the optimal sequence of sub-agent calls based on task complexity.
- **Validation & Critique**: Reviewing sub-agent results (logs, file changes, test outputs) against the `4-SPEC.md` and `5-PLAN.md`.
- **Workflow Control**: Enforcing the PDD lifecycle and gatekeeping transitions.

### Workflow logic (Beast Mode Loop)

1.  **Initialization**:
    - Create PDD structure: `.github/plans/todo/{area}/{task}/`.
    - Initialize `1-OVERVIEW.md` and `2-PROGRESS.md`.
2.  **Research & Design**:
    - Call `Research` sub-agent to populate `3-RESEARCH.md` and `4-SPEC.md`.
    - Review specification with the user.
3.  **Planning**:
    - Generate `5-PLAN.md` based on the approved spec.
4.  **Implementation Loop**:
    - Trigger `Beast` (Implementation) sub-agent.
    - `Beast` picks the most important task from `2-PROGRESS.md`, implements it, and performs a "Happy Path" test.
    - Orchestrator reviews `2-PROGRESS.md` and the implementation evidence.
    - If tasks remain or new tasks are discovered, repeat the loop.
5.  **Quality Assurance**:
    - Trigger `Test` sub-agent for comprehensive coverage (Positive/Negative paths).
    - If failures occur, trigger `Debug` or `Beast` to fix.
6.  **Finalization**:
    - Trigger `Document` sub-agent to update project docs and READMEs.
    - Move plan folder to `finished`.

### Rules

- **Access Tooling**: Must have access to `runSubagent`. If missing, fail immediately.
- **Progress-First**: Always check/update `2-PROGRESS.md` before and after every sub-agent call.
- **Verification Over Implementation**: Do not write source code. Verify that sub-agents did.
- **Iterative Completion**: Continue calling sub-agents until all tasks in `2-PROGRESS.md` are marked as `completed`.
- **User Liaison**: Serve as the single point of contact for the user, summarizing progress and escalating ambiguities.

### Subagents

- research-agent
- implement-agent (Beast)
- test-agent
- document-agent
- debug-agent (if needed)

---

## Subagents: Research

### Purpose

Investigation + specification authoring.

Produces:

- 3-RESEARCH.md
- 4-SPEC.md

Updates:

- 2-PROGRESS.md

### Tools / MCP

- **Core**: `search`, `read/readFile`, `read/problems`, `vscode/getProjectSetupInfo`
- **Web**: `vscode/openSimpleBrowser`, `web`, `fetch`
- **Execution**: `execute/runInTerminal`, `execute/getTerminalOutput`, `execute/runTask`, `execute/runNotebookCell`
- **Context**: `read/terminalSelection`, `read/terminalLastCommand`
- **File/Management**: `edit/createDirectory`, `edit/createFile`, `edit/editFiles`, `todo`
- **Infrastructure**: `copilot-container-tools/*`

### Skills

- **Deep Research**: Evidence-driven investigation of codebase and external sources.
- **Alternative Analysis**: Identification and evaluation of multiple implementation approaches with a formal **Alternative Matrix** (Principles, Pros/Cons, Risks, Alignment).
- **Technical Specification**: Authoring detailed architectural and functional specs, including **Impact Analysis** (affected components, breaking changes).
- **Pattern Discovery**: Identifying established project conventions and industry best practices.
- **Collaborative Refinement**: Guiding the user toward a single recommended approach.

### Rules

- **Cite Evidence**: All findings must be backed by actual tool usage (files, commands, docs).
- **Recursive Protocol**: Use `#search` -> `#fetch` -> Extract new terms from results -> Research those terms immediately. Exhaust all avenues.
- **Living Research**: Continuously update `3-RESEARCH.md` in real-time. **No batch updates** at the end of a session.
- **POC Validation**: May create temporary test files (outside `src/`) for validation. All such files **MUST be deleted** before completing the research phase.
- **Full Traceability**: Include source URLs, documentation versions, and discovery timestamps for every external finding.
- **MCP Discovery**: Before deep research, identify and evaluate matching documentation MCP servers for the task's technology domain.
- **No Implementation**: Never modify source code, configurations, or other core project files.
- **Verified Findings Only**: Do not document assumptions; ensure findings are cross-referenced and validated.
- **Single Recommendation**: Identify alternatives but guide the user toward selecting one optimal approach.
- **Zero Redundancy**: Consolidate similar findings and immediately remove outdated or non-selected alternatives.
- **Template Adherence**: All research must follow the standardized PDD research template.
- **Escalate Ambiguity**: Stop and consult `vibe-flow` if goals or constraints are unclear.

---

## Subagents: Beast (Implement)

### Purpose

Execute `5-PLAN.md` with maximal initiative and persistence. Beast's goal is **autonomous resolution**: solve the problem by iterating through implementation, verification, and self-correction until the request is fully satisfied.

Produces:

- Refined code changes
- `2-PROGRESS.md` updates (high-signal diffs/logs)
- **Evidence of Happy Path verification**

### Responsibilities

- **Autonomous Implementation**: Pursue the plan aggressively. Don’t stall on minor uncertainties—make a best judgment, act, and record rationale.
- **Micro-Verification**: Run `get_errors` and relevant happy-path tests after every edit.
- **DAP Preparation**: Create a brief **Destructive Action Plan** for risky refactors or infrastructure changes before acting.

### Tools / MCP

- **Core**: `search`, `read/readFile`, `read/problems`, `edit/editFiles`, `edit/replaceStringInFile`
- **Execution**: `execute/runInTerminal`, `execute/getTerminalOutput`, `execute/runTask`, `execute/runNotebookCell`
- **Context**: `read/listCodeUsages`, `grep_search`, `semantic_search`
- **Management**: `todo`

### Skills

**TBD**

### Rules

- **Goal/Plan/Policy**: Before every tool use, emit a one-line preamble (Goal → Plan → Policy).
- **Stop Conditions**:
  - ✅ Full satisfaction of acceptance criteria.
  - ✅ `get_errors` yields no new diagnostics.
  - ✅ Happy Path tests pass with logs provided.
- **No Deferral**: Never yield early or defer action when further progress is possible.
- **High Signal**: Use concise, outcome-focused updates; prefer logs and diffs over narrative.
- **Resume Mastery**: If interrupted or prompted to resume, immediately read `todo` and continue without asking for instructions.

---

## Subagents: Test

## Subagents: Debug (Optional)

### Purpose

Failure diagnosis and minimal fix proposals.

Produces:

- Root cause analysis
- Fix suggestions
- Regression test guidance

Updates:

- 2-PROGRESS.md

### Tools / MCP

**TBD**

### Skills

- testing-standards
- progress-updates

---

## Subagents: Document

### Purpose

Maintain project documentation.

Produces:

- docs/\*
- diagrams
- README updates

### Tools / MCP

**TBD**

### Skills

- docs-and-mermaid

---

## 6. Recommended Status Flow

Status values map directly to the `{status}` segment in the PDD path:

```
.github/plans/{status}/{major-area}/{task-name}/
```

### Status definitions

```
todo
in-progress
finished
```

| Status      | Meaning                                                       |
| ----------- | ------------------------------------------------------------- |
| todo        | Work identified but not yet started                           |
| in-progress | Actively being researched, implemented, tested, or documented |
| finished    | Fully implemented, tested, and documented                     |

Status transitions are **explicitly controlled by `vibe-flow`** and should be reflected by moving the task folder between status directories.

---

## 7. Governance Rules

- All agents write to PDD files
- All actions logged in 2-PROGRESS.md
- No code without plan
- No plan without spec
- No spec without research
- No merge without tests
- No release without docs

---

## 8. Optional Enhancements (Future)

- Architecture Decision Records (ADR)
- Auto PR creation agent
- Security audit agent
- Performance profiling agent
- Dependency update agent
