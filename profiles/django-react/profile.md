# Profile: Django + React

Stack: Python Django backend + React / TypeScript frontend.

---

## Layer mapping

| Generic layer | Concrete path | Notes |
|---------------|---------------|-------|
| Domain | `backend/<app>/models.py`, `backend/<app>/domain/` | Django models + pure domain logic |
| Services | `backend/<app>/services.py` or `backend/<app>/services/` | Use case orchestration |
| API | `backend/<app>/views.py`, `backend/<app>/serializers.py` | DRF views + serializers |
| Infrastructure | `backend/<app>/clients/`, `backend/config/` | External service clients, settings |
| Persistence | `backend/<app>/models.py`, `backend/<app>/managers.py` | Django ORM |
| Entry point | `backend/config/urls.py`, `backend/manage.py` | URL routing, WSGI/ASGI |
| Frontend features | `frontend/src/features/` | One folder per feature |
| Frontend shared | `frontend/src/shared/` or `frontend/src/lib/` | Cross-feature types, utils |
| Tests backend | `backend/<app>/tests/` | pytest or Django test runner |
| Tests frontend | `frontend/src/**/*.test.*` | Jest / Vitest |
| Tests e2e | `e2e/` or `cypress/` | Cypress, Playwright |

## File extensions

| Layer | Extensions |
|-------|-----------|
| Backend | `*.py` |
| Frontend | `*.ts`, `*.tsx` |

## Exclude patterns

```bash
--exclude-dir=.venv --exclude-dir=__pycache__ --exclude-dir=migrations --exclude-dir=tests
--exclude-dir=node_modules --exclude-dir=build --exclude-dir=dist
```

## Tools

| Tool | Command |
|------|---------|
| Backend lint | `cd backend && ruff check .` or `flake8` |
| Backend format check | `cd backend && ruff format --check .` or `black --check .` |
| Backend tests | `cd backend && pytest` or `python manage.py test` |
| Frontend lint | `cd frontend && npx eslint src/` |
| Frontend type check | `cd frontend && npx tsc --noEmit` |
| Frontend tests | `cd frontend && npm test` |
| Docker build | `docker compose build` |

## Framework-specific imports to detect

```bash
# In a Django project, domain logic should not import Django ORM
FRAMEWORK_IMPORTS="from django.db\|from rest_framework\|import django"

# Services should not import DRF views
HTTP_FRAMEWORK_IMPORTS="from rest_framework.views\|from rest_framework.decorators\|from django.http"
```
