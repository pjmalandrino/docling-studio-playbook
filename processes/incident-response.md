# Incident Response

## Severite

| Niveau | Critere | Temps de reponse |
|--------|---------|-----------------|
| **P1 - Critique** | Service down, perte de donnees | Immediat |
| **P2 - Majeur** | Feature principale cassee | < 4h |
| **P3 - Mineur** | Feature secondaire degradee | < 24h |
| **P4 - Cosmetique** | UI glitch, message d'erreur | Prochain sprint |

## Workflow

### 1. Detection et triage

- Identifier la severite
- Assigner un responsable
- Communiquer le statut

### 2. Investigation

- Consulter les logs applicatifs
- Verifier les metriques (si monitoring en place)
- Reproduire le probleme en local si possible

### 3. Resolution

- **P1** : Rollback immediat si le fix n'est pas evident
- **P2-P3** : Hotfix suivant le processus standard
- **P4** : Issue creee, planifiee dans le backlog

### 4. Post-mortem

Pour tout incident P1/P2 :

```markdown
## Post-mortem : [Titre]

### Timeline
- HH:MM — Detection
- HH:MM — Investigation demarree
- HH:MM — Cause identifiee
- HH:MM — Fix deploye
- HH:MM — Confirmation resolution

### Cause racine
...

### Impact
- Duree : X heures
- Utilisateurs affectes : ...

### Actions correctives
- [ ] Fix technique
- [ ] Test supplementaire
- [ ] Amelioration monitoring
```
