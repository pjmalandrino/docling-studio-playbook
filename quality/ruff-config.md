# Ruff Configuration (Backend Python)

## Config (`pyproject.toml`)

```toml
[tool.ruff]
target-version = "py312"
line-length = 100

[tool.ruff.lint]
select = ["E", "W", "F", "I", "N", "UP", "B", "SIM", "TCH", "RUF"]
ignore = ["E501", "B008", "N815", "TC003"]

[tool.ruff.lint.isort]
known-first-party = ["api", "domain", "persistence", "services"]

[tool.ruff.format]
quote-style = "double"
indent-style = "space"
```

## Enabled rules

| Code | Set | What it covers |
|------|-----|----------------|
| `E` | pycodestyle errors | PEP 8 style errors |
| `W` | pycodestyle warnings | PEP 8 warnings |
| `F` | pyflakes | Unused variables, missing imports |
| `I` | isort | Import sorting |
| `N` | pep8-naming | Naming conventions |
| `UP` | pyupgrade | Python syntax modernization |
| `B` | flake8-bugbear | Common bugs and anti-patterns |
| `SIM` | flake8-simplify | Code simplifications |
| `TCH` | flake8-type-checking | Type-checking-only imports |
| `RUF` | ruff-specific | Ruff's own rules |

## Justified exceptions

| Code | Reason |
|------|--------|
| `E501` | Line length handled by the formatter |
| `B008` | FastAPI `Depends()` in default parameters |
| `N815` | camelCase allowed in Pydantic schemas (frontend DTOs) |
| `TC003` | `datetime` imported at runtime (required by Pydantic) |

## Commands

```bash
ruff check .             # Check
ruff check . --fix       # Auto-fix
ruff format .            # Format
ruff format --check .    # Verify formatting
```

## Full validation pipeline

```bash
ruff check . --fix \
  && ruff format . \
  && ruff check . \
  && ruff format --check . \
  && pytest tests/ -v
```
