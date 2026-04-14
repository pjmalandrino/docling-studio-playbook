# Release Gate

## Objectif

Validation automatique declenchee sur les PR vers les branches `release/**`.
S'assure que tout est vert avant le merge vers main.

## Ce qui est execute

1. **Lint backend** — `ruff check .`
2. **Lint frontend** — `npx eslint src/`
3. **Tests backend** — `pytest tests/ -v`
4. **Tests frontend** — `npm run type-check && npm run test:run`
5. **Build Docker** — Smoke test du build
6. **E2E complets** — `@smoke` + `@regression` + `@e2e`

## Difference avec la CI standard

| Check | CI (PR -> main) | Release Gate (PR -> release) |
|-------|-----------------|------------------------------|
| Lint | oui | oui |
| Unit tests | oui | oui |
| Build | oui | oui |
| E2E @smoke | oui | oui |
| E2E @regression | — | oui |
| E2E @e2e | — | oui |

Le release gate est plus strict : il inclut les tests E2E complets que la CI standard ne lance pas sur chaque PR.
