# ESLint + Prettier Configuration (Frontend Vue/TypeScript)

## ESLint (Flat Config v9+)

```javascript
// eslint.config.js — Structure
- Recommended JS rules
- TypeScript rules (@typescript-eslint)
- Vue plugin rules

// Key rules
"no-console": "warn"           // allow: ['warn', 'error']
"no-debugger": "error"
"no-unused-vars": "off"        // handled by TypeScript
"@typescript-eslint/no-unused-vars": "error"  // ignore ^_ prefix
"@typescript-eslint/no-explicit-any": "off"
"vue/multi-word-component-names": "off"
// Vue formatting rules disabled (Prettier handles them)
```

**Philosophy**: ESLint for logic, Prettier for formatting. No conflicts between the two.

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

## Commands

```bash
npm run lint              # Check ESLint
npm run lint:fix          # Fix ESLint
npm run format            # Format with Prettier
npm run format:check      # Verify Prettier
```

## Full validation pipeline

```bash
npm run lint:fix \
  && npm run format \
  && npm run lint \
  && npm run format:check \
  && npm run type-check \
  && npm run test:run
```

## TypeScript

- **Strict** mode enabled
- `vue-tsc --noEmit` for type checking
- Path alias: `@/` -> `src/`
