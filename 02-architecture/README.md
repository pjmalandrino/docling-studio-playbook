# 02 — Architecture

Track technical decisions, define coding standards, and document your stack.

## What's here

| Template | Purpose |
|----------|---------|
| [adr-template.md](adr-template.md) | Architecture Decision Record — one per decision |
| [adr-guide.md](adr-guide.md) | How to write good ADRs |
| [coding-standards.md](coding-standards.md) | Project-wide code conventions template |
| [tech-stack-profile.md](tech-stack-profile.md) | Document your stack's layers, tools, and commands |

## How to use

```bash
# Start recording decisions
mkdir -p docs/architecture/decisions
cp 02-architecture/adr-template.md docs/architecture/decisions/001-use-postgresql.md
# Fill it in — done

# Define your standards
cp 02-architecture/coding-standards.md docs/architecture/coding-standards.md
```

## Why ADRs matter

Code tells you *what*. Commits tell you *when*. ADRs tell you **why**. Six months from now, you (or a contributor) will look at a design choice and wonder why it was made. The ADR answers that question in 60 seconds.
