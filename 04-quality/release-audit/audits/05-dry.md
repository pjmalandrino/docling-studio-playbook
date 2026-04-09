# Audit 05 — DRY (Don't Repeat Yourself)

**Objective**: verify absence of significant code duplication.

---

## Checklist

### 5.1 — Code duplication

| # | Item | Weight |
|---|------|--------|
| 5.1.1 | No identical or near-identical code block appears 3+ times without being factored out | 2 |
| 5.1.2 | Shared types/interfaces are centralized in a single location (not redefined per module) | 2 |
| 5.1.3 | No magic numbers or magic strings scattered across the codebase — constants are named and centralized | 2 |
| 5.1.4 | Shared logic (utilities, composables, helpers) lives in a common module, not duplicated per feature | 1 |

### 5.2 — Configuration & schema duplication

| # | Item | Weight |
|---|------|--------|
| 5.2.1 | API client configuration (base URL, headers, auth) is centralized, not repeated per call | 2 |
| 5.2.2 | Serialization/API schemas do not redefine domain models — they transform, not duplicate | 2 |
| 5.2.3 | Validation rules are defined in one place (backend OR frontend), not inconsistently in both | 1 |

---

## Verification commands

```bash
# 5.1.3 — Magic numbers (backend)
grep -rn "[^a-zA-Z_\"'][0-9]\{3,\}[^a-zA-Z_\"']" BACKEND_PATH --include="*.EXT" EXCLUDE_FLAGS

# 5.1.3 — Repeated magic strings (backend)
grep -rohn '"[a-z_]\{5,\}"' BACKEND_PATH --include="*.EXT" EXCLUDE_FLAGS | sort | uniq -c | sort -rn | head -20

# 5.2.1 — Fetch/HTTP calls outside the centralized client (frontend)
grep -rn "fetch(\|axios\.\|HttpClient" FRONTEND_PATH --include="*.EXT" | grep -v "http.ts\|api.ts\|client.ts\|httpClient"
```

---

## Scoring rules

- Weight 3 item violated = `[CRIT]` finding
- Weight 2 item violated = `[MAJ]` finding
- Weight 1 item violated = `[MIN]` finding
