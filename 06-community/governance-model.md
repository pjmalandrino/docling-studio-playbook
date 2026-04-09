# Governance Model

How decisions are made in this project.

## Current model: BDFL (Benevolent Dictator For Life)

<!-- REPLACE: This is the default for solo-maintained projects. Adapt as your project grows. -->

**Maintainer**: <!-- REPLACE: @username -->

The maintainer has final say on all technical and project decisions. All significant decisions are discussed publicly in issues before being made.

## Principles

1. **Transparency** — decisions are made in public (issues, PRs, discussions)
2. **Merit** — the best argument wins, regardless of who makes it
3. **Pragmatism** — ship working software over debating perfection
4. **Respect** — disagree with ideas, not people

## Roles

| Role | Responsibilities | How to get it |
|------|-----------------|---------------|
| **Maintainer** | Final decisions, merge rights, releases, community management | Project creator |
| **Contributor** | Submit PRs, report issues, participate in discussions | Anyone |
| **Committer** | Review PRs, triage issues, merge approved PRs | Consistent quality contributions over time |

## Decision process

### Small decisions (code style, minor features)

Maintainer decides, often during PR review. No formal process needed.

### Medium decisions (new features, dependency changes)

1. Open an issue describing the proposal
2. Discussion period: **7 days**
3. Maintainer makes the final call, documenting the reasoning

### Large decisions (architecture changes, breaking changes, governance changes)

1. Open an issue or ADR (see [02-architecture/](../02-architecture/))
2. Discussion period: **14 days**
3. Maintainer summarizes the discussion and makes the final call
4. Decision is recorded as an ADR

## Evolution

As the project grows, this model may evolve:

| Stage | Governance |
|-------|-----------|
| Solo | BDFL — one maintainer decides |
| Small team (2-5) | BDFL + committers — maintainer delegates reviews |
| Growing community (5+) | Steering committee — shared decision-making |

Any governance change will be proposed as an issue with a 30-day discussion period.
