# Security Response

## Quand activer

- Vulnerabilite decouverte dans une dependance
- Faille signalee par un audit ou un contributeur
- Alerte Dependabot / GitHub Advisory

## Etapes

### 1. Evaluation

- Determiner la severite (CVSS si disponible)
- Identifier les composants affectes
- Evaluer l'exploitabilite dans le contexte du projet

### 2. Containment

- Si la faille est exploitable en production : **rollback immediat**
- Si non exploitable immediatement : planifier le fix

### 3. Fix

- Mettre a jour la dependance vulnerable
- Si pas de patch disponible : workaround ou desactivation de la feature
- Suivre le processus hotfix standard

### 4. Verification

- Lancer la suite de tests complete
- Verifier que le vecteur d'attaque est ferme

### 5. Disclosure

- Mettre a jour le `CHANGELOG.md` avec la mention de securite
- Si applicable : coordonner avec l'upstream

## Bonnes pratiques permanentes

- DOMPurify pour tout HTML dynamique (frontend)
- Validation des inputs au niveau API
- Rate limiting en place
- Pas de secrets dans le code (`.env` + `.gitignore`)
- Uploads valides (type MIME, taille max configurable)
