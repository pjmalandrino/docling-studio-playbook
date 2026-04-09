# Audit 08 — Security

**Objective**: verify absence of common vulnerabilities (OWASP Top 10) and adherence to security best practices.

---

## Checklist

### 8.1 Secrets and credentials

| # | Item | Weight |
|---|------|--------|
| 8.1.1 | No API keys, tokens, or passwords hardcoded in source code | 3 |
| 8.1.2 | Secret files (`.env`, credentials) are listed in `.gitignore` | 3 |
| 8.1.3 | Container secrets are passed via environment variables, not build arguments | 2 |

### 8.2 Input validation

| # | Item | Weight |
|---|------|--------|
| 8.2.1 | All user inputs are validated at the API boundary (schemas, DTOs, form validation) | 3 |
| 8.2.2 | File upload size limits are configured and enforced | 3 |
| 8.2.3 | Accepted file types are validated (no unrestricted file upload) | 2 |

### 8.3 Injection

| # | Item | Weight |
|---|------|--------|
| 8.3.1 | SQL queries use parameterized statements, never string formatting / interpolation | 3 |
| 8.3.2 | No `eval()`, `exec()`, `os.system()`, or equivalent with user-controlled input | 3 |
| 8.3.3 | User-generated HTML/Markdown is sanitized before rendering (DOMPurify, bleach, or equivalent) | 3 |

### 8.4 CORS and network

| # | Item | Weight |
|---|------|--------|
| 8.4.1 | CORS allowed origins are explicitly configured — no wildcard `*` in production | 3 |
| 8.4.2 | Rate limiting is active on public endpoints | 2 |
| 8.4.3 | Web server does not expose directory listings or internal paths | 2 |

### 8.5 Dependencies

| # | Item | Weight |
|---|------|--------|
| 8.5.1 | No dependency with known critical CVEs | 3 |
| 8.5.2 | Dependency versions are pinned (no unbounded `>=` ranges) | 1 |

---

## Verification commands

```bash
# 8.1.1 — Hardcoded secrets
grep -rni "password\s*=\|secret\s*=\|api_key\s*=\|token\s*=" BACKEND_PATH --include="*.EXT" EXCLUDE_FLAGS
grep -rni "password\|secret\|api.key\|token" FRONTEND_PATH --include="*.EXT"

# 8.1.2 — .env in gitignore
grep "\.env" .gitignore

# 8.3.1 — SQL injection via string formatting
grep -rn 'f".*SELECT\|f".*INSERT\|f".*UPDATE\|f".*DELETE' BACKEND_PATH --include="*.EXT" EXCLUDE_FLAGS

# 8.3.2 — Dangerous functions
grep -rn "eval(\|exec(\|os\.system(\|subprocess\.call(\|child_process" BACKEND_PATH FRONTEND_PATH EXCLUDE_FLAGS

# 8.3.3 — HTML sanitization
grep -rn "DOMPurify\|sanitize\|v-html\|innerHTML\|dangerouslySetInnerHTML" FRONTEND_PATH --include="*.EXT"

# 8.4.1 — CORS wildcard
grep -rn 'allow_origins.*\*\|"*"\|cors.*origin.*\*' BACKEND_PATH --include="*.EXT" EXCLUDE_FLAGS

# 8.5.1 — Dependency audit
npm audit --production 2>&1 | tail -10
pip-audit 2>&1 | tail -10
```

---

## Scoring rules

- Weight 3 item violated = `[CRIT]` finding
- Weight 2 item violated = `[MAJ]` finding
- Weight 1 item violated = `[MIN]` finding
