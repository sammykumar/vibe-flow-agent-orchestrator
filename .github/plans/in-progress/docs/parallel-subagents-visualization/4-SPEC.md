# Technical Specification: README Parallel Subagents Explanation (v2)

**Date**: 2026-01-16  
**Agent**: research.agent  
**Status**: Draft  
**Related Plan**: [.github/plans/in-progress/docs/parallel-subagents-visualization/](.github/plans/in-progress/docs/parallel-subagents-visualization/)  
**Based on Research**: [3-RESEARCH.md](.github/plans/in-progress/docs/parallel-subagents-visualization/3-RESEARCH.md)

---

## 1. Executive Summary

### What are we building?

A README update that adds a plain-language explanation of the opt-in read-only parallel subagent strategy in v2, plus a Mermaid diagram showing the default sequential flow and the optional parallel branch.

### Why?

The current README shows only the sequential workflow. This update clarifies how optional parallel analysis fits the v2 scope without implying write-capable parallel subagents.

### Success Metrics

- The README includes a concise, plain-language explanation scoped to `vibe-flow`, `research-agent`, and `implement-agent`.
- A Mermaid diagram renders a sequential flow with a labeled read-only parallel branch.
- The insertion point is clear and does not disrupt existing sections.

---

## 2. Content Requirements

### README Insertion Location

Insert a new subsection **after** the existing workflow diagram block and **before** the Quick Start section.

- Exact insertion location: after line 79 and before line 81 in [README.md](README.md#L79-L81).

### Plain-Language Explanation (v2 Scope)

Proposed README text:

> **Parallel subagents (v2, opt-in)**
>
> In v2, the default workflow is sequential: `vibe-flow` → `research-agent` → `implement-agent`. When you explicitly enable parallel help, `vibe-flow` can spawn read-only subagents to scan code or gather context. Those read-only helpers do not edit files or plan artifacts; they return notes back to `vibe-flow`, which remains the single writer.

### Mermaid Diagram (Final Content)

```mermaid
flowchart TD
  subgraph "Default (Sequential)"
    VF[vibe-flow] --> RA[research-agent]
    RA --> IA[implement-agent]
  end

  subgraph "Opt-in (Read-only parallel)"
    VF -.->|spawn (read-only)| PR[parallel read-only subagent(s)]
    PR -.->|returns findings| VF
  end

  style VF fill:#8e44ad,stroke:#333,color:#fff
  style RA fill:#27ae60,stroke:#333,color:#fff
  style IA fill:#2980b9,stroke:#333,color:#fff
  style PR fill:#f39c12,stroke:#333,color:#fff,stroke-dasharray: 4 2
```

---

## 3. Impact Analysis

### Files to Modify

| File                           | Current Role                               | Changes Needed                       | Risk   |
| ------------------------------ | ------------------------------------------ | ------------------------------------ | ------ |
| [README.md](README.md#L21-L81) | Primary repo overview and workflow diagram | Add new subsection + Mermaid diagram | 🟢 Low |

---

## 4. Acceptance Criteria

- [ ] New README subsection appears after the existing workflow diagram and before Quick Start.
- [ ] Plain-language explanation explicitly states read-only parallel behavior and single-writer rule.
- [ ] Mermaid diagram renders and clearly shows sequential flow plus opt-in parallel branch.

---

## 5. Verification Plan

- Open README and confirm insertion point at [README.md](README.md#L79-L81).
- Render Mermaid diagram in a Markdown preview to verify layout and styling.
- Confirm text references only v2 scope (`vibe-flow`, `research-agent`, `implement-agent`).

---

## 6. Risks and Mitigation

| Risk                                        | Impact | Likelihood | Mitigation Strategy                           | Owner | Status    |
| ------------------------------------------- | ------ | ---------- | --------------------------------------------- | ----- | --------- |
| Readers assume parallel subagents can write | Low    | Low        | Label branch as read-only in text and diagram | Docs  | Mitigated |

---

## 7. Open Questions

- [ ] Should the new subsection be titled with an emoji for consistency with existing headings?

---

## 8. References

- [README.md](README.md#L21-L81)
- [3-RESEARCH.md](.github/plans/in-progress/docs/parallel-subagents-visualization/3-RESEARCH.md)
- [5-PLAN.md](.github/plans/in-progress/docs/parallel-subagents-visualization/5-PLAN.md)

---

## Metadata

**Version**: 1.0  
**Last Updated**: 2026-01-16  
**Next Review**: 2026-01-23
