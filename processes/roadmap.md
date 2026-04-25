# Roadmap

> **When to use**: Maintaining the public expectation of what's coming next. Updated at the start of every release cycle and whenever a feature is committed-to, declined, or shifted between buckets.

The roadmap is a *commitment* document, not a wishlist. Every entry is
either backed by an issue + milestone (via [`/create-issue`](issue-creation.md))
or it doesn't belong on the roadmap at all.

## The four buckets

```
Now -> Next -> Later -> Not Planned
```

| Bucket | Meaning | What lives here |
|---|---|---|
| **Now** | Current release cycle | Features actively in progress, with an open issue, an assigned milestone, and (for non-trivial work) an [Accepted design doc](conception.md) |
| **Next** | Next release cycle | Features committed for the upcoming milestone, prioritized (`P1`/`P2`), but not yet started |
| **Later** | Accepted, no timeline | Ideas the maintainers endorse but won't schedule until a "Now" slot frees up |
| **Not Planned** | Explicitly declined | Decisions to *not* do something — captured to avoid repeat requests |

Anything else is just a backlog issue. It does **not** appear on the
roadmap until it lands in one of these four buckets.

## Template

The canonical template lives in the main repo at
[`docs/community/roadmap-template.md`](https://github.com/scub-france/Docling-Studio/blob/main/docs/community/roadmap-template.md).
Skeleton:

```markdown
# Roadmap — Docling Studio

Last updated: YYYY-MM-DD

## Now (current release cycle)

| Feature | Issue | Status |
|---------|-------|--------|
| ... | #NNN | In progress |

## Next (next release cycle)

| Feature | Issue | Priority |
|---------|-------|----------|
| ... | #NNN | P1 |

## Later

| Feature | Issue |
|---------|-------|
| ... | #NNN |

## Not Planned

| Feature | Reason |
|---------|--------|
| ... | ... |
```

Always update `Last updated:` when you touch the file.

## Workflow

1. **Open the release cycle.** When a `release/X.Y.Z` branch is cut,
   freeze "Now" and slide "Next" into "Now". Items that didn't ship slip
   to "Now" of the next cycle (with a comment explaining the slip) or
   demote to "Later".
2. **Commit a feature to the roadmap.** It must already have an issue
   (via `/create-issue`) with a milestone. Promote from "Later" → "Next" →
   "Now" only when the milestone matches the current/upcoming release.
3. **Decline a request.** Move it to "Not Planned" with a one-line reason.
   Don't silently delete — explicit "no" beats ambiguous silence.
4. **Touch the file every release.** Even if just to bump
   `Last updated:`. Stale roadmaps are worse than no roadmap.

## Red flags

- Roadmap not updated for > 1 release cycle — readers can't tell what's
  current
- "Now" contains items with no open issue — invisible work
- "Now" contains items without a design doc when the type is
  `enhancement` / `[FEATURE]` — see [Conception](conception.md)
- "Not Planned" is empty — either every request is accepted (unlikely) or
  declined items are being silently dropped
- Same item lives in two buckets — pick one
- Roadmap diverges from open milestones (`gh api .../milestones`) — the
  source of truth for *scheduled* work is milestones, not the roadmap

## Anti-rationalizations

| Excuse | Why it doesn't hold |
|--------|---------------------|
| "The roadmap will lock me into commitments" | "Now" is a commitment by design. "Later" and "Not Planned" exist precisely so you can say "yes, but not yet" or "no, here's why" without lying |
| "I'll update it when something interesting happens" | Define interesting. Pinning a `Last updated:` date forces the discipline of touching it on a cadence |
| "Issues + milestones are enough, the roadmap duplicates them" | Issues + milestones tell you *what's scheduled*. The roadmap tells outsiders *what we care about* — a different audience |
| "We don't need a 'Not Planned' section" | Yes you do. The same feature request will resurface every 6 months until you've publicly explained why it's out of scope |

## Verification

- [ ] `Last updated:` is within the last 30 days
- [ ] Every "Now" item links to an open issue with a milestone matching
      the current release
- [ ] Every "Next" item links to an open issue with a milestone matching
      the next release
- [ ] No item appears in two buckets
- [ ] "Not Planned" has at least one entry with a reason
- [ ] Roadmap entries are reachable via the issue's milestone in
      `gh api repos/scub-france/Docling-Studio/milestones`
