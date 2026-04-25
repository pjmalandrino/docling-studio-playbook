# Pull Request Template (reference)

> Standalone reference. Mirrors [`.github/PULL_REQUEST_TEMPLATE.md`](https://github.com/scub-france/Docling-Studio/blob/main/.github/PULL_REQUEST_TEMPLATE.md) on the main repo so the checklist lives next to the rest of the playbook. Used during [code review](../processes/code-review.md), [merge](../processes/merge-policy.md), and [audit](../processes/audit.md). The version on the repo is the one GitHub auto-fills — keep them in sync.

## Sections (in order)

### Type

Pick exactly one. The branch prefix from [`/resolve`](../processes/resolve.md)
determines this almost mechanically.

- [ ] Feature (`feature/*`)
- [ ] Bug fix (`fix/*`)
- [ ] Hotfix (`hotfix/*`) — see [Hotfix](../processes/hotfix.md)
- [ ] Documentation (`docs/*`)
- [ ] Refactoring
- [ ] CI/CD
- [ ] Other: ___

### Summary

1–3 sentences: what changed and **why**. The why is what the reviewer
optimizes for — the diff already shows the what.

### Related issues

`Closes #<n>` for the issue resolved by this PR. `Refs #<n>` for issues
this PR contributes to without closing. Every PR should reference at least
one issue (see [Issue Creation](../processes/issue-creation.md) and
[Resolve](../processes/resolve.md)).

### Checklist

The hard floor below is what the [merge policy](../processes/merge-policy.md)
requires. Don't tick a box that isn't actually done.

- [ ] Branch follows naming convention (`<prefix>/<issue-number>-<slug>`,
      see [Resolve](../processes/resolve.md))
- [ ] Commits follow [Conventional Commits](../processes/commit-conventions.md)
- [ ] Tests added/updated for the change (see [Testing Patterns](testing-patterns.md))
- [ ] All tests pass (`pytest tests/ -v` + `npm run test:run`) — see
      [Claude Code Workflows](../claude-code/workflows.md) for the full
      validation pipeline
- [ ] Linting passes (`ruff check .` + `npx eslint src/`)
- [ ] `CHANGELOG.md` updated under `[Unreleased]` (Keep a Changelog format)
- [ ] Documentation updated if behavior changed (env vars in
      [`infrastructure/docker.md`](../infrastructure/docker.md) when
      relevant)
- [ ] No secrets, credentials, or `.env` content committed (see
      [Security Checklist](security-checklist.md))

### Screenshots / Evidence

UI changes: before/after screenshots. API changes: a `curl` example or
test output. Performance changes: a measurement and the threshold it
beats (see [Performance Checklist](performance-checklist.md)).

## Review-side checklist (reviewer-facing)

These boxes don't ship in the PR body — they live in the
[Code Review process](../processes/code-review.md). Listed here so the
author can self-review before requesting review:

- [ ] PR scope matches the linked issue (no scope creep)
- [ ] Architecture rules respected (see [Architecture Checklist](architecture-checklist.md))
- [ ] Security considerations covered (see [Security Checklist](security-checklist.md))
- [ ] Tests actually exercise the new behavior (not just structure)
- [ ] Performance budget respected when relevant (see [Performance Checklist](performance-checklist.md))

## Red flags (PR will bounce in review)

- Empty or missing **Summary** section
- No `Closes #<n>` and no `Refs #<n>`
- Checklist boxes ticked while CI is red
- "Documentation updated if behavior changed" ticked without a docs diff
- UI change with no screenshot
- Branch name not matching `<prefix>/<n>-<slug>` — see [Resolve](../processes/resolve.md)
- `CHANGELOG.md` untouched on a user-visible change
