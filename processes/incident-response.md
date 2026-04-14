# Incident Response

## Severity

| Level | Criteria | Response time |
|-------|----------|---------------|
| **P1 — Critical** | Service down, data loss | Immediate |
| **P2 — Major** | Core feature broken | < 4h |
| **P3 — Minor** | Secondary feature degraded | < 24h |
| **P4 — Cosmetic** | UI glitch, error message | Next sprint |

## Workflow

### 1. Detection and triage

- Identify severity
- Assign an owner
- Communicate status

### 2. Investigation

- Check application logs
- Review metrics (if monitoring is in place)
- Reproduce the issue locally if possible

### 3. Resolution

- **P1**: Immediate rollback if fix is not obvious
- **P2-P3**: Hotfix following the standard process
- **P4**: Issue created, scheduled in backlog

### 4. Post-mortem

For any P1/P2 incident:

```markdown
## Post-mortem: [Title]

### Timeline
- HH:MM — Detection
- HH:MM — Investigation started
- HH:MM — Root cause identified
- HH:MM — Fix deployed
- HH:MM — Resolution confirmed

### Root cause
...

### Impact
- Duration: X hours
- Affected users: ...

### Corrective actions
- [ ] Technical fix
- [ ] Additional test
- [ ] Monitoring improvement
```
