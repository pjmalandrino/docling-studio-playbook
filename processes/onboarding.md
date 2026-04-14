# Onboarding

## Prerequisites

| Tool | Version |
|------|---------|
| Python | 3.12+ |
| Node.js | 22+ |
| Docker + Docker Compose | Latest |
| Git | 2.x |
| Java + Maven | 17+ (for Karate E2E tests) |

## First-time setup

### 1. Backend

```bash
cd document-parser
python -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt        # Remote mode
pip install -r requirements-local.txt  # Local mode (with AI models)
```

### 2. Frontend

```bash
cd frontend
npm install
```

### 3. Docker (full stack)

```bash
# Dev with hot-reload
docker compose -f docker-compose.dev.yml up

# Production-like
docker compose up --build
```

## Run the project

### Without Docker

```bash
# Terminal 1 — Backend
cd document-parser
source .venv/bin/activate
uvicorn main:app --reload --port 8000

# Terminal 2 — Frontend
cd frontend
npm run dev
```

Access the app at `http://localhost:3000` (the frontend proxies `/api` to the backend on port 8000).

### With Docker

```bash
docker compose -f docker-compose.dev.yml up
```

## Essential commands

| Action | Backend | Frontend |
|--------|---------|----------|
| Run | `uvicorn main:app --reload` | `npm run dev` |
| Test | `pytest tests/ -v` | `npm run test:run` |
| Lint | `ruff check .` | `npm run lint` |
| Format | `ruff format .` | `npm run format` |
| Type-check | — | `npm run type-check` |
| Build | — | `npm run build` |

## Recommended reading path

1. This file (installation and commands)
2. [Backend architecture](../README.md#backend-architecture-hexagonal--ports--adapters) — Understand the hexagonal pattern
3. [Commit conventions](commit-conventions.md) — Before your first commit
4. [Code review checklist](code-review.md) — What is expected in a PR
5. [Testing strategy](../quality/testing-strategy.md) — What to test and how

## Resources (in the main Docling Studio repo)

- `CLAUDE.md` in each subproject (`document-parser/`, `frontend/`): detailed conventions
- `CONTRIBUTING.md` at root: contribution guide
- `CHANGELOG.md` at root: version history
- `docs/`: MkDocs documentation deployed on GitHub Pages
