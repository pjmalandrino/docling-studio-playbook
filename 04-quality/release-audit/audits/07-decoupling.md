# Audit 07 — Decoupling

**Objective**: verify decoupling between frontend and backend, between modules/features, and clarity of interface contracts.

---

## Checklist

### 7.1 Frontend / Backend decoupling

| # | Item | Weight |
|---|------|--------|
| 7.1.1 | Frontend communicates with backend exclusively via the API — no shared files, shared DB, or cross imports | 3 |
| 7.1.2 | The API contract is stable — frontend types correspond to backend schemas | 3 |
| 7.1.3 | Frontend can run with a mocked backend (API calls are isolated in dedicated files per feature) | 2 |
| 7.1.4 | Backend can be tested without the frontend (endpoints testable via HTTP test client) | 2 |
| 7.1.5 | No business logic duplicated between frontend and backend (e.g. validation reinvented on both sides) | 2 |

### 7.2 Inter-feature decoupling (Frontend)

| # | Item | Weight |
|---|------|--------|
| 7.2.1 | Each feature module has its own state management, API client, and UI components | 2 |
| 7.2.2 | Features do not import each other directly — communication goes through a shared layer or props/events | 3 |
| 7.2.3 | Shared types between features live in a common shared module, not inside a specific feature | 2 |
| 7.2.4 | A state module does not directly access another module's internal state (only exposed getters/selectors) | 2 |

### 7.3 Inter-layer decoupling (Backend)

| # | Item | Weight |
|---|------|--------|
| 7.3.1 | Repositories return domain objects, not raw dicts, ORM entities, or DB rows | 2 |
| 7.3.2 | Infrastructure adapters don't expose their internal library types to the service layer | 3 |
| 7.3.3 | Changing the database engine requires modifying only the persistence layer | 2 |
| 7.3.4 | Changing the HTTP framework requires modifying only the API layer and entry point | 2 |

### 7.4 Contracts and interfaces

| # | Item | Weight |
|---|------|--------|
| 7.4.1 | Domain ports define clear signatures with domain types (no `dict`, `Any`, `Object` in signatures) | 2 |
| 7.4.2 | API schemas document the HTTP contract — no untyped `dict` or `any` in responses | 2 |
| 7.4.3 | API responses follow a consistent format (error envelope, status codes) | 1 |

---

## Verification commands

```bash
# 7.2.2 — Cross-imports between features (frontend)
grep -rn "from.*features/" FRONTEND_FEATURES_PATH/ --include="*.EXT" | grep -v "__tests__"

# 7.2.4 — Store accessing another store's state directly
grep -rn "USE_STORE_PATTERN" FRONTEND_FEATURES_PATH/ --include="*.EXT"

# 7.3.2 — Library types leaking to services
grep -rn "from LIBRARY\|import LIBRARY" SERVICES_PATH/ --include="*.EXT"

# 7.4.2 — dict/Any/any in API responses
grep -rn "-> dict\|-> Any\|: any\|Dict\[str, Any\]" API_PATH/ --include="*.EXT"
```

---

## Scoring rules

- Weight 3 item violated = `[CRIT]` finding
- Weight 2 item violated = `[MAJ]` finding
- Weight 1 item violated = `[MIN]` finding
