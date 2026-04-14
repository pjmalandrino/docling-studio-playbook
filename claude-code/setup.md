# Claude Code Setup

## CLAUDE.md per subproject

Each subproject (backend, frontend) has its own `CLAUDE.md` that defines:

- Stack and versions
- Commands to use (lint, test, format, build)
- Architecture and conventions
- Validation pipeline to follow

### Backend (`CLAUDE.md`)

```
Stack: FastAPI + Python 3.12+ + Docling 2.x + aiosqlite + pytest
Architecture: Hexagonal (Ports & Adapters)
  - domain/      -> The core: pure business logic, zero external deps, defines ports
  - api/         -> Adapter IN: FastAPI routers, Pydantic schemas (camelCase DTOs)
  - services/    -> Use case orchestration
  - persistence/ -> Adapter OUT: Repository pattern (aiosqlite)
  - infra/       -> Adapters OUT: converters, embeddings, rate limiter, settings

Validation pipeline:
  ruff check . --fix -> ruff format . -> ruff check . -> ruff format --check . -> pytest tests/ -v
```

### Frontend (`CLAUDE.md`)

```
Stack: Vue 3 + TypeScript (strict) + Vite + Pinia + Vitest
Architecture: Feature-based
  - src/features/{name}/api/   -> HTTP calls
  - src/features/{name}/store/ -> Pinia state
  - src/features/{name}/ui/    -> Vue components
  - src/pages/                 -> Route pages
  - src/app/                   -> Application shell

Validation pipeline:
  npm run lint:fix -> npm run format -> npm run lint -> npm run format:check -> npm run type-check -> npm run test:run

Rules:
  - Always use DOMPurify for HTML, Marked for Markdown
  - Colocated tests (*.test.ts)
  - Path alias @/ -> src/
```

## Permissions (settings.local.json)

200+ permission rules covering:

| Category | Examples |
|----------|----------|
| Backend tests | `pytest tests/ -v`, `pytest tests/test_*.py -v` |
| Frontend tests | `npx vitest run`, `npm run test:run` |
| Lint/Format | `ruff check`, `ruff format`, `npx eslint`, `npx prettier` |
| Type-check | `vue-tsc --noEmit` |
| Git | `git status`, `git log`, `git diff`, `git commit`, `git push` |
| Docker | `docker build` |
| Web | WebSearch/WebFetch (GitHub, PyPI, official docs) |

## Launch config (launch.json)

Configuration to launch the frontend dev server directly from Claude Code:

```json
{
  "name": "frontend",
  "runtimeExecutable": "/bin/bash",
  "runtimeArgs": ["-c", "cd frontend && npx vite --port 3000"],
  "port": 3000
}
```

Allows testing UI changes directly in the browser during a Claude Code session.
