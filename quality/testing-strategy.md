# Testing Strategy

## Pyramide de tests

```
        /  E2E UI  \          <- Karate UI (@critical, @ui)
       / E2E API    \         <- Karate API (@smoke, @regression, @e2e)
      / Integration   \       <- pytest, Vitest (composants + stores)
     /   Unit tests     \     <- pytest, Vitest (fonctions pures)
    /____________________\
```

## Backend (pytest)

| Categorie | Fichiers | Couverture |
|-----------|----------|------------|
| Endpoints API | `test_api_endpoints.py`, `test_ingestion_api.py` | Routes, validation, erreurs HTTP |
| Services | `test_analysis_service.py`, `test_document_service.py`, `test_ingestion_service.py` | Orchestration, jobs async |
| Domain | `test_models.py`, `test_schemas.py`, `test_bbox.py`, `test_chunking.py` | Logique metier pure |
| Persistence | `test_repos.py` | CRUD repository |
| Infra | `test_serve_converter.py`, `test_embedding_client.py`, `test_opensearch_store.py` | Adapters externes |
| Config | `test_settings.py`, `test_pipeline_options.py` | Chargement config |
| Resilience | `test_robustness.py`, `test_rate_limiter.py` | Cas limites, erreurs |

**Config** : `pytest.ini` avec `asyncio_mode = auto` (tout est async par defaut)

**Commandes** :
```bash
pytest tests/ -v                    # Tous les tests
pytest tests/test_analysis_service.py -v  # Un fichier
pytest tests/ -v -k "test_upload"   # Par nom
```

## Frontend (Vitest)

- Tests colocates avec le code source (`*.test.ts`)
- Framework : Vitest (compatible Jest API)
- Mocker integre pour les mocks

**Commandes** :
```bash
npm run test:run    # Single run (CI)
npm run test        # Watch mode (dev)
```

## E2E API (Karate)

| Tag | Scope | Duree | Quand |
|-----|-------|-------|-------|
| `@smoke` | Health checks | ~30s | Chaque PR |
| `@regression` | Couverture API complete | ~2min | PR vers release |
| `@e2e` | Workflows cross-domain | ~5min | PR vers release |

```bash
mvn test -f e2e/api/pom.xml -Dkarate.options="--tags @smoke"
```

## E2E UI (Karate UI)

| Tag | Scope | Duree | Quand |
|-----|-------|-------|-------|
| `@critical` | 5 parcours coeur | ~1.5min | CI sur main |
| `@ui` | Toutes les features UI | ~3min | Dev local |

```bash
mvn test -f e2e/ui/pom.xml -Dkarate.options="--tags @critical"
```

## Donnees de test

```bash
python e2e/generate-test-data.py    # Genere les PDFs de test (a lancer une fois)
```
