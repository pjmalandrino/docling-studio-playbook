# E2E Test Conventions

## Golden rules

### 1. Never use `Thread.sleep()` or `delay()`

```javascript
// BAD
* delay(3000)
* match response == ...

// GOOD
* retry(10, 1000).get('/api/status')
* match response.status == 'done'
```

### 2. Use `karate.sizeOf()` to count elements

```javascript
// BAD
* def count = locateAll('.item').length

// GOOD
* def count = karate.sizeOf(locateAll('.item'))
```

### 3. `data-e2e` selectors only (no CSS classes)

```javascript
// BAD
* click('.btn-primary')

// GOOD
* click('[data-e2e="upload-button"]')
```

### 4. Setup via API, verify via UI

```javascript
// Fast setup via API
* call read('classpath:common/helpers/upload-document.feature')

// Verify via UI
* driver baseUrl + '/documents'
* waitFor('[data-e2e="document-list"]')
* match text('[data-e2e="document-title"]') == 'test.pdf'

// Cleanup via API
* call read('classpath:common/helpers/cleanup.feature')
```

### 5. `optional()` for conditional elements

```javascript
// Element that may not be present
* optional('[data-e2e="dismiss-banner"]').click()
```

### 6. Extract repeated patterns into `common/helpers/`

Each helper is a callable `.feature`:
- `upload-document.feature` — Upload a test PDF
- `run-analysis.feature` — Run an analysis and wait for completion
- `cleanup.feature` — Delete test data

## Test structure

```
e2e/
  api/
    src/test/resources/
      karate-config.js          # Base URL, timeouts
      common/
        helpers/                # Reusable features
        data/
          schemas/              # JSON validation schemas
          test-cases/           # Test data
          generated/            # Generated PDFs
      health/                   # @smoke
      documents/                # @regression
      analyses/                 # @regression
      workflows/                # @e2e
  ui/
    src/test/resources/
      karate-config.js          # URLs, Chrome headless config
      common/helpers/           # UI helpers
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
