# Testing Strategy

## Test pyramid

```
        /  E2E UI  \          <- Karate UI (@critical, @ui)
       / E2E API    \         <- Karate API (@smoke, @regression, @e2e)
      / Integration   \       <- pytest, Vitest (components + stores)
     /   Unit tests     \     <- pytest, Vitest (pure functions)
    /____________________\
```

## Backend (pytest)

| Category | Files | Coverage |
|----------|-------|----------|
| API endpoints | `test_api_endpoints.py`, `test_ingestion_api.py` | Routes, validation, HTTP errors |
| Services | `test_analysis_service.py`, `test_document_service.py`, `test_ingestion_service.py` | Orchestration, async jobs |
| Domain | `test_models.py`, `test_schemas.py`, `test_bbox.py`, `test_chunking.py` | Pure business logic |
| Persistence | `test_repos.py` | Repository CRUD |
| Infra | `test_serve_converter.py`, `test_embedding_client.py`, `test_opensearch_store.py` | External adapters |
| Config | `test_settings.py`, `test_pipeline_options.py` | Configuration loading |
| Resilience | `test_robustness.py`, `test_rate_limiter.py` | Edge cases, error handling |

**Config**: `pytest.ini` with `asyncio_mode = auto` (everything is async by default)

**Commands**:
```bash
pytest tests/ -v                    # All tests
pytest tests/test_analysis_service.py -v  # Single file
pytest tests/ -v -k "test_upload"   # By name
```

## Frontend (Vitest)

- Tests colocated with source code (`*.test.ts`)
- Framework: Vitest (Jest API compatible)
- Built-in mocker for mocks

**Commands**:
```bash
npm run test:run    # Single run (CI)
npm run test        # Watch mode (dev)
```

## E2E API (Karate)

| Tag | Scope | Duration | When |
|-----|-------|----------|------|
| `@smoke` | Health checks | ~30s | Every PR |
| `@regression` | Full API coverage | ~2min | PR to release |
| `@e2e` | Cross-domain workflows | ~5min | PR to release |

```bash
mvn test -f e2e/api/pom.xml -Dkarate.options="--tags @smoke"
```

## E2E UI (Karate UI)

| Tag | Scope | Duration | When |
|-----|-------|----------|------|
| `@critical` | 5 core journeys | ~1.5min | CI on main |
| `@ui` | All UI features | ~3min | Local dev |

```bash
mvn test -f e2e/ui/pom.xml -Dkarate.options="--tags @critical"
```

## Test data

```bash
python e2e/generate-test-data.py    # Generate test PDFs (run once)
```
