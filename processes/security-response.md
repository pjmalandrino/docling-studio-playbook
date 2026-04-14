# Security Response

## When to activate

- Vulnerability discovered in a dependency
- Flaw reported by an audit or contributor
- Dependabot / GitHub Advisory alert

## Steps

### 1. Assessment

- Determine severity (CVSS if available)
- Identify affected components
- Evaluate exploitability in the project context

### 2. Containment

- If the flaw is exploitable in production: **immediate rollback**
- If not immediately exploitable: schedule the fix

### 3. Fix

- Update the vulnerable dependency
- If no patch available: workaround or feature deactivation
- Follow the standard hotfix process

### 4. Verification

- Run the full test suite
- Verify the attack vector is closed

### 5. Disclosure

- Update `CHANGELOG.md` with the security mention
- If applicable: coordinate with upstream

## Permanent best practices

- DOMPurify for all dynamic HTML (frontend)
- Input validation at API level
- Rate limiting in place
- No secrets in code (`.env` + `.gitignore`)
- Uploads validated (MIME type, configurable max size)
