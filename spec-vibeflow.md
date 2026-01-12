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

- **Core**: `runSubagent`, `create_file`, `replace_string_in_file`, `create_directory`, `read_file`, `file_search`, `semantic_search`
- **Management**: `manage_todo_list`

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
    - If failures occur, trigger `Beast` to fix (Refactor Loop).
6.  **Finalization**:
    - Trigger `Document` sub-agent to update project docs and READMEs.
    - Move plan folder to `finished`.

### Rules

- **Access Tooling**: Must have access to `runSubagent`. If missing, fail immediately.
- **Progress-First**: Always check/update `2-PROGRESS.md` before and after every sub-agent call.
- **Tool Preamble**: Before every tool use, emit a one-line preamble: **Goal → Plan → Policy**.
- **High Signal Updates**: Prefer concise, outcome-focused updates. Use diffs and test logs over verbose narrative in `2-PROGRESS.md`.
- **Verification Over Implementation**: Do not write source code. Verify that sub-agents did.
- **Iterative Completion**: Continue calling sub-agents until all tasks in `2-PROGRESS.md` are marked as `completed`.
- **User Liaison**: Serve as the single point of contact for the user, summarizing progress and escalating ambiguities.

### Subagents

- research-agent
- implement-agent (Beast)
- test-agent
- document-agent

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

- **Core**: `file_search`, `semantic_search`, `read_file`, `get_errors`, `get_project_setup_info`
- **Web**: `open_simple_browser`, `fetch_webpage`
- **Execution**: `run_in_terminal`, `get_terminal_output`, `create_and_run_task`, `run_notebook_cell`
- **Context**: `terminal_selection`, `terminal_last_command`
- **File/Management**: `create_directory`, `create_file`, `replace_string_in_file`, `manage_todo_list`
- **Infrastructure**: `mcp_copilot_conta_*`

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

- **Core**: `file_search`, `read_file`, `get_errors`, `replace_string_in_file`, `create_file`
- **Execution**: `run_in_terminal`, `get_terminal_output`, `create_and_run_task`, `run_notebook_cell`
- **Context**: `list_code_usages`, `grep_search`, `semantic_search`
- **Management**: `manage_todo_list`

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

### Purpose

**The QA Specialist.** Operates as a relentless quality assurance expert focused on comprehensive coverage, automation, and reliability. This agent moves beyond simple TDD to orchestrate a full testing pyramid (Unit > Integration > E2E).

Produces:

- **Unit Tests**: High-coverage isolated tests for all new logic.
- **Integration Tests**: Verification of component interactions.
- **E2E Scenarios**: User-flow validation (Playwright/Cypress).
- **Test Plans**: Documented strategy for data, coverage, and automation.
- **Quality Metrics**: Reports on coverage, flakiness, and performance.

### Responsibilities

1.  **Unit Testing**: Write granular tests for every function/class introduced in `4-SPEC.md`. Mock all external dependencies.
2.  **Integration Testing**: Verify contract adherence between modules (especially API endpoints and Database layers).
3.  **E2E Testing**: Implement browser-based or full-system flows for critical user journeys.
4.  **Automation & CI**: Ensure tests run deterministically in CI environments.
5.  **Data Management**: Precise control of test data fixtures/factories to ensure reproducibility.

### Tools / MCP

- **Core**: `read_file`, `replace_string_in_file`, `create_file`, `file_search`
- **Execution**: `run_in_terminal` (for running test suites like `jest`, `vitest`, `playwright`), `get_terminal_output`
- **Analysis**: `get_errors`, `list_code_usages`
- **Browsing**: `open_simple_browser`, `playwright/*` (MCP), `chrome-devtools` (MCP)

### Skills

- **Testing Strategy**: Defining the right mix of Unit (fast) vs E2E (confident) tests.
- **Data Fixtures**: Designing isolated test data factories to prevent state leakage.
- **Mocking/Stubbing**: Separating concerns effectively.
- **Performance Profiling**: Recognizing slow tests and optimizing them.
- **Security Testing**: Basic input validation and boundary checking triggers.

### Workflow Modes

1.  **Spec-to-Test (Red Phase)**:
    - Analyze `4-SPEC.md`.
    - Generate failing unit tests for defined interfaces.
    - _Output_: `X failures` confirmed.
2.  **Implementation Verification (Green Phase)**:
    - Run tests against `Beast` agent's output.
    - Fix minor implementation bugs directly or reject task back to `Beast`.
3.  **Critical Path (E2E)**:
    - Generate Playwright/Cypress scripts for the "Happy Path" defined in the Spec.
    - Verify against running local server.

### Rules

- **Coverage Targets**: Aim for >80% branch coverage on new logic.
- **Isolation**: Unit tests MUST NOT make network/db calls.
- **Idempotency**: Tests must clean up their own state; order of execution should not matter.
- **Rationale Required**: For every E2E scenario, explain _why_ it is critical.
- **No Flakes**: If a test fails intermittently, it is a bug in the test. Fix strictness.

---

## Subagents: Document

### Purpose

**The Knowledge Archivist.** Ensures project documentation is perpetually up-to-date, visual, and navigable. It translates technical implementation details into comprehensive guides and architectural diagrams.

Produces:

- `docs/**` structure
- Mermaid diagrams (`.mmd`)
- `README.md` maintenance
- JSDoc/Docstring enrichment

### Folder Structure

```
docs/
├── architecture/          # High-level design & decision records
│   ├── diagrams/          # Source mermaid files (Sequence, C4, Class)
│   └── adr/               # Architecture Decision Records
├── api/                   # API references (generated & manual)
├── guides/                # Developer how-to & setup
└── modules/               # Detailed module-specific docs
```

### Tools / MCP

- **Core**: `read_file`, `replace_string_in_file`, `create_file`, `file_search`
- **Visualization**: `run_in_terminal`, `open_simple_browser`
- **Analysis**: `list_dir`, `grep_search`, `list_code_usages`

### Skills

- **Visual Architecture**: Expertise in mermaid.js for creating Sequence, Class, State, and C4 Architecture diagrams.
- **Technical Writing**: Clarity, conciseness, and audience awareness (User vs Developer).
- **Doc-as-Code**: Managing docs with the same rigor as source code.

### Workflow Modes

1.  **Readme Guard**:
    - Scans `src/` for major changes.
    - Updates root `README.md` installation, usage, and status sections.
2.  **Architecture Viz**:
    - _Input_: `4-SPEC.md` or existing code structure.
    - _Action_: Generates Mermaid diagrams to visualize relationships and data flow.
    - _Output_: `docs/architecture/diagrams/*.mmd` + embedded images in Markdown.
3.  **API Scribe**:
    - Walks public interfaces.
    - Ensures JSDoc/Docstrings are present and accurate.

### Rules

- **Visual First**: Complex flows (more than 3 steps) MUST have a corresponding Mermaid sequence or flow chart.
- **No Stale Docs**: If code changes, docs MUST be updated in the same "Finish" cycle.
- **Link Integrity**: All internal links must be relative and valid.

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
