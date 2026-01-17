# Research: version-bump script fix

**Date**: 2026-01-17  
**Agent**: research.agent  
**Status**: Complete  
**Related Plan**: .github/plans/in-progress/versioning/script-fix/

---

## 1. Context & Goals

### Business Objective

Restore a reliable version bump workflow so the suite version is updated in the authoritative agent definition file.

### Technical Goals

- Identify why the script fails to locate the version tag.
- Pinpoint the authoritative agent file path used in this repository.
- Define a minimal, durable fix for the script pathing.

### Success Criteria

- [ ] The script targets the actual agent file location.
- [ ] The script reports a clear error when the agent file is missing.
- [ ] The bump process updates the version comment in the single source of truth.

### Constraints

- Do not modify agent behavior or release process beyond the path fix.
- Keep the script compatible with the repository layout used by the installer.

---

## 2. Codebase Analysis

### Existing Patterns

**Architecture**:

- Agent definitions are stored under .github/agents/ for local dogfooding and installation.
- The version tag is embedded in the main orchestrator agent file.

**Key Components**:

- [version-bump.sh](version-bump.sh): Bash script that extracts and updates the version tag.
- [.github/agents/vibe-flow.agent.md](.github/agents/vibe-flow.agent.md): Single source of truth for the suite version tag.
- [.github/copilot-instructions.md](.github/copilot-instructions.md): Documents the authoritative location for agent files and version tag guidance.
- [install-vibeflow.md](install-vibeflow.md): Defines the agent install layout under .github/agents/.

### Affected Files

| File                               | Current Role        | Impact Level | Change Type |
| ---------------------------------- | ------------------- | ------------ | ----------- |
| [version-bump.sh](version-bump.sh) | Version bump script | 🔴 High      | Modify      |

### Evidence

- The script sets AGENT_FILE to agents/vibe-flow.agent.md, which does not exist in this repository layout.
- The actual agent file lives at .github/agents/vibe-flow.agent.md and contains the version tag comment.
- Repository documentation consistently references .github/agents as the canonical location.

---

## 3. Alternative Analysis

### Alternative Matrix

| Approach                        | Principles Alignment | Pros                             | Cons                                           | Risks  | Est. Effort | Recommendation |
| ------------------------------- | -------------------- | -------------------------------- | ---------------------------------------------- | ------ | ----------- | -------------- |
| A. Hardcode .github/agents path | High                 | Minimal change, clear intent     | Less flexible if layout changes                | Low    | < 1h        | ✅ RECOMMENDED |
| B. Auto-discover via search     | Medium               | More resilient to layout changes | More script complexity, possible false matches | Medium | 1-2h        | ⚠️ Consider    |
| C. Restore agents/ directory    | Low                  | Keeps current script unchanged   | Conflicts with documented layout               | Medium | 1-2h        | ❌ Reject      |

### Detailed Analysis

#### Approach A: Hardcode .github/agents path ⭐ RECOMMENDED

**Description**: Update the script to point to .github/agents/vibe-flow.agent.md, optionally using the script directory to anchor the path.

**Why Recommended**:

- Aligns with documented repository structure.
- Minimizes change surface and risk.
- Preserves the single source of truth policy.

---

## 4. External Discovery

No external sources required.

---

## 5. Risk Assessment

| Risk                                 | Impact | Likelihood | Mitigation Strategy                          | Owner | Status     |
| ------------------------------------ | ------ | ---------- | -------------------------------------------- | ----- | ---------- |
| Script run from a non-repo directory | Medium | Medium     | Anchor path to script directory or repo root | Dev   | Identified |

---

## 6. Recommendation

### Selected Approach

**Approach A: Hardcode .github/agents path with script-root anchoring**

### Rationale

This approach matches repository documentation and installation layout while keeping the change minimal and low risk.

### Next Steps

1. ✅ Research complete → Create 4-SPEC.md
2. ⏭️ Define concrete script changes and verification

---

## 7. References

### Internal Documentation

- [version-bump.sh](version-bump.sh)
- [.github/agents/vibe-flow.agent.md](.github/agents/vibe-flow.agent.md)
- [.github/copilot-instructions.md](.github/copilot-instructions.md)
- [install-vibeflow.md](install-vibeflow.md)

---

## Metadata

**Research Duration**: 1 hour  
**Files Analyzed**: 4  
**External Sources**: 0  
**Alternatives Evaluated**: 3  
**Updated**: 2026-01-17
