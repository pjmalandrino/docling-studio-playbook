# Audit Qualite

## Vue d'ensemble

Framework d'audit complet avec **12 axes**, chacun etant une checklist ponderee.
L'audit est execute avant chaque merge de branche `release/*` vers `main`.

## Les 12 axes d'audit

| # | Axe | Focus |
|---|-----|-------|
| 01 | **Clean Architecture** | Separation des couches (API/domain/service/infra), pas de fuite |
| 02 | **DDD** | Bounded contexts, value objects, ubiquitous language |
| 03 | **Clean Code** | Nommage, taille de fichiers, lisibilite |
| 04 | **KISS** | Simplicite, pas d'over-engineering |
| 05 | **DRY** | Detection de duplication, magic numbers |
| 06 | **SOLID** | Les 5 principes SOLID |
| 07 | **Decouplage** | Frontend/backend, contrats, ports & adapters |
| 08 | **Securite** | OWASP, secrets, injection, CORS |
| 09 | **Tests** | Couverture, qualite, determinisme, E2E |
| 10 | **CI / Build** | Pipeline, Docker health checks |
| 11 | **Documentation** | CHANGELOG, TODOs avec refs issues |
| 12 | **Performance** | Requetes N+1, async I/O, memoire |

## Modes d'invocation

| Mode | Quand | Resultat |
|------|-------|----------|
| **Full Release Audit** | Avant merge release -> main | 12 rapports + summary |
| **Single Audit** | Check cible sur un axe | 1 rapport |
| **Re-Audit** | Apres correction de CRIT/MAJ | Rapport mis a jour |
| **Automated Checks** | Validation rapide pre-audit | PASS/WARN/FAIL par axe |

## Niveaux de criticite

| Tag | Signification | Impact |
|-----|---------------|--------|
| `[CRIT]` | Bloquant (securite, corruption de donnees, violation architecture majeure) | **NO-GO absolu** |
| `[MAJ]` | Significatif (couplage fort, gap de test critique) | A corriger avant release |
| `[MIN]` | Gap qualite (nommage, taille fichier) | Amelioration recommandee |
| `[INFO]` | Observation / piste d'amelioration | Informatif |

## Scoring

### Calcul par axe

```
score = (somme des poids des items OK / poids total) * 100
```

### Seuils de decision

| Score | Verdict | Condition |
|-------|---------|-----------|
| >= 80 | **GO** | Tous les checks passent |
| 60-79 | **GO CONDITIONAL** | 0 CRIT + plan de remediation pour les MAJ |
| < 60 | **NO-GO** | Corrections obligatoires |

**Regle absolue** : tout `[CRIT]` = **NO-GO**, quel que soit le score.

## Automated Checks (script)

Script bash qui execute les verifications automatisables pour les 12 axes :

```bash
# Ce que le script verifie :
- Domain layer : pas d'imports interdits (FastAPI, SQLite, etc.)
- Taille des fichiers : warning > 300 lignes
- Magic numbers : detection de valeurs en dur
- Secrets : scan de patterns (password, token, secret)
- SQL injection : detection de patterns dangereux
- CORS : configuration presente
- Tests : fichiers de test existants pour chaque module
- Documentation : CHANGELOG.md et README.md presents
- Requetes N+1 : detection de patterns suspects

# Sortie
- PASS (vert) / WARN (jaune) / FAIL (rouge) par check
- Exit code 1 si au moins un FAIL
```

## Integration CI/CD (Release Gate)

Le release gate execute l'audit en 4 phases :

### Phase 1 — Checks paralleles (bloquant)

- Lint & type-check (ruff, ESLint, vue-tsc)
- Tests unitaires (pytest, Vitest)
- **Audit des dependances** (`pip-audit` + `npm audit`) — bloquant sur CRITICAL
- **Audit checks** (script automatise) — bloquant

### Phase 2 — Docker (bloquant)

- Build Docker (targets remote + local)
- Smoke test (`/api/health`)
- **Scan d'image Trivy** — bloquant sur CRITICAL, warning sur HIGH
- Check de taille d'image (delta vs precedente)

### Phase 3 — E2E

- E2E API (scope complet : @smoke + @regression + @e2e)
- E2E UI (@critical uniquement)

### Phase 4 — Verdict

Commentaire automatique sur la PR avec verdict :

| Verdict | Signification |
|---------|---------------|
| **GO** | Tous les checks passent |
| **GO CONDITIONAL** | Bloquants OK, mais warnings sur deps/audit |
| **NO-GO** | Au moins un check bloquant echoue |

## Rapports

### Structure

```
docs/audit/
  master.md                          # Document d'orchestration central
  audits/
    01-clean-architecture.md         # Template checklist
    02-ddd.md
    03-clean-code.md
    ...
    12-performance.md
  reports/
    release-X.Y.Z/
      01-clean-architecture.md       # Rapport rempli
      02-ddd.md
      ...
      12-performance.md
      summary.md                     # Synthese + verdict final
```

### Contenu d'un rapport

Chaque rapport individuel contient :
- Table de score de conformite
- Findings par severite (CRIT/MAJ/MIN/INFO)
- Points positifs
- Verdict partiel (GO/CONDITIONAL/NO-GO)

Le **summary** consolide :
- Les 12 scores
- Le score pondere global
- Les PRs de remediation mergees
- Les issues MAJ restantes (priorisees pour le cycle suivant)
- Le **verdict final**

## Exemple reel

Release 0.3.1 :
- 12 audits executes
- Score initial variable (56-100 selon les axes)
- Score final : 95/100 (pondere)
- 5 PRs de remediation mergees
- 2 issues MAJOR restantes (planifiees cycle suivant)
- **Verdict : GO**
