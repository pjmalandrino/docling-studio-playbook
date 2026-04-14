# Security Response

> **When to use**: Vulnerability discovered in a dependency, flaw reported by an audit or contributor, or Dependabot/GitHub Advisory alert received.

## Steps

### 1. Assessment

- Determine severity (CVSS if available)
- Identify affected components
- Evaluate exploitability in the project context

### 2. Containment

- If the flaw is exploitable in production: **immediate [rollback](rollback.md)**
- If not immediately exploitable: schedule the fix

### 3. Fix

- Update the vulnerable dependency
- If no patch available: workaround or feature deactivation
- Follow the standard [hotfix](hotfix.md) process

### 4. Verification

- Run the full test suite
- Verify the attack vector is closed
- See [Security checklist](../references/security-checklist.md) for comprehensive checks

### 5. Disclosure

- Update `CHANGELOG.md` with the security mention
- If applicable: coordinate with upstream

## Permanent best practices

- DOMPurify for all dynamic HTML (frontend)
- Input validation at API level
- Rate limiting in place
- No secrets in code (`.env` + `.gitignore`)
- Uploads validated (MIME type, configurable max size)
- See [Security checklist](../references/security-checklist.md) for full reference

## Red flags

- Dependabot alert open for more than 7 days without assessment — triage immediately
- Vulnerability dismissed as "not exploitable" without written justification — document why
- Security fix deployed without running the full test suite — the fix might break something else
- Secret accidentally committed — rotating the secret is mandatory, not just removing the commit
- `npm audit` or `pip-audit` warnings ignored in CI — warnings become vulnerabilities over time

## Anti-rationalizations

| Excuse | Why it doesn't hold |
|--------|---------------------|
| "It's only a dev dependency, not production" | Dev dependencies execute during build. Supply chain attacks target dev deps |
| "The CVSS is low, we can skip it" | CVSS scores are generic. A low CVSS can be critical in your specific context |
| "We'll fix it in the next release" | If it's exploitable, every day of delay is a day of exposure |
| "Nobody targets our project" | Automated scanners don't care about project size. Bots exploit everything |
| "Updating the dependency might break things" | That's what tests are for. A controlled update is better than a forced emergency patch |

## Verification

- [ ] Severity assessed and documented
- [ ] Affected components identified
- [ ] Fix applied (dependency update, workaround, or feature deactivation)
- [ ] Full test suite passes after fix
- [ ] `pip-audit` and `npm audit` clean
- [ ] `CHANGELOG.md` updated with security mention
- [ ] No secrets in git history (if applicable, secret rotated)
