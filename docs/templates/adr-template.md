# ADR-{NUMBER}: {Title}

**Date**: YYYY-MM-DD  
**Status**: Proposed / Accepted / Deprecated / Superseded by ADR-{NUMBER}  
**Deciders**: {List of people/agents involved}  
**Technical Story**: {Link to issue/task if applicable}

---

## Context and Problem Statement

{Describe the context and background. What is the problem we're trying to solve? What are the constraints? What architectural or design decision needs to be made?}

**Example**: "We need to choose a state management solution for our React application. The app has complex data flows, multiple teams working on it, and needs to scale to handle increased traffic."

---

## Decision Drivers

- {Driver 1: e.g., Team familiarity with technology}
- {Driver 2: e.g., Performance requirements}
- {Driver 3: e.g., Maintainability and long-term support}
- {Driver 4: e.g., Integration with existing systems}
- {Driver 5: e.g., Community support and ecosystem}

---

## Considered Options

### Option 1: {Option Name}

**Description**: {Brief description of the approach}

**Pros**:

- {Pro 1}
- {Pro 2}
- {Pro 3}

**Cons**:

- {Con 1}
- {Con 2}
- {Con 3}

**Estimated Effort**: {Low / Medium / High}

---

### Option 2: {Option Name}

**Description**: {Brief description of the approach}

**Pros**:

- {Pro 1}
- {Pro 2}
- {Pro 3}

**Cons**:

- {Con 1}
- {Con 2}
- {Con 3}

**Estimated Effort**: {Low / Medium / High}

---

### Option 3: {Option Name}

**Description**: {Brief description of the approach}

**Pros**:

- {Pro 1}
- {Pro 2}
- {Pro 3}

**Cons**:

- {Con 1}
- {Con 2}
- {Con 3}

**Estimated Effort**: {Low / Medium / High}

---

## Decision Outcome

**Chosen option**: "{Option Name}"

### Rationale

{Explain why this option was chosen. Reference the decision drivers and how this option best addresses them.}

**Example**: "We chose Option 2 (Redux Toolkit) because it provides the best balance between team familiarity, performance, and long-term maintainability. While Option 1 (Context API) was simpler, it doesn't scale well for our use case. Option 3 (MobX) had limited team experience."

---

## Consequences

### Positive

- {Positive consequence 1}
- {Positive consequence 2}
- {Positive consequence 3}

### Negative

- {Negative consequence 1}
- {Negative consequence 2}
- {Mitigation strategy for negatives}

### Neutral

- {Neutral consequence - just a change, neither good nor bad}

---

## Implementation Plan

### Step 1: {Phase name}

- {Task 1}
- {Task 2}
- **Timeline**: {Duration}

### Step 2: {Phase name}

- {Task 1}
- {Task 2}
- **Timeline**: {Duration}

### Migration Strategy

{If this replaces an existing approach, how will we migrate?}

---

## Validation

### Success Criteria

- [ ] {Criterion 1: e.g., Performance benchmarks met}
- [ ] {Criterion 2: e.g., Team trained and productive}
- [ ] {Criterion 3: e.g., No production incidents related to this change}

### Review Date

{Date to review this decision and assess if it's still valid}: YYYY-MM-DD

---

## Related Decisions

- {Link to ADR-XXX} - {Brief description of relationship}
- {Link to issue/PR} - {Implementation reference}

---

## References

- {Link to documentation}
- {Link to research/benchmarks}
- {Link to external resources}

---

## Notes

{Any additional context, caveats, or future considerations}
