# Release Process

## Steps

### 1. Create the release branch

```bash
git checkout main && git pull
git checkout -b release/X.Y.Z
```

### 2. On the release branch (only)

- Bug fixes only (no new features)
- Move `[Unreleased]` to `[X.Y.Z] - YYYY-MM-DD` in `CHANGELOG.md`
- Update `version` in `package.json`

### 3. Merge to main via PR

The PR triggers the **[release gate](../ci-cd/release-gate.md)** which runs:
- Lint backend + frontend
- Unit tests backend + frontend
- Docker build (smoke)
- Full E2E (@smoke + @regression + @e2e)

### 4. Tag on main

```bash
git checkout main && git pull
git tag vX.Y.Z
git push origin vX.Y.Z
```

### 5. Automatic release (GitHub Actions)

Pushing the tag triggers the release workflow ([details](../ci-cd/release.md)):

- Docker **multi-arch** build (linux/amd64 + linux/arm64)
- 2 targets in matrix: `remote` and `local`
- Automatically generated tags:
  - `X.Y.Z-remote`, `X.Y-remote`, `latest-remote`
  - `X.Y.Z-local`, `X.Y-local`, `latest-local`
- Push to `ghcr.io`
- Cache via GitHub Actions cache

## Versioning

- **Semantic Versioning**: MAJOR.MINOR.PATCH
- **Source of truth**: Git tag `vX.Y.Z`
- `package.json` must match the current release
- Version auto-injected:
  - Frontend: Vite `__APP_VERSION__` (via `VITE_APP_VERSION`)
  - Backend: `APP_VERSION` environment variable
