# E2E Test Conventions

## Regles d'or

### 1. Jamais de `Thread.sleep()` ou `delay()`

```javascript
// MAL
* delay(3000)
* match response == ...

// BIEN
* retry(10, 1000).get('/api/status')
* match response.status == 'done'
```

### 2. Utiliser `karate.sizeOf()` pour compter les elements

```javascript
// MAL
* def count = locateAll('.item').length

// BIEN
* def count = karate.sizeOf(locateAll('.item'))
```

### 3. Selecteurs `data-e2e` uniquement (pas de classes CSS)

```javascript
// MAL
* click('.btn-primary')

// BIEN
* click('[data-e2e="upload-button"]')
```

### 4. Setup via API, verification via UI

```javascript
// Setup rapide via API
* call read('classpath:common/helpers/upload-document.feature')

// Verification via UI
* driver baseUrl + '/documents'
* waitFor('[data-e2e="document-list"]')
* match text('[data-e2e="document-title"]') == 'test.pdf'

// Cleanup via API
* call read('classpath:common/helpers/cleanup.feature')
```

### 5. `optional()` pour les elements conditionnels

```javascript
// Element qui peut ne pas etre present
* optional('[data-e2e="dismiss-banner"]').click()
```

### 6. Extraire les patterns repetes dans `common/helpers/`

Chaque helper est un `.feature` callable :
- `upload-document.feature` — Upload un PDF de test
- `run-analysis.feature` — Lance une analyse et attend la fin
- `cleanup.feature` — Supprime les donnees de test

## Structure des tests

```
e2e/
  api/
    src/test/resources/
      karate-config.js          # Base URL, timeouts
      common/
        helpers/                # Features reutilisables
        data/
          schemas/              # JSON schemas de validation
          test-cases/           # Donnees de test
          generated/            # PDFs generes
      health/                   # @smoke
      documents/                # @regression
      analyses/                 # @regression
      workflows/                # @e2e
  ui/
    src/test/resources/
      karate-config.js          # URLs, Chrome headless config
      common/helpers/           # Helpers UI
      documents/                # @critical @ui
      analyses/                 # @critical @ui
      navigation/               # @ui
      workflows/                # @ui
```

## Chrome headless (CI)

```javascript
karate.configure('driver', {
  type: 'chrome',
  headless: true,
  addOptions: ['--no-sandbox', '--disable-gpu'],
  screenshotOnFailure: true
});
```
