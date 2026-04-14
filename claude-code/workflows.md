# Claude Code Workflows

## Pipelines de validation automatises

Claude Code suit les pipelines definis dans les `CLAUDE.md` de chaque sous-projet. Voici les deux pipelines principaux :

### Backend — Validation complete

```bash
# 1. Fix automatique
ruff check . --fix
ruff format .

# 2. Verification stricte
ruff check .
ruff format --check .

# 3. Tests
pytest tests/ -v
```

Ce pipeline est execute **avant chaque commit** cote backend.

### Frontend — Validation complete

```bash
# 1. Fix automatique
npm run lint:fix
npm run format

# 2. Verification stricte
npm run lint
npm run format:check

# 3. Type-check
npm run type-check

# 4. Tests
npm run test:run
```

Ce pipeline est execute **avant chaque commit** cote frontend.

## Workflow typique d'une feature

1. **Comprendre** — Claude Code lit le code existant, les tests, les specs
2. **Implementer** — Code backend et/ou frontend
3. **Valider** — Execute le pipeline de validation du sous-projet concerne
4. **Tester visuellement** — Lance le dev server (launch.json) et verifie dans le navigateur
5. **Commiter** — Conventional Commits avec scope appropriee

## Conventions respectees par Claude Code

- **Clean Architecture** : pas de fuite de couche (domain ne depend de rien)
- **DTOs separes** : Pydantic schemas (camelCase) != modeles domaine
- **Feature-based** : chaque feature frontend dans son dossier avec api/, store/, ui/
- **Tests colocates** : `*.test.ts` a cote du code source
- **DOMPurify** : tout HTML dynamique est sanitise
- **No console.log** : uniquement `console.warn` et `console.error`
