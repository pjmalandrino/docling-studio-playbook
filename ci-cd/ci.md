# CI Pipeline

## Triggers

- **Push** to `main`
- **PR** to `main` or `release/**`

Concurrency: cancels previous runs on the same branch/PR.

## Jobs

### Backend (ubuntu-latest, Python 3.12)

```yaml
steps:
  - Checkout
  - Setup Python 3.12
  - Install poppler-utils (system, for pdf2image)
  - pip install requirements.txt + pytest + pytest-asyncio + httpx + ruff
  - ruff check .                    # Lint
  - pytest tests/ -v                # Tests
```

### Frontend (ubuntu-latest, Node 22)

```yaml
steps:
  - Checkout
  - Setup Node 22
  - npm ci                          # Deterministic install
  - npx eslint src/                 # Lint
  - npm run type-check              # vue-tsc
  - npm run test:run                # Vitest
  - npm run build                   # Vite build
```

### E2E API (Karate)

```yaml
needs: [backend, frontend]          # Waits for both to pass
steps:
  - Generate test PDFs
  - Start docker stack
  - Wait for health endpoint (30s retry)
  - mvn test with tags:
    - @smoke on PR to main
    - @smoke,@regression,@e2e on PR to release
  - Upload reports (artifacts)
```

### E2E UI (Karate UI)

```yaml
# Only on main (not every PR)
steps:
  - Setup Chrome headless
  - Generate test PDFs
  - Start docker stack
  - mvn test -Dkarate.options="--tags @critical"
  - Upload reports (artifacts)
```

## Philosophy

- **PR to main** — Fast feedback (30s to 2min). Smoke tests only. Catches obvious regressions.
- **PR to release** — Exhaustive validation (5-10min). Includes regression + full E2E. Ensures release candidate is solid. See [release gate](release-gate.md).
- **Push to main** — Critical UI tests added, because main must stay stable.

## Matrix: what runs when

| Event | Backend | Frontend | E2E API | E2E UI |
|-------|---------|----------|---------|--------|
| PR -> main | lint + tests | lint + types + tests + build | @smoke | — |
| PR -> release | lint + tests | lint + types + tests + build | @smoke + @regression + @e2e | — |
| Push main | lint + tests | lint + types + tests + build | @smoke | @critical |

## See also

- [Release gate](release-gate.md) — Stricter validation on release PRs
- [Release pipeline](release.md) — Docker build triggered by tags
- [Testing strategy](../quality/testing-strategy.md) — Test pyramid and conventions
