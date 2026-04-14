# ESLint + Prettier Configuration (Frontend Vue/TypeScript)

## ESLint (Flat Config v9+)

```javascript
// eslint.config.js — Structure
- Recommended JS rules
- TypeScript rules (@typescript-eslint)
- Vue plugin rules

// Regles cles
"no-console": "warn"           // allow: ['warn', 'error']
"no-debugger": "error"
"no-unused-vars": "off"        // gere par TypeScript
"@typescript-eslint/no-unused-vars": "error"  // ignore ^_ prefix
"@typescript-eslint/no-explicit-any": "off"
"vue/multi-word-component-names": "off"
// Regles de formatage Vue desactivees (Prettier gere)
```

**Philosophie** : ESLint pour la logique, Prettier pour le formatage. Aucun conflit entre les deux.

## Prettier

```json
{
  "semi": false,
  "singleQuote": true,
  "trailingComma": "all",
  "printWidth": 100,
  "tabWidth": 2,
  "arrowParens": "always",
  "vueIndentScriptAndStyle": false
}
```

## Commandes

```bash
npm run lint              # Verifier ESLint
npm run lint:fix          # Corriger ESLint
npm run format            # Formater Prettier
npm run format:check      # Verifier Prettier
```

## Pipeline de validation complete

```bash
npm run lint:fix \
  && npm run format \
  && npm run lint \
  && npm run format:check \
  && npm run type-check \
  && npm run test:run
```

## TypeScript

- Mode **strict** active
- `vue-tsc --noEmit` pour la verification de types
- Path alias : `@/` -> `src/`
