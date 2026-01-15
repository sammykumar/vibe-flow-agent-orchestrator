# Research Skill

This directory contains the `research` skill for Vibe Flow.

## Usage

- `scripts/validate-skill.sh` — run validation checks for the skill
  (frontmatter and required assets)
- `scripts/dry_run.sh` — perform an integration dry-run that generates
  `3-RESEARCH.md` and `4-SPEC.md` into a temporary plan directory
- Unit tests: `tests/unit/frontmatter.test.sh`
- Integration tests: `tests/integration/dry-run/run.sh`

## Run tests locally

```bash
# Run unit test
bash .github/skills/research/tests/unit/frontmatter.test.sh

# Run validator
bash .github/skills/research/scripts/validate-skill.sh

# Run integration dry run
bash .github/skills/research/tests/integration/dry-run/run.sh
```
