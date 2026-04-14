# Commit Conventions

Convention : **Conventional Commits**

## Format

```
<type>(<scope>): <description>

[optional body]

[optional footer(s)]
```

## Types

| Type | Usage |
|------|-------|
| `feat` | Nouvelle fonctionnalite |
| `fix` | Correction de bug |
| `docs` | Documentation uniquement |
| `style` | Formatage (pas de changement de logique) |
| `refactor` | Restructuration sans changement fonctionnel |
| `test` | Ajout ou modification de tests |
| `chore` | Dependencies, tooling, config |
| `perf` | Amelioration de performance |
| `ci` | Changements CI/CD |

## Scopes utilises

`api`, `domain`, `persistence`, `infra`, `upload`, `analysis`, `chunking`, `bbox`, `e2e`, `docker`, `ci`

## Regles

1. Imperatif, minuscule, pas de point final, max 72 caracteres
2. Le body explique le **pourquoi**, pas le **quoi**
3. Breaking changes : footer `BREAKING CHANGE:` ou `!` apres le type
4. References issues : `Closes #123`, `Fixes #456`

## Exemples

```
feat(analysis): add batch progress tracking

Track conversion progress per page and emit SSE events
to update the frontend in real-time.

Closes #87
```

```
fix(api): prevent duplicate upload when file already exists

The upload endpoint was creating a new entry even when a file
with the same hash existed. Now returns 409 Conflict.
```

```
refactor(persistence)!: migrate from JSON files to aiosqlite

BREAKING CHANGE: data directory structure has changed,
existing uploads require migration.
```
