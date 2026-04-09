# How to Write Good ADRs

An Architecture Decision Record captures **one decision** — the context, the choice, and its consequences.

## When to write an ADR

Write one when you're about to make a decision that:

- Is **hard to reverse** (database choice, framework, API contract)
- **Affects multiple parts** of the system (auth strategy, error handling pattern)
- Will **surprise a future reader** ("why didn't they just use X?")
- Was **debated** — even if only in your own head

Don't write one for trivial choices (variable naming, which date library to use).

## Structure

Every ADR follows the same format:

1. **Context** — The problem and the forces at play. Write this so someone unfamiliar with the codebase understands why this decision matters.
2. **Decision** — What you chose. Be specific. "We will use PostgreSQL" not "We will use a relational database."
3. **Consequences** — What follows from this decision. Be honest about the downsides.
4. **Alternatives** — What you considered and why you rejected it. This is the most valuable part for future readers.

## Rules

- **One decision per ADR.** Don't bundle.
- **Immutable once accepted.** Don't edit old ADRs. If a decision changes, write a new ADR and mark the old one as "Superseded by ADR-NNN."
- **Number sequentially.** `001-use-postgresql.md`, `002-adopt-event-sourcing.md`, etc.
- **Short is fine.** A 10-line ADR that captures the "why" is better than a 5-page essay.
- **Write it before or during the decision**, not weeks after.

## File naming

```
docs/architecture/decisions/
├── 001-use-postgresql.md
├── 002-adopt-event-sourcing.md
├── 003-switch-to-trunk-based-dev.md
└── ...
```

## Example

See [examples/sample-adr.md](../examples/sample-adr.md) for a filled-in example.
