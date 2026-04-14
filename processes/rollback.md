# Rollback Process

> **When to use**: Post-deploy incident that cannot be quickly resolved with a hotfix. When in doubt, rollback first, investigate later.

## Steps

### 1. Identify the last stable version

```bash
git tag --list 'v*' --sort=-version:refname | head -5
```

### 2. Redeploy the previous Docker image

```bash
# Pull the stable version image
docker pull ghcr.io/<org>/<repo>:X.Y.Z-<target>

# Restart with that version
docker compose down
# Update the tag in docker-compose.yml or .env
docker compose up -d
```

### 3. Validate the rollback

- Check health endpoints
- Run E2E @smoke tests
- Confirm the issue is resolved

### 4. Post-mortem

- Document the incident (see [Incident Response](incident-response.md))
- Create a [hotfix](hotfix.md) for the problematic version
- Never re-tag an existing version

## Red flags

- Attempting to debug in production instead of rolling back — rollback first, always
- Rolling back to an unverified version — check the tag actually worked before
- No health check after rollback — you might have rolled back to a different broken state
- Rollback without creating an incident report — the same issue will happen again
- Re-tagging an existing version to "fix" it — tags are immutable, create a new patch version

## Anti-rationalizations

| Excuse | Why it doesn't hold |
|--------|---------------------|
| "I almost found the bug, give me 5 more minutes" | Users are impacted now. Rollback takes 2 minutes. Debug on the rolled-back state |
| "Rollback will lose the new features" | Features that break production aren't features. Fix and re-release |
| "The data might be incompatible with the old version" | If your release requires a data migration, the rollback plan should be part of the release checklist |
| "It's only a minor issue" | If you're considering a rollback, it's not minor. Trust your instinct |

## Verification

- [ ] Previous stable version identified from git tags
- [ ] Docker image for that version available on ghcr.io
- [ ] Service restarted with previous version
- [ ] Health endpoints return 200
- [ ] E2E @smoke tests pass
- [ ] Issue confirmed resolved
- [ ] Incident documented (see [Incident Response](incident-response.md))
- [ ] Hotfix or fix PR created for the problematic version
