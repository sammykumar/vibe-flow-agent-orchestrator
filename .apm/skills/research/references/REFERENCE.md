# Research Skill Reference

This document explains the `research` skill's purpose, permitted tools, and
usage patterns.

## Purpose

The `research` skill performs repository-level discovery, evidence gathering,
and produces PDD artifacts (`2-RESEARCH.md` and `3-SPEC.md`) into the active
plan directory.

## Tool Usage Policy

- Allowed to read and search repository files (`read/**`, `search/**`).
- Allowed to write only within `.github/plans/*` (`edit/.github/plans/**`).
- Use Playwright only for UI inspection and only against local dev servers when
  explicitly requested.
- Do NOT modify `src/` or any production code.

## Outputs

- `2-RESEARCH.md` — findings, evidence, and alternatives
- `3-SPEC.md` — technical spec and acceptance criteria
- `1-PROGRESS.md` — progress logging and status

## Validation

Use `scripts/validate-skill.sh` to run validations and CI tests.
