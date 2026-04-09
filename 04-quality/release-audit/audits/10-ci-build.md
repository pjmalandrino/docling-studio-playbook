# Audit 10 — CI / Build

**Objective**: verify that the CI pipeline is green, the build works, and quality tools are active.

---

## Checklist

### 10.1 CI Pipeline

| # | Item | Weight |
|---|------|--------|
| 10.1.1 | All CI checks pass on the release branch | 3 |
| 10.1.2 | Linter warnings are resolved (0 warnings) for backend | 1 |
| 10.1.3 | Linter warnings are resolved (0 warnings) for frontend | 1 |
| 10.1.4 | Type checking passes (if applicable: TypeScript, mypy, pyright) | 2 |
| 10.1.5 | Code formatting is consistent (formatter check passes) | 1 |

### 10.2 Build / Deploy artifacts

| # | Item | Weight |
|---|------|--------|
| 10.2.1 | Production build succeeds without errors (Docker, binary, bundle) | 3 |
| 10.2.2 | The deployed artifact starts and responds to health checks | 3 |
| 10.2.3 | All build variants (if any) build correctly | 2 |
| 10.2.4 | No unnecessary files in the build artifact (dev deps, source maps in prod, .git, venv) | 1 |

### 10.3 Configuration

| # | Item | Weight |
|---|------|--------|
| 10.3.1 | Reverse proxy / load balancer routes are correct (API, static files, websockets) | 2 |
| 10.3.2 | Environment variables are documented and have sane defaults | 1 |

---

## Verification commands

```bash
# 10.1.2 — Backend lint
BACKEND_LINT_COMMAND 2>&1 | tail -5

# 10.1.3 — Frontend lint
FRONTEND_LINT_COMMAND 2>&1 | tail -5

# 10.1.4 — Type check
TYPE_CHECK_COMMAND 2>&1 | tail -5

# 10.1.5 — Formatting
BACKEND_FORMAT_CHECK_COMMAND 2>&1 | tail -5
FRONTEND_FORMAT_CHECK_COMMAND 2>&1 | tail -5

# 10.2.1 — Build
BUILD_COMMAND 2>&1 | tail -10

# 10.2.4 — Ignore file exists
cat .dockerignore 2>/dev/null || echo "MISSING"
```

---

## Scoring rules

- Weight 3 item violated = `[CRIT]` finding
- Weight 2 item violated = `[MAJ]` finding
- Weight 1 item violated = `[MIN]` finding
