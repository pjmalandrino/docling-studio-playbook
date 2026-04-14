# Docker Infrastructure

## Multi-target Dockerfile

The project uses a single Dockerfile with two targets:

### Target `remote` (lightweight)

- Python 3.12-slim
- FastAPI backend delegates parsing to an external service via HTTP
- Frontend build (Vite) served by Nginx
- System deps: poppler-utils, nginx

### Target `local` (standalone)

- Everything `remote` includes, plus:
- Full Docling with embedded AI models
- PyTorch CPU
- Additional system deps: libgl1, libglib2.0-0
- `CONVERSION_ENGINE=local`

### Build

```bash
docker build --target remote -t app:remote .
docker build --target local -t app:local .
```

## Docker Compose stacks

### Production (`docker-compose.yml`)

| Service | Role | Port |
|---------|------|------|
| `app` | FastAPI backend | 8000 (internal) |
| `frontend` | Nginx serving Vite build | 3000:80 |

### Development (`docker-compose.dev.yml`)

| Service | Role | Specifics |
|---------|------|-----------|
| `app` | Backend with `uvicorn --reload` | Hot-reload, volume bind mount |
| `frontend` | Vite dev server (HMR) | Hot-reload, volume bind mount |
| `opensearch-dashboards` | Index inspection UI | Port 5601 |

### Ingestion (`docker-compose.ingestion.yml`)

Additional overlay to enable vector search:

| Service | Role | Port |
|---------|------|------|
| `opensearch` | Vector search engine | 9200 |
| `embedding` | Sentence-transformers service | 8001 |

**Launch with ingestion:**
```bash
docker compose --profile ingestion \
  -f docker-compose.yml \
  -f docker-compose.ingestion.yml \
  up --build
```

## Environment variables

| Variable | Default | Description |
|----------|---------|-------------|
| `CONVERSION_MODE` | `remote` | Docker target (remote/local) |
| `CONVERSION_ENGINE` | `remote` | Runtime conversion engine |
| `CONVERSION_TIMEOUT` | `900` | Timeout per conversion (sec) |
| `MAX_CONCURRENT_ANALYSES` | `3` | Max parallel jobs |
| `MAX_FILE_SIZE_MB` | `50` | Max upload size |
| `MAX_PAGE_COUNT` | `0` | PDF page limit (0 = unlimited) |
| `RATE_LIMIT_RPM` | `100` | Requests per minute per IP |
| `CORS_ORIGINS` | — | Allowed origins |
| `UPLOAD_DIR` | `./uploads` | Uploads directory |
| `DB_PATH` | `./data/app.db` | SQLite database path |
| `OPENSEARCH_URL` | — | OpenSearch URL (optional) |
| `EMBEDDING_URL` | — | Embedding service URL (optional) |
| `EMBEDDING_MODEL` | `all-MiniLM-L6-v2` | Embedding model |
| `EMBEDDING_DIMENSION` | `384` | Vector dimension |
