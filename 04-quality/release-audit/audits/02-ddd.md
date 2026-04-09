# Audit 02 — Domain-Driven Design (DDD)

**Objective**: verify that the code reflects DDD principles — clear bounded contexts, well-defined entities and value objects, consistent ubiquitous language, and protected domain invariants.

---

## Principles

DDD places the **domain model** at the center of the software. The code should speak the language of the business, not the language of the framework.

---

## Checklist

### 2.1 Bounded Contexts

| # | Item | Weight |
|---|------|--------|
| 2.1.1 | Business contexts are clearly identified and isolated (each context has its own module/package) | 3 |
| 2.1.2 | Each context owns its models — no "god object" shared across contexts | 3 |
| 2.1.3 | Communication between contexts uses explicit contracts (DTOs, events, API calls), not direct imports of another context's internals | 2 |
| 2.1.4 | Frontend modules mirror backend bounded contexts (feature = context) | 2 |

### 2.2 Entities and Value Objects

| # | Item | Weight |
|---|------|--------|
| 2.2.1 | Entities have a unique identity (`id`) and a lifecycle | 2 |
| 2.2.2 | Value objects are immutable and defined by their attributes, not by identity | 2 |
| 2.2.3 | Value objects contain no persistence logic (`save()`, `update()`, `delete()`) | 3 |
| 2.2.4 | Entities are not anemic data bags — they carry domain behavior where appropriate | 1 |

### 2.3 Ubiquitous Language

| # | Item | Weight |
|---|------|--------|
| 2.3.1 | Vocabulary is consistent across domain, services, API, and frontend (same concept = same word everywhere) | 2 |
| 2.3.2 | Class/function/variable names reflect business language, not generic tech terms (`DataProcessor`, `Handler`, `Manager` without context) | 1 |
| 2.3.3 | Business statuses use explicit, domain-meaningful names | 1 |

### 2.4 Aggregates and invariants

| # | Item | Weight |
|---|------|--------|
| 2.4.1 | Each aggregate has a clear root entity | 2 |
| 2.4.2 | Domain invariants are protected inside the domain — impossible to create invalid state from the outside | 3 |
| 2.4.3 | Modifications to an aggregate go through its root, not by directly manipulating internal components | 2 |

### 2.5 Repositories and anti-corruption

| # | Item | Weight |
|---|------|--------|
| 2.5.1 | Repositories manipulate domain entities, not raw dicts, rows, or ORM objects | 2 |
| 2.5.2 | An anti-corruption layer (DTOs, mappers) transforms external data into domain objects | 2 |
| 2.5.3 | Infrastructure adapters do not leak their internal library types to the service layer | 3 |

---

## Verification commands

> Adapt paths and terms using your profile.

```bash
# 2.1.2 — Check for oversized domain models
wc -l DOMAIN_MODELS_PATH

# 2.3.1 — Vocabulary inconsistencies (example: "job" vs "task" vs "analysis")
grep -rni "\bTERM_A\b" BACKEND_PATH/ --include="*.EXT" | grep -v "EXPECTED_CLASS"
grep -rni "\bTERM_A\b" FRONTEND_PATH/ --include="*.EXT"

# 2.5.3 — Library types leaking to services
grep -rn "from LIBRARY\|import LIBRARY" SERVICES_PATH/
```

---

## Scoring rules

- Weight 3 item violated = `[CRIT]` finding
- Weight 2 item violated = `[MAJ]` finding
- Weight 1 item violated = `[MIN]` finding
