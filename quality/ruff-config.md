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

## Regles activees

| Code | Set | Ce que ca couvre |
|------|-----|-----------------|
| `E` | pycodestyle errors | Erreurs de style PEP 8 |
| `W` | pycodestyle warnings | Avertissements PEP 8 |
| `F` | pyflakes | Variables inutilisees, imports manquants |
| `I` | isort | Tri des imports |
| `N` | pep8-naming | Conventions de nommage |
| `UP` | pyupgrade | Modernisation syntaxe Python |
| `B` | flake8-bugbear | Bugs courants et anti-patterns |
| `SIM` | flake8-simplify | Simplifications de code |
| `TCH` | flake8-type-checking | Imports type-checking-only |
| `RUF` | ruff-specific | Regles propres a Ruff |

## Exceptions justifiees

| Code | Raison |
|------|--------|
| `E501` | Longueur de ligne geree par le formateur |
| `B008` | FastAPI `Depends()` dans les parametres par defaut |
| `N815` | camelCase autorise dans les schemas Pydantic (DTOs frontend) |
| `TC003` | `datetime` importe au runtime (requis par Pydantic) |

## Commandes

```bash
ruff check .             # Verifier
ruff check . --fix       # Corriger automatiquement
ruff format .            # Formater
ruff format --check .    # Verifier le formatage
```

## Pipeline de validation complete

```bash
ruff check . --fix \
  && ruff format . \
  && ruff check . \
  && ruff format --check . \
  && pytest tests/ -v
```
