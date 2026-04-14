# Architecture Decision Records (ADR)

> **When to use**: Technology or framework choice, architectural pattern change, any decision with cross-cutting impact, or significant trade-off between options.

## Template

```markdown
# ADR-XXX: Decision title

## Status
Proposed | Accepted | Deprecated | Superseded by ADR-YYY

## Context
What problem or need triggered this decision?

## Decision
What solution was chosen?

## Consequences
### Positive
- ...

### Negative
- ...

### Risks
- ...

## Alternatives considered
1. **Option A** — Description, why discarded
2. **Option B** — Description, why discarded
```

## Naming convention

- File: `docs/architecture/adr-XXX-short-title.md`
- Sequential numbering
- Short title in kebab-case

## Examples of documented decisions

- Choice of hexagonal architecture (ports & adapters)
- Choice of aiosqlite vs PostgreSQL
- Choice of Karate for E2E testing
- Dual Docker target (remote/local)

## Red flags

- Architecture decision made in a PR comment instead of an ADR — decisions get lost
- ADR written after implementation is done — it should guide the work, not document it after the fact
- No "Alternatives considered" section — proves the decision was a default, not a choice
- ADR with status "Proposed" for months — decide or discard
- Contradictory ADRs without superseding — mark old ones as deprecated

## Anti-rationalizations

| Excuse | Why it doesn't hold |
|--------|---------------------|
| "It's obvious, no need to write it down" | Obvious to you today, mysterious to the next person in 6 months |
| "An ADR is overkill for this" | If it affects more than one module, it deserves 15 minutes of writing |
| "We can always change it later" | True, but future-you needs to know WHY this choice was made to change it wisely |
| "The code is self-documenting" | Code shows what. ADRs show why, and what was rejected |

## Verification

- [ ] ADR written BEFORE or DURING implementation (not after)
- [ ] Context section explains the actual problem or need
- [ ] At least 2 alternatives considered with reasons for rejection
- [ ] Consequences include both positives AND negatives
- [ ] Status is current (not stuck at "Proposed")
- [ ] File follows naming convention (`adr-XXX-short-title.md`)
