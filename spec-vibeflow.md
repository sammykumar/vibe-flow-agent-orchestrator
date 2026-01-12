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

**The Orchestrator.** It is the only agent the user directly interacts with. It is responsible for initializing the PDD process AND orchestrating the specialized sub-agents to achieve the user's goal.

Responsibilities:

- Parse user intent
- Create/validate PDD structure
- **Orchestrate specialized sub-agents** (Research, Beast, Test, Document)
- Enforce workflow gates
- Merge results
- Track project state

### Tools / MCP

**TBD**

(No default edit permissions.)

### Skills

**TBD**

### Workflow logic

1. **Vibe Flow** initializes PDD structure.
2. **Vibe Flow** orchestrates traversal through specialized agents:
   - Needs Spec/Plan? → Calls **Research**
   - Plan ready? → Calls **Beast**
3. **Beast** loop:
   - Implement -> **Happy Path Test** -> (If fail: Debug) -> Success
4. **Test** loop:
   - Comprehensive Test -> (If fail: Debug -> Beast) -> Success
5. **Document** updates project docs.

### Subagents

- research-agent
- implement-agent
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

Execute 5-PLAN.md exactly and verify basic functionality.

Produces:

- Code changes
- 2-PROGRESS.md updates
- **Evidence of Happy Path verification**

### Responsibilities

- Implement code changes per spec
- **Perform "Happy Path" testing (Unit & Basic E2E)**
- Ensure application starts/runs without immediate errors

### Tools / MCP

**TBD**

### Skills

**TBD**

### Rules

- No plan → no implementation
- Record checkpoints in progress file
- Stop and escalate on ambiguity
  Robust quality assurance beyond the happy path.

Produces:

- Comprehensive Test Suite (Unit & E2E)
- Execution evidence (**Positive & Negative paths**)

Create and run automated tests.

Produces:

- Test files
- Execution evidence

Updates:

- 2-PROGRESS.md

### Tools / MCP

**TBD**

### Skills

- testing-standards
- progress-updates

---

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
