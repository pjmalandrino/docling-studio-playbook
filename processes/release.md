# Release Process

## Etapes

### 1. Creer la branche de release

```bash
git checkout main && git pull
git checkout -b release/X.Y.Z
```

### 2. Sur la branche release (uniquement)

- Bug fixes seulement (pas de nouvelles features)
- Deplacer `[Unreleased]` vers `[X.Y.Z] - YYYY-MM-DD` dans `CHANGELOG.md`
- Mettre a jour `version` dans `package.json`

### 3. Merge vers main via PR

La PR declenche le **[release gate](../ci-cd/release-gate.md)** qui execute :
- Lint backend + frontend
- Tests unitaires backend + frontend
- Build Docker (smoke)
- E2E complets (@smoke + @regression + @e2e)

### 4. Tag sur main

```bash
git checkout main && git pull
git tag vX.Y.Z
git push origin vX.Y.Z
```

### 5. Release automatique (GitHub Actions)

Le push du tag declenche le workflow release ([detail](../ci-cd/release.md)) :

- Build Docker **multi-arch** (linux/amd64 + linux/arm64)
- 2 targets en matrice : `remote` et `local`
- Tags generes automatiquement :
  - `X.Y.Z-remote`, `X.Y-remote`, `latest-remote`
  - `X.Y.Z-local`, `X.Y-local`, `latest-local`
- Push vers `ghcr.io`
- Cache via GitHub Actions cache

## Versioning

- **Semantic Versioning** : MAJOR.MINOR.PATCH
- **Source de verite** : Git tag `vX.Y.Z`
- `package.json` doit matcher la release en cours
- Version injectee automatiquement :
  - Frontend : Vite `__APP_VERSION__` (via `VITE_APP_VERSION`)
  - Backend : variable d'environnement `APP_VERSION`
