# Profile: FastAPI + Vue 3

Stack: Python FastAPI backend + Vue 3 / TypeScript frontend + Nginx reverse proxy + Docker.

---

## Layer mapping

| Generic layer | Concrete path | Notes |
|---------------|---------------|-------|
| Domain | `backend/domain/` | Pure Python: dataclasses, protocols, value objects |
| Services | `backend/services/` | Use case orchestration |
| API | `backend/api/` | FastAPI routes, Pydantic schemas |
| Infrastructure | `backend/infra/` | Adapters (converters, external clients, settings) |
| Persistence | `backend/persistence/` | DB access (aiosqlite, SQLAlchemy, etc.) |
| Entry point | `backend/main.py` | Composition root (DI wiring) |
| Frontend features | `frontend/src/features/` | One folder per bounded context |
| Frontend shared | `frontend/src/shared/` | Cross-feature types, utils, API client |
| Frontend pages | `frontend/src/pages/` | Route-level components |
| Tests backend | `backend/tests/` | pytest |
| Tests frontend | `frontend/src/**/*.test.*` | Vitest |
| Tests e2e | `e2e/` | Playwright, Cypress, Karate UI, etc. |

## File extensions

| Layer | Extensions |
|-------|-----------|
| Backend | `*.py` |
| Frontend | `*.ts`, `*.vue` |

## Exclude patterns

```bash
# Backend excludes
--exclude-dir=.venv --exclude-dir=__pycache__ --exclude-dir=tests

# Frontend excludes
--exclude-dir=node_modules --exclude-dir=dist
```

## Tools

| Tool | Command |
|------|---------|
| Backend lint | `cd backend && ruff check .` |
| Backend format check | `cd backend && ruff format --check .` |
| Backend tests | `cd backend && pytest tests/ -v` |
| Frontend lint | `cd frontend && npx eslint src/` |
| Frontend format check | `cd frontend && npx prettier --check src/` |
| Frontend type check | `cd frontend && npx vue-tsc --noEmit` |
| Frontend tests | `cd frontend && npm run test:run` |
| E2E tests | `cd e2e && npm test` |
| Docker build | `docker compose build` |
| Dependency audit (npm) | `cd frontend && npm audit --production` |
| Dependency audit (pip) | `cd backend && pip-audit` |

## Framework-specific imports to detect

```bash
# Imports that should NOT appear in domain/
FRAMEWORK_IMPORTS="from fastapi\|from aiosqlite\|from pydantic\|import fastapi\|import aiosqlite"

# Imports that should NOT appear in services/
HTTP_FRAMEWORK_IMPORTS="from fastapi\|import fastapi"

# Imports that should NOT appear in api/
PERSISTENCE_IMPORTS="from persistence\|import persistence"
```

## Frontend store pattern

```bash
# Store usage pattern (Pinia)
USE_STORE_PATTERN="useDocumentStore\|useAnalysisStore\|useChunkingStore\|useHistoryStore\|useSettingsStore"
```
