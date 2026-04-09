# Audit Report: [AUDIT_NAME]

**Release**: X.Y.Z
**Date**: YYYY-MM-DD
**Auditor**: [name or "automated"]
**Profile**: [profile name]

---

## Compliance Score

> **How to calculate**: score = (sum of weights of passing items / sum of weights of all items) × 100.
> "Passing items" counts items, "Score" uses weights. See `framework/master.md` §3 for details.

| Metric | Value |
|--------|-------|
| Passing items (count) | XX / YY |
| Score (weighted) | XX / 100 |
| CRITICAL findings | 0 |
| MAJOR findings | 0 |
| MINOR findings | 0 |
| INFO findings | 0 |

---

## Findings

<!-- Copy one block per finding, ordered by severity (CRIT first, then MAJ, MIN, INFO) -->

### [CRIT] Finding title

- **Location**: `path/to/file.ext:line`
- **Observation**: Factual description of what was found.
- **Rule violated**: Checklist item reference (e.g. 1.1.1)
- **Remediation**: Proposed corrective action.

### [MAJ] Finding title

- **Location**: `path/to/file.ext:line`
- **Observation**: ...
- **Rule violated**: ...
- **Remediation**: ...

### [MIN] Finding title

- **Location**: `path/to/file.ext:line`
- **Observation**: ...
- **Rule violated**: ...
- **Remediation**: ...

### [INFO] Finding title

- **Location**: `path/to/file.ext:line`
- **Observation**: ...
- **Rule violated**: ...
- **Remediation**: ...

---

## Positive observations

- ...
- ...

---

## Verdict

<!-- One of: GO / GO CONDITIONAL / NO-GO -->

**GO**
