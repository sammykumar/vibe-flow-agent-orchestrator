# Research: Parallel Subagents Visualization (README)

**Date**: 2026-01-16  
**Agent**: research.agent  
**Status**: Complete  
**Related Plan**: [.github/plans/in-progress/docs/parallel-subagents-visualization/](.github/plans/in-progress/docs/parallel-subagents-visualization/)

---

## 1. Context & Goals

### Business Objective

Clarify how optional parallel subagent work fits into the v2 workflow so readers understand the default sequential path and the opt-in read-only branch.

### Technical Goals

- Add a plain-language explanation of the parallel subagent strategy (v2 scope: `vibe-flow`, `research-agent`, `implement-agent`).
- Provide a Mermaid diagram that shows the default sequential flow plus an opt-in read-only parallel branch.
- Place the new content in a clear, discoverable location in the README without replacing the existing workflow diagram.

### Success Criteria

- [ ] Explanation is plain language and explicitly scoped to v2.
- [ ] Diagram shows sequential flow and opt-in read-only parallel branch.
- [ ] README insertion location is unambiguous, with exact line references.

### Constraints

- Documentation-only change; no source code updates.
- Keep current workflow diagram intact.
- Avoid implying write-capable parallel subagents in v2.

---

## 2. Codebase Analysis

### Existing Patterns

**Documentation**:

- The README already includes a single workflow diagram and high-level messaging about incremental mode and subagents.
- The workflow diagram references `implement-agent`, while the agents list only includes `research-agent`.

**Key Components**:

- [README.md](README.md#L9-L160): README messaging, workflow diagram, and quick start.

### Affected Files

| File                           | Current Role                               | Impact Level | Change Type                       |
| ------------------------------ | ------------------------------------------ | ------------ | --------------------------------- |
| [README.md](README.md#L21-L81) | Primary repo overview and workflow diagram | 🟡 Medium    | Modify (add subsection + diagram) |

### Conventions Discovered

**Documentation Standards**:

- Mermaid is already used in the README.
- Sections are short and narrative with emojis in headers.

---

## 3. Alternative Analysis

### Alternative Matrix

| Approach                                                                        | Principles Alignment | Pros                                                                 | Cons                                                                          | Risks  | Est. Effort | Recommendation |
| ------------------------------------------------------------------------------- | -------------------- | -------------------------------------------------------------------- | ----------------------------------------------------------------------------- | ------ | ----------- | -------------- |
| **A. Add a new README subsection below the current workflow diagram**           | High                 | - Preserves current diagram<br>- Minimal change<br>- Clear placement | - Slightly longer README                                                      | Low    | Low         | ✅ RECOMMENDED |
| **B. Replace the existing diagram with a combined sequential+parallel diagram** | Medium               | - Single diagram view                                                | - Removes current diagram users may rely on<br>- Harder to compare v2 default | Medium | Low         | ⚠️ Consider    |
| **C. Add a new doc file and link from README**                                  | Medium               | - Keeps README short                                                 | - Adds navigation friction<br>- Less discoverable                             | Low    | Medium      | ❌ Reject      |

### Detailed Analysis

#### Approach A: Add a subsection below the workflow diagram ⭐ RECOMMENDED

**Description**: Insert a short plain-language explanation and a new Mermaid diagram directly after the existing workflow diagram section in the README.

**Technical Considerations**:

- Works with current Mermaid usage in README.
- Keeps v2 scope explicit and avoids altering the existing diagram.

**Why Recommended**:

This is the least disruptive option and keeps the new explanation in the same narrative area as the current workflow diagram.

---

## 4. External Discovery

No external sources required.

---

## 5. Risk Assessment

| Risk                                                    | Impact | Likelihood | Mitigation Strategy                                               | Owner | Status     |
| ------------------------------------------------------- | ------ | ---------- | ----------------------------------------------------------------- | ----- | ---------- |
| Misinterpretation of parallel behavior as write-enabled | Low    | Low        | Explicitly label parallel branch as read-only in text and diagram | Docs  | Identified |

---

## 6. Recommendation

### Selected Approach

**Approach A: Add a subsection below the current workflow diagram**

### Next Steps

1. Define README insertion location and wording.
2. Provide final Mermaid diagram for sequential + opt-in read-only parallel branch.
3. Produce implementation plan.

---

## 7. References

### Internal Documentation

- [README.md](README.md#L21-L81) — existing workflow diagram location.

### Tools Used

- read_file
- run_in_terminal

---

## Metadata

**Research Duration**: ~0.5 hours  
**Files Analyzed**: 1  
**External Sources**: 0  
**Alternatives Evaluated**: 3  
**Updated**: 2026-01-16
