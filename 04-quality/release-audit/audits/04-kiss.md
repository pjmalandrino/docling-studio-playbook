# Audit 04 — KISS (Keep It Simple, Stupid)

**Objective**: verify that the code remains simple and contains no unnecessary complexity.

---

## Checklist

### 4.1 — Over-engineering

| # | Item | Weight |
|---|------|--------|
| 4.1.1 | No complex design pattern where a simple `if` or function would suffice (unnecessary Factory, Strategy, Observer...) | 2 |
| 4.1.2 | Code solves the current problem, not a hypothetical future one (no premature generalization) | 2 |
| 4.1.3 | No wrapper function that only delegates to another function with no added value | 1 |
| 4.1.4 | Standard library and framework tools are used before creating custom solutions | 1 |

### 4.2 — Unnecessary complexity

| # | Item | Weight |
|---|------|--------|
| 4.2.1 | Configuration is simple — no complex config system where an env var would suffice | 1 |
| 4.2.2 | No unnecessary indirection — a request's execution path doesn't traverse more layers than needed | 2 |
| 4.2.3 | No metaprogramming or "magic" (complex decorators, metaclasses, reflection) unless clearly justified | 2 |
| 4.2.4 | Simplest data structure is used (list over tree if list works, string over enum if only 2 values) | 1 |

---

## Verification commands

```bash
# 4.1.1 — Potentially superfluous patterns
grep -rn "class.*Factory\|class.*Strategy\|class.*Observer\|class.*Builder\|class.*Singleton" BACKEND_PATH --include="*.EXT" EXCLUDE_FLAGS

# 4.2.3 — Metaprogramming
grep -rn "__metaclass__\|type(.*,.*,.*)\|__init_subclass__\|Proxy\|Reflect\.\|eval(" BACKEND_PATH FRONTEND_PATH EXCLUDE_FLAGS
```

---

## Scoring rules

- Weight 3 item violated = `[CRIT]` finding
- Weight 2 item violated = `[MAJ]` finding
- Weight 1 item violated = `[MIN]` finding
