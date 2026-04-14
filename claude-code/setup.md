# Claude Code Setup

## CLAUDE.md par sous-projet

Chaque sous-projet (backend, frontend) a son propre `CLAUDE.md` qui definit :

- La stack et les versions
- Les commandes a utiliser (lint, test, format, build)
- L'architecture et les conventions
- Le pipeline de validation a respecter

### Backend (`CLAUDE.md`)

```
Stack: FastAPI + Python 3.12+ + Docling 2.x + aiosqlite + pytest
Architecture: Clean Architecture
  - domain/    -> Pure business logic, aucune dep externe
  - api/       -> FastAPI routers, Pydantic schemas (camelCase DTOs)
  - services/  -> Orchestration des use cases
  - persistence/ -> Repository pattern (aiosqlite)
  - infra/     -> Adapters (converters, rate limiter, settings)

Pipeline de validation:
  ruff check . --fix -> ruff format . -> ruff check . -> ruff format --check . -> pytest tests/ -v
```

### Frontend (`CLAUDE.md`)

```
Stack: Vue 3 + TypeScript (strict) + Vite + Pinia + Vitest
Architecture: Feature-based
  - src/features/{name}/api/   -> Appels HTTP
  - src/features/{name}/store/ -> State Pinia
  - src/features/{name}/ui/    -> Composants Vue
  - src/pages/                 -> Pages de route
  - src/app/                   -> Shell applicatif

Pipeline de validation:
  npm run lint:fix -> npm run format -> npm run lint -> npm run format:check -> npm run type-check -> npm run test:run

Regles:
  - Toujours DOMPurify pour le HTML, Marked pour le Markdown
  - Tests colocates (*.test.ts)
  - Path alias @/ -> src/
```

## Permissions (settings.local.json)

200+ regles de permission couvrant :

| Categorie | Exemples |
|-----------|----------|
| Tests backend | `pytest tests/ -v`, `pytest tests/test_*.py -v` |
| Tests frontend | `npx vitest run`, `npm run test:run` |
| Lint/Format | `ruff check`, `ruff format`, `npx eslint`, `npx prettier` |
| Type-check | `vue-tsc --noEmit` |
| Git | `git status`, `git log`, `git diff`, `git commit`, `git push` |
| Docker | `docker build` |
| Web | WebSearch/WebFetch (GitHub, PyPI, docs officielles) |

## Launch Config (launch.json)

Configuration pour lancer le serveur de dev frontend directement depuis Claude Code :

```json
{
  "name": "frontend",
  "runtimeExecutable": "/bin/bash",
  "runtimeArgs": ["-c", "cd frontend && npx vite --port 3000"],
  "port": 3000
}
```

Permet de tester les changements UI directement dans le navigateur pendant une session Claude Code.
