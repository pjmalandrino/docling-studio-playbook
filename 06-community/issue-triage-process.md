# Issue Triage Process

How incoming issues are labeled, prioritized, and assigned.

## Triage workflow

```
New issue arrives
    │
    ├── Is it a duplicate? → Close with link to original
    ├── Is it spam / off-topic? → Close
    ├── Needs more info? → Label "needs-info", comment asking for details
    │
    └── Valid issue
        ├── Classify (bug / feature / question / docs)
        ├── Set priority (P0-P3)
        ├── Add labels
        └── Assign to milestone (if applicable)
```

## Labels

### Type

| Label | Description |
|-------|-------------|
| `bug` | Something is broken |
| `feature` | New functionality request |
| `enhancement` | Improvement to existing functionality |
| `docs` | Documentation improvement |
| `question` | Question about usage |
| `chore` | Maintenance, CI, dependencies |

### Priority

| Label | Description | Response time |
|-------|-------------|---------------|
| `P0-critical` | System down, data loss, security vulnerability | Same day |
| `P1-high` | Major feature broken, no workaround | This week |
| `P2-medium` | Feature broken with workaround, or important enhancement | This month |
| `P3-low` | Nice to have, minor improvement | When time allows |

### Status

| Label | Description |
|-------|-------------|
| `needs-info` | Waiting for reporter to provide more details |
| `confirmed` | Bug reproduced or feature approved |
| `good first issue` | Suitable for new contributors |
| `help wanted` | Maintainer would appreciate help |
| `wont-fix` | Intentional behavior or out of scope |
| `stale` | No activity for 30+ days |

## Response time goals

| Issue type | First response | Resolution |
|------------|---------------|------------|
| Security vulnerability | < 24 hours | < 7 days |
| Bug (P0) | < 24 hours | < 3 days |
| Bug (P1) | < 3 days | < 2 weeks |
| Feature request | < 7 days | Roadmap-dependent |
| Question | < 7 days | N/A |

## Stale issue policy

- Issues with no activity for **30 days** are labeled `stale`
- `stale` issues with no activity for **14 more days** are closed
- Closed stale issues can be reopened at any time
