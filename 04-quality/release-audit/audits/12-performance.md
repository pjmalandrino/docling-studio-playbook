# Audit 12 — Performance & Resources

**Objective**: verify absence of obvious performance issues and proper resource management.

---

## Checklist

### 12.1 Backend

| # | Item | Weight |
|---|------|--------|
| 12.1.1 | No N+1 queries — DB access is optimized (no loop with individual queries) | 2 |
| 12.1.2 | Temporary files (uploads, intermediate results) are cleaned up after processing | 2 |
| 12.1.3 | Concurrency limits are configured and enforced (semaphores, worker pools) | 2 |
| 12.1.4 | Long-running operations are asynchronous and don't block the event loop / main thread | 3 |
| 12.1.5 | Large files are streamed, not loaded entirely into memory | 2 |

### 12.2 Frontend

| # | Item | Weight |
|---|------|--------|
| 12.2.1 | Reactive watchers / subscriptions have proper cleanup (no memory leaks) | 2 |
| 12.2.2 | Event listeners are removed on component unmount | 2 |
| 12.2.3 | API calls have debounce or cancellation where appropriate (search, autocomplete) | 1 |
| 12.2.4 | No excessive re-renders — computed properties / memoization are used over inline functions in templates | 1 |
| 12.2.5 | Heavy assets (images, fonts) are optimized | 1 |

### 12.3 Infrastructure

| # | Item | Weight |
|---|------|--------|
| 12.3.1 | Static file caching is configured (web server / CDN) | 1 |
| 12.3.2 | API responses are reasonably sized (no unnecessary data sent) | 1 |
| 12.3.3 | Health check endpoint is lightweight and doesn't load the system | 1 |

---

## Verification commands

```bash
# 12.1.1 — N+1 pattern (loop with DB query)
grep -rn -A5 "for.*in.*:" PERSISTENCE_PATH --include="*.EXT" | grep -i "select\|fetch\|execute\|query"

# 12.1.4 — Blocking calls in async code
grep -rn "time\.sleep\|Thread\.sleep\|\.block()" SERVICES_PATH --include="*.EXT"

# 12.2.1 + 12.2.2 — Watchers/listeners without cleanup
grep -rn "addEventListener\|watch(\|watchEffect(\|subscribe(" FRONTEND_PATH --include="*.EXT"
grep -rn "removeEventListener\|onUnmounted\|onBeforeUnmount\|useEffect.*return\|unsubscribe" FRONTEND_PATH --include="*.EXT"
```

---

## Scoring rules

- Weight 3 item violated = `[CRIT]` finding
- Weight 2 item violated = `[MAJ]` finding
- Weight 1 item violated = `[MIN]` finding
