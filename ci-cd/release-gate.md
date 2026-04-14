# Release Gate

## Purpose

Automatic validation triggered on PRs to `release/**` branches.
Ensures everything is green before merging to main.

## What runs

1. **Backend lint** — `ruff check .`
2. **Frontend lint** — `npx eslint src/`
3. **Backend tests** — `pytest tests/ -v`
4. **Frontend tests** — `npm run type-check && npm run test:run`
5. **Docker build** — Build smoke test
6. **Full E2E** — `@smoke` + `@regression` + `@e2e`

## Difference from standard CI

| Check | CI (PR -> main) | Release Gate (PR -> release) |
|-------|-----------------|------------------------------|
| Lint | yes | yes |
| Unit tests | yes | yes |
| Build | yes | yes |
| E2E @smoke | yes | yes |
| E2E @regression | — | yes |
| E2E @e2e | — | yes |

The release gate is stricter: it includes full E2E tests that standard CI does not run on every PR.

## See also

- [Standard CI](ci.md) — Pipeline on every PR
- [Release pipeline](release.md) — Docker build after tagging
- [Release process](../processes/release.md) — Manual steps before and after
- [Quality audit](../processes/audit.md) — Full audit framework (12 axes)
