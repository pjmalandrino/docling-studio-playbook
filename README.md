# Docling Studio — Developer Playbook

> Mon playbook de developpement complet pour [Docling Studio](https://github.com/scub-france/Docling-Studio), expose par souci de transparence.
> Ce repo documente les processus, outils, workflows et conventions que j'utilise au quotidien.

## A propos de ce playbook

Ce repo ne contient **que les pratiques et processus**. Les fichiers suivants vivent dans le repo principal Docling Studio :
- `CLAUDE.md` — Conventions par sous-projet (dans `document-parser/`, `frontend/`)
- `CONTRIBUTING.md` — Guide de contribution
- `CHANGELOG.md` — Historique des versions
- `docs/` — Documentation complete (MkDocs, deployee sur GitHub Pages)

---

## Par ou commencer ?

### Jour 1 — Installation et premier lancement
1. [Onboarding : pre-requis et installation](processes/onboarding.md)
2. [Lancer le projet](processes/onboarding.md#lancer-le-projet)
3. [Comprendre l'architecture](#architecture-backend-hexagonal--ports--adapters) (Hexagonal, feature-based)

### Premiere semaine — Developper
4. [Conventions de commit](processes/commit-conventions.md) puis [Checklist code review](processes/code-review.md)
5. [Strategie de tests](quality/testing-strategy.md) — Savoir quoi tester et comment
6. [Flux de developpement local](#1-developpement-local) — Lint, format, test avant chaque commit

### Quand j'en ai besoin
- Deployer une release -> [Release](processes/release.md)
- Bug critique en prod -> [Incident](processes/incident-response.md) puis [Hotfix](processes/hotfix.md) ou [Rollback](processes/rollback.md)
- Decision d'architecture -> [ADR](processes/adr.md)
- Comprendre la CI -> [CI Pipeline](ci-cd/ci.md)

---

## Vue d'ensemble

Ce playbook couvre un projet full-stack compose de :

| Couche | Stack | Outils qualite |
|--------|-------|----------------|
| **Backend** | FastAPI + Python 3.12 + aiosqlite | Ruff (lint + format), pytest |
| **Frontend** | Vue 3 + TypeScript (strict) + Vite + Pinia | ESLint 9 (flat config) + Prettier, Vitest |
| **E2E** | Karate (API) + Karate UI (browser) | Maven, Chrome headless |
| **Infra** | Docker multi-target, Nginx, docker-compose | GitHub Actions CI/CD |
| **Docs** | MkDocs Material | GitHub Pages |

---

## Flux existants

### 1. Developpement local

```
Code -> Lint/Format -> Tests unitaires -> Commit (Conventional Commits)
```

**Backend :**
```bash
ruff check . --fix && ruff format .    # Lint + format
ruff check . && ruff format --check .  # Verification
pytest tests/ -v                       # Tests (377+ tests)
```

**Frontend :**
```bash
npm run lint:fix && npm run format     # Lint + format
npm run lint && npm run format:check   # Verification
npm run type-check                     # vue-tsc --noEmit
npm run test:run                       # Vitest (156+ tests)
```

### 2. Pipeline CI (GitHub Actions)

```
PR ouverte
  |
  +-> Backend : ruff check + pytest
  +-> Frontend : eslint + vue-tsc + vitest + vite build
  |
  +-> E2E API (@smoke sur PR, @smoke+@regression+@e2e sur release PR)
  +-> E2E UI (@critical sur main uniquement)
```

### 3. Audit qualite (pre-release)

```
Branche release/* prete
  |
  +-> Phase 1 (parallele) :
  |     Lint + Tests + Audit deps (pip-audit, npm audit) + Audit checks (script 12 axes)
  |
  +-> Phase 2 :
  |     Docker build (remote + local) + Smoke test + Scan Trivy + Check taille image
  |
  +-> Phase 3 :
  |     E2E API (@smoke + @regression + @e2e) + E2E UI (@critical)
  |
  +-> Phase 4 :
        Verdict automatique sur la PR : GO / GO CONDITIONAL / NO-GO
```

**12 axes audites** : Architecture Hexagonale, DDD, Clean Code, KISS, DRY, SOLID, Decouplage, Securite, Tests, CI/Build, Documentation, Performance.

**Scoring** : chaque axe est pondere, score >= 80 = GO, tout `[CRIT]` = NO-GO absolu.

Voir le [detail complet du processus d'audit](processes/audit.md).

### 4. Release

```
main -> release/X.Y.Z -> Audit GO -> merge main -> tag vX.Y.Z
  |
  +-> Docker build multi-arch (amd64 + arm64)
  +-> 2 targets : remote (leger) / local (avec modeles IA)
  +-> Push ghcr.io avec tags semantiques (X.Y.Z, X.Y, latest)
```

### 5. Hotfix

```
tag vX.Y.Z -> hotfix/X.Y.Z+1 -> PR main -> tag vX.Y.Z+1
```

---

## Quel processus utiliser ?

```
Tu as un changement a faire
  |
  +-> C'est une nouvelle feature ou amelioration ?
  |     -> feature/* branch -> PR vers main -> [Commit] [Code Review] [Merge]
  |
  +-> C'est un bug fix non critique ?
  |     -> fix/* branch -> PR vers main -> [Commit] [Code Review] [Merge]
  |
  +-> C'est un bug critique en production ?
  |     +-> Le fix est evident et rapide ?
  |     |     -> [Hotfix] : hotfix/* depuis le tag -> PR main -> tag
  |     +-> Le fix est complexe ou incertain ?
  |           -> [Rollback] d'abord, puis fix en PR normale
  |
  +-> C'est une release ?
  |     -> [Release] : release/* branch -> [Audit] -> merge main -> tag
  |
  +-> C'est une decision d'architecture ?
        -> [ADR] : documenter dans docs/architecture/
```

## Processus disponibles

| # | Processus | Declencheur | Detail |
|---|-----------|-------------|--------|
| 1 | [Commit](processes/commit-conventions.md) | Chaque commit | Conventional Commits strict |
| 2 | [Code Review](processes/code-review.md) | Chaque PR | Checklist structuree |
| 3 | [Merge Policy](processes/merge-policy.md) | PR prete | Regles de merge |
| 4 | [ADR](processes/adr.md) | Decision architecturale | Architecture Decision Records |
| 5 | [**Audit Qualite**](processes/audit.md) | Avant merge release -> main | 12 axes, scoring pondere, CRIT/MAJ/MIN/INFO |
| 6 | [Release](processes/release.md) | Feature freeze | Branch, tag, deploy |
| 7 | [Hotfix](processes/hotfix.md) | Bug critique en prod | Patch rapide |
| 8 | [Rollback](processes/rollback.md) | Incident post-deploy | Retour version precedente |
| 9 | [Incident Response](processes/incident-response.md) | Incident detecte | Triage, resolution, post-mortem |
| 10 | [Security Response](processes/security-response.md) | Vulnerabilite detectee | Evaluation, patch, disclosure |
| 11 | [Onboarding](processes/onboarding.md) | Nouveau contributeur | Guide d'integration |
| 12 | [Issue Triage](processes/issue-triage.md) | Nouvelle issue | Classification et priorisation |

---

## Stack technique detaillee

### Architecture backend (Hexagonal — Ports & Adapters)

```
          ┌─────────────────────────────┐
          │        domain/              │  <- Le coeur (hexagone)
          │  Pure business logic        │     Aucune dependance externe
          │  Models, value objects      │     Ports = interfaces
          └──────────┬──────────────────┘
                     │
       ┌─────────────┼─────────────────────┐
       ▼             ▼                     ▼
   api/          services/          persistence/
   Adapter IN    Orchestration      Adapter OUT
   FastAPI       Use cases          Repository pattern
   Pydantic DTOs                    (aiosqlite)
   (camelCase)
                                    infra/
                                    Adapters OUT
                                    Converters, embeddings,
                                    rate limiter, settings
```

**Principe** : le domaine ne depend de rien. Les adapters (API, persistence, infra) implementent des ports definis par le domaine. On peut remplacer n'importe quel adapter sans toucher au coeur.

### Architecture frontend (Feature-based)

```
src/
  app/         -> Shell applicatif, router, styles globaux
  pages/       -> Pages de route
  features/    -> Modules fonctionnels
    {name}/
      api/     -> Appels HTTP
      store/   -> State Pinia
      ui/      -> Composants Vue
  shared/      -> Utilitaires, types, i18n, http client
```

### Infrastructure Docker

| Target | Contenu | Usage |
|--------|---------|-------|
| `remote` | Backend leger, delegue le parsing via HTTP | Quand un service de conversion externe existe |
| `local` | Backend + modeles IA embarques (PyTorch CPU) | Autonome, tout-en-un |

**Compose stacks :**

| Stack | Fichier | Services |
|-------|---------|----------|
| Production | `docker-compose.yml` | app + nginx |
| Developpement | `docker-compose.dev.yml` | + hot-reload (uvicorn --reload, vite HMR) |
| Ingestion | `docker-compose.ingestion.yml` | + OpenSearch + embedding service |

---

## Configuration qualite

Voir les details dans :

- [Ruff (backend)](quality/ruff-config.md)
- [ESLint + Prettier (frontend)](quality/eslint-prettier-config.md)
- [Testing Strategy](quality/testing-strategy.md)
- [E2E Conventions](quality/e2e-conventions.md)

---

## Claude Code Integration

J'utilise Claude Code comme assistant de developpement. Voir :

- [Claude Code Setup](claude-code/setup.md) — Configuration, CLAUDE.md, permissions
- [Claude Code Workflows](claude-code/workflows.md) — Pipelines de validation automatises

---

## Configuration CI/CD

Voir les details dans :

- [CI Pipeline](ci-cd/ci.md)
- [Release Pipeline](ci-cd/release.md)
- [Release Gate](ci-cd/release-gate.md)

---

## Versioning

- **Semantic Versioning** : MAJOR.MINOR.PATCH
- **Source de verite** : Git tag `vX.Y.Z`
- **Injection automatique** : Vite `__APP_VERSION__` (frontend), `APP_VERSION` env var (backend)
- **Changelog** : `CHANGELOG.md` au format Keep a Changelog
