# Audit 09 — Tests

**Objective**: verify test coverage, quality, and reliability.

---

## Checklist

### 9.1 Execution

| # | Item | Weight |
|---|------|--------|
| 9.1.1 | All backend tests pass | 3 |
| 9.1.2 | All frontend tests pass | 3 |
| 9.1.3 | End-to-end tests pass | 2 |

### 9.2 Coverage

| # | Item | Weight |
|---|------|--------|
| 9.2.1 | Every API endpoint has at least one test (happy path) | 2 |
| 9.2.2 | Error cases for endpoints are tested (400, 404, 413, 429, 500) | 2 |
| 9.2.3 | Services have unit tests covering orchestration logic | 2 |
| 9.2.4 | Domain functions (pure logic, value objects) are tested | 1 |
| 9.2.5 | Critical frontend components have tests (stores, composables, key interactions) | 2 |

### 9.3 Test quality

| # | Item | Weight |
|---|------|--------|
| 9.3.1 | No `.only`, `fdescribe`, `fit`, or equivalent left by accident (focused tests) | 3 |
| 9.3.2 | No `skip` / `pending` / `xdescribe` without a justification comment | 1 |
| 9.3.3 | Tests are deterministic — no dependency on time, network, or execution order | 2 |
| 9.3.4 | Integration tests exercise real flows, not fully mocked chains | 2 |
| 9.3.5 | Assertions are specific (not just `assert result is not None` / `expect(x).toBeTruthy()`) | 1 |
| 9.3.6 | Each test has a descriptive name that explains the behavior being tested | 1 |

---

## Verification commands

```bash
# 9.1.1 — Run backend tests
BACKEND_TEST_COMMAND 2>&1 | tail -30

# 9.1.2 — Run frontend tests
FRONTEND_TEST_COMMAND 2>&1 | tail -30

# 9.3.1 — Focused tests left by accident
grep -rn "\.only\|fdescribe\|fit(" FRONTEND_PATH --include="*.test.*"

# 9.3.2 — Skipped tests without comment
grep -rn -B1 "@pytest.mark.skip\|\.skip(\|xit(\|xdescribe(" BACKEND_TESTS_PATH FRONTEND_PATH

# 9.3.5 — Vague assertions
grep -rn "assert.*is not None$\|assert.*!= None$\|expect.*toBeTruthy()$\|expect.*toBeDefined()$" BACKEND_TESTS_PATH FRONTEND_PATH --include="*.test.*"
```

---

## Scoring rules

- Weight 3 item violated = `[CRIT]` finding
- Weight 2 item violated = `[MAJ]` finding
- Weight 1 item violated = `[MIN]` finding
