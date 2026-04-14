# Onboarding

## Pre-requis

| Outil | Version |
|-------|---------|
| Python | 3.12+ |
| Node.js | 22+ |
| Docker + Docker Compose | Latest |
| Git | 2.x |
| Java + Maven | 17+ (pour les E2E Karate) |

## Premiere installation

### 1. Backend

```bash
cd document-parser
python -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt        # Mode remote
pip install -r requirements-local.txt  # Mode local (avec modeles IA)
```

### 2. Frontend

```bash
cd frontend
npm install
```

### 3. Docker (stack complete)

```bash
# Dev avec hot-reload
docker compose -f docker-compose.dev.yml up

# Production-like
docker compose up --build
```

## Lancer le projet

### Sans Docker

```bash
# Terminal 1 — Backend
cd document-parser
source .venv/bin/activate
uvicorn main:app --reload --port 8000

# Terminal 2 — Frontend
cd frontend
npm run dev
```

Acceder a l'app sur `http://localhost:3000` (le frontend proxy `/api` vers le backend sur le port 8000).

### Avec Docker

```bash
docker compose -f docker-compose.dev.yml up
```

## Commandes essentielles a connaitre

| Action | Backend | Frontend |
|--------|---------|----------|
| Lancer | `uvicorn main:app --reload` | `npm run dev` |
| Tests | `pytest tests/ -v` | `npm run test:run` |
| Lint | `ruff check .` | `npm run lint` |
| Format | `ruff format .` | `npm run format` |
| Type-check | — | `npm run type-check` |
| Build | — | `npm run build` |

## Parcours de lecture recommande

1. Ce fichier (installation et commandes)
2. [Architecture backend](../README.md#architecture-backend-hexagonal--ports--adapters) — Comprendre l'hexagonal
3. [Conventions de commit](commit-conventions.md) — Avant ton premier commit
4. [Code review checklist](code-review.md) — Ce qu'on attend dans une PR
5. [Strategie de tests](../quality/testing-strategy.md) — Quoi tester et comment

## Ressources (dans le repo principal Docling Studio)

- `CLAUDE.md` dans chaque sous-projet (`document-parser/`, `frontend/`) : conventions detaillees
- `CONTRIBUTING.md` a la racine : guide de contribution
- `CHANGELOG.md` a la racine : historique des versions
- `docs/` : documentation MkDocs deployee sur GitHub Pages
