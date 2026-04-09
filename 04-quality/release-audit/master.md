# Audit Master

Central reference for release branch quality audits.

This document is the **orchestrator**: it defines the rules, commissions the audits, and normalizes the reports.

---

## 1. Scope

The audit runs on a release branch **after feature freeze**, before the merge to main/production.

The **profile** (see `profiles/`) defines which paths, tools, and commands apply to the target project.

---

## 2. Severity levels

Every finding is classified using one of these 4 levels:

| Level | Tag | Description | Impact on verdict |
|-------|-----|-------------|-------------------|
| **CRITICAL** | `[CRIT]` | Blocking violation — security flaw, data corruption risk, major architecture breach | **Blocking** — release cannot ship |
| **MAJOR** | `[MAJ]` | Significant violation — strong coupling, critical missing test, significant tech debt | Blocking if > 3 unresolved MAJ findings |
| **MINOR** | `[MIN]` | Quality gap — naming, file size, light duplication | Non-blocking — fix in next cycle |
| **INFO** | `[INFO]` | Observation, improvement suggestion, non-respected best practice with no risk | Non-blocking — informational |

---

## 3. Compliance scoring

Each audit produces a **compliance score out of 100**.

### Weights

Every checklist item has a **weight** that maps to severity:

| Weight | Meaning | Violated = |
|--------|---------|------------|
| 3 | Critical — architecture/security invariant | `[CRIT]` finding |
| 2 | Important — design/quality principle | `[MAJ]` finding |
| 1 | Standard — convention/readability | `[MIN]` finding |

### Formula

```
score = (sum of weights of passing items / total weight of all items) * 100
```

### Decision thresholds

| Score | Verdict | Action |
|-------|---------|--------|
| >= 80 | **GO** | Release approved |
| 60 - 79 | **GO CONDITIONAL** | Approved if 0 CRIT, remediation plan for MAJ |
| < 60 | **NO-GO** | Release blocked — fix and re-audit |

**Hard rule**: any unresolved `[CRIT]` finding = **NO-GO** regardless of score.

---

## 4. Audit list

Audits are executed in order. Each is a standalone checklist in `audits/`.

| # | Audit | File | Focus |
|---|-------|------|-------|
| 01 | Clean Architecture | [01-clean-architecture.md](audits/01-clean-architecture.md) | Layer boundaries, dependency flow |
| 02 | DDD | [02-ddd.md](audits/02-ddd.md) | Bounded contexts, entities, value objects, ubiquitous language |
| 03 | Clean Code | [03-clean-code.md](audits/03-clean-code.md) | Naming, size, readability |
| 04 | KISS | [04-kiss.md](audits/04-kiss.md) | Simplicity, no over-engineering |
| 05 | DRY | [05-dry.md](audits/05-dry.md) | Duplication, factorization |
| 06 | SOLID | [06-solid.md](audits/06-solid.md) | 5 SOLID principles |
| 07 | Decoupling | [07-decoupling.md](audits/07-decoupling.md) | Front/back, inter-module, contracts |
| 08 | Security | [08-security.md](audits/08-security.md) | OWASP, secrets, injection, CORS |
| 09 | Tests | [09-tests.md](audits/09-tests.md) | Coverage, quality, e2e |
| 10 | CI / Build | [10-ci-build.md](audits/10-ci-build.md) | Pipeline, containers, health checks |
| 11 | Documentation | [11-documentation.md](audits/11-documentation.md) | Changelog, versioning, dead code |
| 12 | Performance | [12-performance.md](audits/12-performance.md) | N+1, memory, async, resources |

---

## 5. Report format

Each audit produces a report following this structure:

```markdown
# Audit Report: [Audit Name]

**Release**: X.Y.Z
**Date**: YYYY-MM-DD
**Auditor**: [name or "automated"]
**Profile**: [profile name]

---

## Compliance Score

| Metric | Value |
|--------|-------|
| Passing items | XX / YY |
| Score | XX / 100 |
| CRITICAL findings | N |
| MAJOR findings | N |
| MINOR findings | N |
| INFO findings | N |

---

## Findings

### [CRIT] Finding title
- **Location**: `path/to/file.ext:line`
- **Observation**: factual description of what was found
- **Rule violated**: reference to checklist item (e.g. 1.1.1)
- **Remediation**: proposed corrective action

### [MAJ] Finding title
...

### [MIN] Finding title
...

### [INFO] Finding title
...

---

## Positive observations
- ...

---

## Verdict: GO / GO CONDITIONAL / NO-GO
```

---

## 6. Summary report

The summary consolidates all audits into a single dashboard:

```markdown
# Audit Summary — Release X.Y.Z

**Date**: YYYY-MM-DD
**Branch**: release/X.Y.Z
**Profile**: [profile name]

---

## Dashboard

| # | Audit | Score | CRIT | MAJ | MIN | INFO | Verdict |
|---|-------|-------|------|-----|-----|------|---------|
| 01 | Clean Architecture | XX | N | N | N | N | GO |
| 02 | DDD | XX | N | N | N | N | GO |
| ... | ... | ... | ... | ... | ... | ... | ... |

**Global score**: XX / 100 (weighted average)
**Total CRITICAL**: N
**Total MAJOR**: N

---

## All CRITICAL findings

1. [audit name] description — file:line

---

## Final verdict: GO / GO CONDITIONAL / NO-GO

Conditions (if GO CONDITIONAL):
- ...
```

---

## 7. How to run

### Full audit

```
Audit the current release branch following framework/master.md
using the profile profiles/<my-profile>/profile.md
```

### Single audit

```
Run audit framework/audits/02-ddd.md on the current branch
using the profile profiles/<my-profile>/profile.md
```

### Re-audit after fixes

```
Re-audit only CRITICAL and MAJOR findings from the report at
reports/release-X.Y.Z/summary.md
```
