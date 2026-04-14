# Architecture Decision Records (ADR)

## When to write an ADR

- Technology or framework choice
- Architectural pattern change
- Decision with cross-cutting impact
- Significant trade-off between options

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
