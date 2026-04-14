# Infrastructure Docker

## Dockerfile multi-target

Le projet utilise un seul Dockerfile avec deux targets :

### Target `remote` (leger)

- Python 3.12-slim
- Backend FastAPI qui delegue le parsing a un service externe via HTTP
- Frontend build (Vite) servi par Nginx
- Deps systeme : poppler-utils, nginx

### Target `local` (autonome)

- Tout ce que `remote` inclut, plus :
- Docling complet avec modeles IA embarques
- PyTorch CPU
- Deps systeme supplementaires : libgl1, libglib2.0-0
- `CONVERSION_ENGINE=local`

### Build

```bash
docker build --target remote -t app:remote .
docker build --target local -t app:local .
```

## Docker Compose Stacks

### Production (`docker-compose.yml`)

| Service | Role | Port |
|---------|------|------|
| `app` | Backend FastAPI | 8000 (interne) |
| `frontend` | Nginx servant le build Vite | 3000:80 |

### Developpement (`docker-compose.dev.yml`)

| Service | Role | Specifite |
|---------|------|-----------|
| `app` | Backend avec `uvicorn --reload` | Hot-reload, volume bind mount |
| `frontend` | Vite dev server (HMR) | Hot-reload, volume bind mount |
| `opensearch-dashboards` | UI d'inspection des index | Port 5601 |

### Ingestion (`docker-compose.ingestion.yml`)

Overlay additionnel pour activer la recherche vectorielle :

| Service | Role | Port |
|---------|------|------|
| `opensearch` | Moteur de recherche vectorielle | 9200 |
| `embedding` | Service sentence-transformers | 8001 |

**Lancement avec ingestion :**
```bash
docker compose --profile ingestion \
  -f docker-compose.yml \
  -f docker-compose.ingestion.yml \
  up --build
```

## Variables d'environnement

| Variable | Default | Description |
|----------|---------|-------------|
| `CONVERSION_MODE` | `remote` | Target Docker (remote/local) |
| `CONVERSION_ENGINE` | `remote` | Moteur de conversion runtime |
| `CONVERSION_TIMEOUT` | `900` | Timeout par conversion (sec) |
| `MAX_CONCURRENT_ANALYSES` | `3` | Jobs paralleles max |
| `MAX_FILE_SIZE_MB` | `50` | Taille max upload |
| `MAX_PAGE_COUNT` | `0` | Limite pages PDF (0 = illimite) |
| `RATE_LIMIT_RPM` | `100` | Requetes par minute par IP |
| `CORS_ORIGINS` | — | Origines autorisees |
| `UPLOAD_DIR` | `./uploads` | Dossier uploads |
| `DB_PATH` | `./data/app.db` | Chemin base SQLite |
| `OPENSEARCH_URL` | — | URL OpenSearch (optionnel) |
| `EMBEDDING_URL` | — | URL service embedding (optionnel) |
| `EMBEDDING_MODEL` | `all-MiniLM-L6-v2` | Modele d'embedding |
| `EMBEDDING_DIMENSION` | `384` | Dimension des vecteurs |
