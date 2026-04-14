# Issue Triage

> **When to use**: New issue opened — needs classification and prioritization within 48 hours.

## Classification labels

| Label | Description |
|-------|-------------|
| `bug` | Incorrect behavior |
| `feature` | New functionality |
| `enhancement` | Improvement to existing feature |
| `documentation` | Documentation update |
| `good first issue` | Accessible to new contributors |
| `help wanted` | External contribution welcome |
| `wontfix` | Will not be addressed |
| `duplicate` | Duplicate of an existing issue |

## Prioritization

| Priority | Criteria | Treatment |
|----------|----------|-----------|
| **P1** | Blocking, critical bug | Current sprint |
| **P2** | Important, user impact | Next sprint |
| **P3** | Nice-to-have | Backlog |
| **P4** | Cosmetic, very low impact | When possible |

## Workflow

1. **New issue**: read, classify (bug/feature/etc.), assign priority
2. **Duplicate**: link to existing issue, close with `duplicate` label
3. **Missing information**: request details, add `needs-info` label
4. **Ready**: assign to sprint based on priority

## Red flags

- Issues open for weeks without any label — triage is not happening
- Every issue marked P2 — if everything is important, nothing is
- Bug reports closed as `wontfix` without explanation — erodes contributor trust
- `needs-info` issues left open indefinitely — close after 30 days of no response
- No `good first issue` labels in the backlog — blocks new contributor onboarding

## Anti-rationalizations

| Excuse | Why it doesn't hold |
|--------|---------------------|
| "I'll triage it when I have time" | Untriaged issues pile up and become impossible to manage. 2 minutes now saves 30 later |
| "The priority is obvious from the title" | It's obvious to you. Not to the person who picks it up next sprint |
| "We don't need labels, the team is small" | Labels are for future-you and future contributors, not just today's team |
| "Closing issues discourages contributors" | Not closing stale issues discourages contributors more — it signals nobody reads them |

## Verification

- [ ] No issue older than 48 hours without at least one label
- [ ] Every bug has a priority label (P1-P4)
- [ ] Duplicate issues are linked and closed (not just closed)
- [ ] `needs-info` issues have a clear question asked
- [ ] Backlog has at least a few `good first issue` items
