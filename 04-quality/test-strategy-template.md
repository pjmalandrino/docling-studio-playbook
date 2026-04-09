# Test Strategy — <!-- REPLACE: Project Name -->

## Overview

<!-- REPLACE: 2-3 sentences on the project's testing philosophy -->

## Test pyramid

| Level | Framework | Location | Runs in CI? | Target coverage |
|-------|-----------|----------|-------------|-----------------|
| Unit | <!-- REPLACE --> | <!-- REPLACE --> | Yes | <!-- REPLACE: e.g. 80% --> |
| Integration | <!-- REPLACE --> | <!-- REPLACE --> | Yes | <!-- REPLACE --> |
| E2E | <!-- REPLACE --> | <!-- REPLACE --> | <!-- REPLACE --> | <!-- REPLACE --> |

## What to test

### Must test (non-negotiable)

- Domain logic and business rules
- API contracts (request/response shapes, status codes)
- Authentication and authorization flows
- Data validation and edge cases

### Should test

- Error handling paths
- Database queries (integration tests)
- External service interactions (via mocks or stubs)

### Optional

- UI layout and visual regressions
- Performance benchmarks
- Accessibility

## What NOT to test

- Framework internals (trust your framework)
- Trivial getters/setters
- Third-party library behavior
- Implementation details that change often

## Environments

| Environment | Database | External services | Purpose |
|-------------|----------|-------------------|---------|
| Local | <!-- REPLACE --> | Mocked | Development |
| CI | <!-- REPLACE --> | Mocked | PR validation |
| Staging | <!-- REPLACE --> | Real | Pre-release validation |

## Test data

<!-- REPLACE: describe how test data is managed (fixtures, factories, seeds, etc.) -->

## Running tests

```bash
# Unit tests
<!-- REPLACE -->

# Integration tests
<!-- REPLACE -->

# E2E tests
<!-- REPLACE -->

# All tests
<!-- REPLACE -->
```

## Coverage

- Tool: <!-- REPLACE: e.g. coverage.py, istanbul, jacoco -->
- Minimum threshold: <!-- REPLACE: e.g. 80% -->
- Enforced in CI: <!-- REPLACE: Yes/No -->
