# Hotfix Process

## When to use

Critical production bug requiring an immediate patch, without waiting for the normal release cycle.

## Steps

### 1. Create the hotfix branch from the tag

```bash
git checkout vX.Y.Z
git checkout -b hotfix/X.Y.Z+1
```

### 2. Fix and commit

```bash
# Apply the fix
git commit -m "fix(scope): description of the critical fix"
```

### 3. PR to main

- CI validates the fix
- Expedited review (1 approval minimum)

### 4. Tag after merge

```bash
git checkout main && git pull
git tag vX.Y.Z+1
git push origin vX.Y.Z+1
```

The tag automatically triggers the Docker build and push.

## Important notes

- A hotfix contains **only** the fix, nothing else
- Update `CHANGELOG.md` with the hotfix section
- Verify E2E tests pass before tagging
