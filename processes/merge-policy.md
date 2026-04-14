# Merge Policy

## Merge conditions

1. **Green CI** — All jobs pass (backend, frontend, e2e if applicable)
2. **Approved review** — At least 1 approval
3. **No conflicts** — Branch is up to date with base
4. **PR checklist complete** — All items checked

## Merge strategy

- **Squash merge** for feature branches -> `main`
- **Merge commit** for release branches -> `main` (preserves history)
- **Rebase** for hotfix branches

## Protected branches

| Branch | Rules |
|--------|-------|
| `main` | PR required, CI required, review required |
| `release/*` | PR required, CI required + full E2E |
