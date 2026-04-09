# Audit 03 — Clean Code

**Objective**: verify readability, clarity, and maintainability of the codebase.

---

## Checklist

### 3.1 Naming

| # | Item | Weight |
|---|------|--------|
| 3.1.1 | Functions are named with action verbs (`create_user`, `fetch_orders`, not `user()` or `orders()`) | 1 |
| 3.1.2 | Variables express intent (`remaining_pages`, not `rp` or `tmp`) | 1 |
| 3.1.3 | Codebase uses a single human language consistently (English recommended) | 2 |
| 3.1.4 | No ambiguous abbreviations except established conventions (`id`, `url`, `dto`, `db`) | 1 |

### 3.2 Functions

| # | Item | Weight |
|---|------|--------|
| 3.2.1 | Each function does one thing (Single Responsibility) | 2 |
| 3.2.2 | No function exceeds ~30 lines (excluding unavoidable boilerplate) | 1 |
| 3.2.3 | No function has more than 4 parameters — group into an object beyond that | 1 |
| 3.2.4 | No boolean flag arguments that switch behavior | 1 |
| 3.2.5 | A function named `get_*` / `find_*` does not mutate state (no hidden side-effects) | 2 |

### 3.3 Files and structure

| # | Item | Weight |
|---|------|--------|
| 3.3.1 | No source file exceeds ~300 lines | 1 |
| 3.3.2 | One concept per file — no catch-all mega-files | 2 |
| 3.3.3 | Imports are ordered: stdlib, external deps, internal imports | 1 |

### 3.4 Comments and dead code

| # | Item | Weight |
|---|------|--------|
| 3.4.1 | Code is self-documenting — comments explain "why", not "what" | 1 |
| 3.4.2 | No commented-out code left in place | 1 |

---

## Verification commands

```bash
# 3.3.1 — Files over 300 lines (backend)
find BACKEND_PATH -name "*.EXT" EXCLUDE_FLAGS | xargs wc -l | sort -rn | head -20

# 3.3.1 — Files over 300 lines (frontend)
find FRONTEND_PATH -name "*.EXT" | xargs wc -l | sort -rn | head -20

# 3.2.3 — Functions with > 4 parameters
grep -rn "def .*,.*,.*,.*,.*," BACKEND_PATH --include="*.EXT" EXCLUDE_FLAGS

# 3.4.2 — Commented-out code
grep -rn "^[[:space:]]*#.*=\|^[[:space:]]*#.*def \|^[[:space:]]*//.*function\|^[[:space:]]*//.*const " BACKEND_PATH FRONTEND_PATH EXCLUDE_FLAGS
```

---

## Scoring rules

- Weight 3 item violated = `[CRIT]` finding
- Weight 2 item violated = `[MAJ]` finding
- Weight 1 item violated = `[MIN]` finding
