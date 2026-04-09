# Audit 11 — Documentation & Changelog

**Objective**: verify that the release is properly documented and versioned.

---

## Checklist

### 11.1 Changelog

| # | Item | Weight |
|---|------|--------|
| 11.1.1 | The `[Unreleased]` section has been moved to `[X.Y.Z] - YYYY-MM-DD` | 3 |
| 11.1.2 | All significant changes in the release are listed in the changelog | 2 |
| 11.1.3 | Breaking changes are clearly identified | 3 |
| 11.1.4 | Changelog format follows [Keep a Changelog](https://keepachangelog.com/) or the project's convention | 1 |

### 11.2 Versioning

| # | Item | Weight |
|---|------|--------|
| 11.2.1 | Version numbers are updated in all relevant files (package.json, pyproject.toml, etc.) | 2 |
| 11.2.2 | Versioning follows Semantic Versioning (or the project's declared scheme) | 2 |

### 11.3 Clean source

| # | Item | Weight |
|---|------|--------|
| 11.3.1 | Remaining `TODO` / `FIXME` are intentional and documented (no orphan TODOs) | 1 |
| 11.3.2 | No debug `console.log` / `console.debug` left in frontend production code | 2 |
| 11.3.3 | No debug `print()` / `puts` / `System.out.println` left in backend production code (structured logging is fine) | 2 |

---

## Verification commands

```bash
# 11.1.1 — Unreleased section still present
grep -n "Unreleased" CHANGELOG.md

# 11.2.1 — Version in package files
grep '"version"' package.json frontend/package.json 2>/dev/null
grep 'version' pyproject.toml setup.cfg 2>/dev/null

# 11.3.1 — Remaining TODOs
grep -rn "TODO\|FIXME\|HACK\|XXX" BACKEND_PATH --include="*.EXT" EXCLUDE_FLAGS
grep -rn "TODO\|FIXME\|HACK\|XXX" FRONTEND_PATH --include="*.EXT"

# 11.3.2 — Debug console statements (frontend)
grep -rn "console\.log\|console\.debug" FRONTEND_PATH --include="*.EXT"

# 11.3.3 — Debug print statements (backend)
grep -rn "^\s*print(" BACKEND_PATH --include="*.EXT" EXCLUDE_FLAGS
```

---

## Scoring rules

- Weight 3 item violated = `[CRIT]` finding
- Weight 2 item violated = `[MAJ]` finding
- Weight 1 item violated = `[MIN]` finding
