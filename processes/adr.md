# Architecture Decision Records (ADR)

## Quand ecrire un ADR

- Choix de technologie ou framework
- Changement de pattern architectural
- Decision ayant un impact transverse
- Trade-off significatif entre options

## Template

```markdown
# ADR-XXX : Titre de la decision

## Statut
Propose | Accepte | Deprecie | Remplace par ADR-YYY

## Contexte
Quel probleme ou besoin a declenche cette decision ?

## Decision
Quelle solution a ete retenue ?

## Consequences
### Positives
- ...

### Negatives
- ...

### Risques
- ...

## Alternatives considerees
1. **Option A** — Description, pourquoi ecartee
2. **Option B** — Description, pourquoi ecartee
```

## Convention de nommage

- Fichier : `docs/architecture/adr-XXX-titre-court.md`
- Numerotation sequentielle
- Titre court en kebab-case

## Exemples de decisions documentees

- Choix de l'architecture hexagonale (ports & adapters)
- Choix de aiosqlite vs PostgreSQL
- Choix de Karate pour les E2E
- Double target Docker (remote/local)
