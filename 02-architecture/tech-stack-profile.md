# Tech Stack Profile — <!-- REPLACE: Project Name -->

## Stack

- **Backend**: <!-- REPLACE: e.g. Python 3.12 / FastAPI -->
- **Frontend**: <!-- REPLACE: e.g. TypeScript / Vue 3 -->
- **Database**: <!-- REPLACE: e.g. PostgreSQL 16 -->
- **Infrastructure**: <!-- REPLACE: e.g. Docker, Nginx, GitHub Actions -->

## Layer mapping

| Layer | Path | Notes |
|-------|------|-------|
| Domain | <!-- REPLACE --> | Pure business logic, no framework imports |
| Services | <!-- REPLACE --> | Use case orchestration |
| API | <!-- REPLACE --> | HTTP layer (routes, controllers, serialization) |
| Infrastructure | <!-- REPLACE --> | External adapters (clients, config, messaging) |
| Persistence | <!-- REPLACE --> | Database access |
| Frontend features | <!-- REPLACE --> | One folder per bounded context |
| Frontend shared | <!-- REPLACE --> | Cross-feature types, utils, API client |
| Tests | <!-- REPLACE --> | Unit, integration, e2e |

## File extensions

| Layer | Extensions |
|-------|-----------|
| Backend | <!-- REPLACE: e.g. *.py --> |
| Frontend | <!-- REPLACE: e.g. *.ts, *.vue --> |

## Exclude patterns

```bash
# Backend
<!-- REPLACE: e.g. --exclude-dir=.venv --exclude-dir=__pycache__ -->

# Frontend
<!-- REPLACE: e.g. --exclude-dir=node_modules --exclude-dir=dist -->
```

## Tools

| Tool | Command |
|------|---------|
| Lint | <!-- REPLACE --> |
| Format | <!-- REPLACE --> |
| Test | <!-- REPLACE --> |
| Build | <!-- REPLACE --> |
| Type check | <!-- REPLACE --> |

## Framework imports to detect

```bash
# Imports that should NOT appear in domain/
FRAMEWORK_IMPORTS="<!-- REPLACE -->"

# Imports that should NOT appear in services/
HTTP_FRAMEWORK_IMPORTS="<!-- REPLACE -->"
```
