# CI Pipeline

## Declencheurs

- **Push** sur `main`
- **PR** vers `main` ou `release/**`

Concurrency : annule les runs precedents sur la meme branche/PR.

## Jobs

### Backend (ubuntu-latest, Python 3.12)

```yaml
steps:
  - Checkout
  - Setup Python 3.12
  - Install poppler-utils (systeme, pour pdf2image)
  - pip install requirements.txt + pytest + pytest-asyncio + httpx + ruff
  - ruff check .                    # Lint
  - pytest tests/ -v                # Tests
```

### Frontend (ubuntu-latest, Node 22)

```yaml
steps:
  - Checkout
  - Setup Node 22
  - npm ci                          # Install deterministe
  - npx eslint src/                 # Lint
  - npm run type-check              # vue-tsc
  - npm run test:run                # Vitest
  - npm run build                   # Vite build
```

### E2E API (Karate)

```yaml
needs: [backend, frontend]          # Attend que les 2 passent
steps:
  - Generate test PDFs
  - Start docker stack
  - Wait for health endpoint (30s retry)
  - mvn test avec tags:
    - @smoke sur PR vers main
    - @smoke,@regression,@e2e sur PR vers release
  - Upload reports (artifacts)
```

### E2E UI (Karate UI)

```yaml
# Uniquement sur main (pas sur chaque PR)
steps:
  - Setup Chrome headless
  - Generate test PDFs
  - Start docker stack
  - mvn test -Dkarate.options="--tags @critical"
  - Upload reports (artifacts)
```

## Matrice de quand quoi tourne

| Evenement | Backend | Frontend | E2E API | E2E UI |
|-----------|---------|----------|---------|--------|
| PR -> main | lint + tests | lint + types + tests + build | @smoke | — |
| PR -> release | lint + tests | lint + types + tests + build | @smoke + @regression + @e2e | — |
| Push main | lint + tests | lint + types + tests + build | @smoke | @critical |
