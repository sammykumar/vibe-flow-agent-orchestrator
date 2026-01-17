---
name: research
description: "Performs repository research, evidence-driven analysis, and produces PDD deliverables (3-RESEARCH.md, 4-SPEC.md, 5-PLAN.md, 2-PROGRESS.md) inside the active plan directory. Use when a deep investigation, codebase mapping, or specification is required."
license: Proprietary
metadata:
  author: sammykumar
  version: "1.0"
allowed-tools:
  - read/**
  - search/**
  - web/fetch_webpage
  - todo
  - edit/.github/plans/**
  - playwright
---

# Research Skill

This skill implements the Research Methodologist behavior. It performs
repository research, evidence-driven analysis, and scaffolds PDD deliverables
into the active plan directory.

## Scope & Constraints

- Writes are strictly limited to the active plan directory:
  `.github/plans/{status}/{major-area}/{task-name}/`.
- **Do NOT** modify `src/` or production source files.
- Use Playwright/Chrome DevTools only for UI inspection tasks and only against
  local/dev servers when explicitly requested.

## When to use

- The request contains keywords like: "research", "spec", "investigate", or
  explicitly asks for a technical specification.

## High-level Steps

1. Initialize or verify the plan folder exists (use the `todo` tool to create
   a plan if needed).
2. Run repository searches and read files to map the codebase and surface
   relevant artifacts.
3. Capture external evidence and references (Agentskills spec, related docs)
   using `web/fetch_webpage`.
4. Draft `3-RESEARCH.md` (analysis & evidence) using
   `assets/research-template.md`.
5. Draft `4-SPEC.md` (technical specification) using
   `assets/spec-template.md`.
6. Draft `5-PLAN.md` (implementation plan and task checklist).
7. Update `2-PROGRESS.md` and set status to `research_complete` when finished.

## Inference

The skill should be invoked when the user's request contains the above
keywords or asks for investigative/spec work. Use discretion and confirm intent
if ambiguous.

## Templates & Assets

This skill includes the following assets and templates (located under the
skill directory):

- `assets/research-template.md` — skeleton for `3-RESEARCH.md`
- `assets/spec-template.md` — skeleton for `4-SPEC.md`
- `assets/progress-log-template.md` — starter `2-PROGRESS.md`
- `references/REFERENCE.md` — tool usage and scope details

## Example usage

```text
# Create a plan for 'add-auth-integration' and run research
@research: "Investigate authentication flow in the repository. The plan
  directory is '/absolute/path/to/.github/plans/in-progress/auth/add-auth-integration'.
  Create `3-RESEARCH.md` and `4-SPEC.md` skeletons and update progress."
```
