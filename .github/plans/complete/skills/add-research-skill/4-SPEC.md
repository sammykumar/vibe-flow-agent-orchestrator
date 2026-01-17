# Spec: research-skill

## 1. Architecture Design

Goal: Implement a standalone `research` Agent Skill at `.github/skills/research/` that encapsulates the `research.agent` behavior, templates, and validation scripts.

Components:

- `SKILL.md` (required): frontmatter and body with instructions
- `assets/`: templates for `3-RESEARCH.md`, `4-SPEC.md`, `2-PROGRESS.md`
- `references/`: detailed protocol and tool usage rules
- `scripts/validate-skill.sh`: simple script to run `skills-ref validate` and do additional checks
- `tests/`: unit and integration tests for CI

## 2. Sample `SKILL.md`

```
---
name: research
description: "Performs repository research, evidence-driven analysis, and produces PDD deliverables (3-RESEARCH.md, 4-SPEC.md, 2-PROGRESS.md) inside the active plan directory. Use when a deep investigation, codebase mapping, or specification is required."
license: Proprietary
metadata:
  author: sammykumar
  version: "1.0"
allowed-tools: Read Search Playwright(io.github.chromedevtools) Todo Edit
---

# Research Skill

This skill implements the Research Methodologist behavior (see `.github/agents/research.agent.md`). Key constraints:
- **Writes restricted to the active plan directory** (`.github/plans/{status}/{major-area}/{task-name}/`)
- **Do NOT modify `src/` or production source files**
- Use Playwright/Chrome DevTools only for UI inspection tasks and only against local/dev servers

## When to use
- Request contains keywords: "research", "spec", "investigate", "3-RESEARCH", "technical specification"

## Step-by-step (high-level)
1. Initialize the plan (use `todo` tool to create the plan folder)
2. Run codebase searches (`search`) and read files (`read/readFile`) to map repository
3. Capture external evidence (Agentskills spec and other docs) using `web/fetch_webpage`
4. Draft `3-RESEARCH.md` with findings and evidence (use `assets/research-template.md`)
5. Draft `4-SPEC.md` (use `assets/spec-template.md`)
6. Update `2-PROGRESS.md` and set status to `research_complete` when finished

## Templates & Assets
See `assets/` for `research-template.md`, `spec-template.md`, and `progress-log-template.md`.

```

## 3. Required Assets and Example Templates

- `assets/research-template.md` — contains the `3-RESEARCH.md` structure (Context, Codebase Analysis, Alternative Matrix, External Discovery, Recommendation) with example checklists and evidence placeholders.
- `assets/spec-template.md` — contains skeleton for `4-SPEC.md` as per research_workflow
- `assets/progress-log-template.md` — starter `2-PROGRESS.md`
- `references/REFERENCE.md` — details about permitted tools and scopes

## 4. Implementation Steps (for `implement-agent`)

1. Create directory `.github/skills/research/` in repo
2. Add `SKILL.md` (use sample above)
3. Create `assets/` and add the three templates
4. Add `references/REFERENCE.md` documenting `Tool Usage Policy` and `research_workflow`
5. Add `scripts/validate-skill.sh` which runs `skills-ref validate .` and fails on missing frontmatter or absent templates
6. Add tests:
   - `tests/unit/frontmatter.test.yaml` (assert `name`, `description`)
   - `tests/integration/dry-run/` harness to simulate a research task (not committing changes, only verifying file contents)
7. Add CI workflow `.github/workflows/validate-skills.yml`:
   - Trigger: push / pull_request
   - Runs: `skills-ref validate` for `.github/skills/*`
   - Runs integration dry-run harness in a container (if possible)
8. Update `install-vibeflow.md` to fetch the research skill and assets on install (add snippet from Research report)
9. Update `AGENTS.md` to document `research-agent` use and link to `SKILL.md`

## 5. Acceptance Criteria & Verification Steps

- `SKILL.md` passes `skills-ref validate` with exit code 0
- `SKILL.md` contains required fields `name` and `description` and `allowed-tools` guidance
- `assets/` files exist and match templates (the CI unit checks validate structure)
- Integration dry-run: Given a sample input, the skill outputs `3-RESEARCH.md` and `4-SPEC.md` into a temp plan directory and those files contain the required sections
- `install-vibeflow.md` updated to fetch the skill and `skills-ref validate` is run as part of the installer verification

## 6. Risks & Mitigations

- Risk: Unrestricted `edit/*` permissions could allow a skill to change production code.

  - Mitigation: Document explicit write scope and add CI checks to ensure changes outside `.github/plans` are rejected by a validation job.

- Risk: Playwright/Chromedevtools access may require network or local servers
  - Mitigation: Default to dry-run and only enable Playwright-based tests when a dev server is available. Document this in `compatibility` field if required.

## 7. Timeline & Handoff

- Implement estimate: 1-2 days (2 developers or one developer ~8-12 hours including tests and CI)
- Handoff: Provide PR with `.github/skills/research/` and `.github/workflows/validate-skills.yml` + `install-vibeflow.md` addition. Provide a sample PR description and acceptance checklist.
