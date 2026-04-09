# Audit 01 — Clean Architecture

**Objective**: verify that the codebase respects strict layer boundaries with dependencies flowing inward toward the domain.

---

## Principles

Clean Architecture organizes code in concentric layers:

```
Outer:  Frameworks / Drivers  (HTTP, DB, UI)
        Interface Adapters     (Controllers, Gateways, Presenters)
        Application / Use Cases
Inner:  Domain / Entities      (pure business rules)
```

**The dependency rule**: source code dependencies point **inward only**. The domain layer knows nothing about the outer layers.

---

## Checklist

### 1.1 Domain layer (innermost)

| # | Item | Weight |
|---|------|--------|
| 1.1.1 | The domain layer imports **no framework, ORM, or infrastructure library** | 3 |
| 1.1.2 | Domain models, value objects, and ports perform no I/O (no file, HTTP, or DB operations) | 3 |
| 1.1.3 | All interactions with the outside world are defined as abstract ports/interfaces in the domain | 3 |
| 1.1.4 | Framework-specific DTOs (serialization models) do not leak into the domain | 2 |

### 1.2 Application / Service layer

| # | Item | Weight |
|---|------|--------|
| 1.2.1 | Services do not import HTTP framework types (Request, Response, routing decorators) | 3 |
| 1.2.2 | Services call repositories through abstractions, never raw SQL or ORM queries directly | 3 |
| 1.2.3 | Business rules live in the domain, not in services — services only orchestrate | 2 |
| 1.2.4 | Services receive dependencies via injection, not via direct import of concrete implementations | 2 |

### 1.3 API / Controller layer

| # | Item | Weight |
|---|------|--------|
| 1.3.1 | Controllers/routes do not import the persistence layer directly | 3 |
| 1.3.2 | Serialization/deserialization logic stays in the API layer (DTOs, schemas) | 1 |
| 1.3.3 | Endpoints delegate all logic to the service layer — no business logic in controllers | 2 |

### 1.4 Infrastructure / Adapter layer

| # | Item | Weight |
|---|------|--------|
| 1.4.1 | Each infrastructure adapter implements a domain port/interface | 3 |
| 1.4.2 | Configuration values come from a centralized config module, not hardcoded constants | 2 |

---

## Verification commands

> Adapt paths using your profile's layer mapping.

```bash
# 1.1.1 — Domain must not import infra libs
grep -rn "FRAMEWORK_IMPORTS" DOMAIN_PATH/

# 1.2.1 — Services must not import HTTP framework
grep -rn "FRAMEWORK_IMPORTS" SERVICES_PATH/

# 1.3.1 — API must not import persistence
grep -rn "PERSISTENCE_IMPORTS" API_PATH/

# 1.4.2 — Hardcoded values in infra (outside config)
grep -rn "= ['\"]http\|= [0-9]\{4,\}" INFRA_PATH/ | grep -v config
```

---

## Scoring rules

- Weight 3 item violated = `[CRIT]` finding
- Weight 2 item violated = `[MAJ]` finding
- Weight 1 item violated = `[MIN]` finding
