# Claude Code Workflows

## Automated validation pipelines

Claude Code follows the pipelines defined in each subproject's `CLAUDE.md`. Here are the two main pipelines:

### Backend — Full validation

```bash
# 1. Auto-fix
ruff check . --fix
ruff format .

# 2. Strict verification
ruff check .
ruff format --check .

# 3. Tests
pytest tests/ -v
```

This pipeline runs **before every commit** on the backend side.

### Frontend — Full validation

```bash
# 1. Auto-fix
npm run lint:fix
npm run format

# 2. Strict verification
npm run lint
npm run format:check

# 3. Type-check
npm run type-check

# 4. Tests
npm run test:run
```

This pipeline runs **before every commit** on the frontend side.

## Typical feature workflow

1. **Understand** — Claude Code reads existing code, tests, specs
2. **Implement** — Backend and/or frontend code
3. **Validate** — Runs the relevant subproject's validation pipeline
4. **Visual test** — Launches the dev server (launch.json) and verifies in the browser
5. **Commit** — Conventional Commits with appropriate scope

## Conventions enforced by Claude Code

- **Hexagonal Architecture**: no layer leaks (domain depends on nothing, adapters implement ports)
- **Separate DTOs**: Pydantic schemas (camelCase) != domain models
- **Feature-based**: each frontend feature in its own folder with api/, store/, ui/
- **Colocated tests**: `*.test.ts` next to source code
- **DOMPurify**: all dynamic HTML is sanitized
- **No console.log**: only `console.warn` and `console.error`
