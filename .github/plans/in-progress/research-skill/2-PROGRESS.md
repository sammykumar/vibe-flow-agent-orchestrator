# Progress: research-skill

- **Status:** research_complete ✅
- **Completed:** 2026-01-15T12:40:00Z
- **Owner:** research.agent
- **ETA (initial):** 1 business day
- **Estimated effort:** 6-8 hours

## Completed tasks

1. Review Agent Skills specification (`https://agentskills.io/specification`) — completed (evidence: spec snippets in `3-RESEARCH.md`)
2. Mapped `.github/agents/research.agent.md` behavior to `SKILL.md` fields — completed (evidence: mapping section in `3-RESEARCH.md`)
3. Drafted `3-RESEARCH.md` (findings, alternatives, recommendation) — completed (file: `.github/plans/in-progress/research-skill/3-RESEARCH.md`)
4. Drafted and finalized `4-SPEC.md` with sample `SKILL.md`, assets, implementation steps, tests, and CI recommendations — completed (file: `.github/plans/in-progress/research-skill/4-SPEC.md`)
5. Proposed `install-vibeflow.md` packaging additions and verification steps — completed (see `3-RESEARCH.md`, section Packaging & Installation)

## Remaining / Handoff

- Implement the `research` skill by creating `.github/skills/research/` with `SKILL.md`, `assets/`, `references/`, `scripts/validate-skill.sh`, and tests as described in `4-SPEC.md`.
- Add CI job `.github/workflows/validate-skills.yml` to run `skills-ref validate` on push/PR and run integration dry-run harness.

## Notes

- All claims and decisions are evidenced and cited in `3-RESEARCH.md`.
- Recommendation: create a standalone `.github/skills/research/` (see Alternative Matrix in `3-RESEARCH.md`).

---

Research complete. Returning to Orchestrator.
