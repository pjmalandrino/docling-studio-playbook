# Code Review Checklist

## Before submitting the PR

- [ ] Branch named correctly (`feature/`, `fix/`, `hotfix/`)
- [ ] Commits follow Conventional Commits
- [ ] Tests added/updated
- [ ] All tests pass
- [ ] Linting passes (ruff / eslint)
- [ ] `CHANGELOG.md` updated
- [ ] Documentation updated if needed
- [ ] No secrets committed

## Review points

### Functional
- Feature does what is requested
- Edge cases are handled
- Behavior is consistent with the rest of the app

### Technical
- Respects hexagonal architecture (domain depends on nothing, adapters implement ports)
- No duplication of business logic
- DTOs are properly separated from domain models
- Errors are handled cleanly (no silent `pass`)

### Security
- DOMPurify for all dynamic HTML (frontend)
- Input validation at API level
- No hardcoded secrets
- Uploads are validated (type, size)

### Performance
- No N+1 queries
- Heavy operations are async
- Rate limiting is in place

## PR template

Every PR uses the standardized template with:
- Type (Feature, Bug fix, Hotfix, Documentation, Refactoring, CI/CD)
- Summary in 1-3 sentences
- Related issues
- Validation checklist
- Screenshots/evidence if applicable
