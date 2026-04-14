# Rollback Process

## When to use

Post-deploy incident that cannot be quickly resolved with a hotfix.

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

- Document the incident
- Create a hotfix for the problematic version
- Never re-tag an existing version
