# Audit 06 — SOLID

**Objective**: verify adherence to the 5 SOLID principles.

---

## Checklist

### 6.1 S — Single Responsibility Principle

| # | Item | Weight |
|---|------|--------|
| 6.1.1 | Each service/use-case class has a single, well-defined responsibility | 2 |
| 6.1.2 | Each frontend state module (store/slice/signal) manages a single feature | 2 |
| 6.1.3 | API routes are grouped by resource/entity | 1 |
| 6.1.4 | No class or module mixes heterogeneous responsibilities (e.g. parsing + persistence in one class) | 2 |

### 6.2 O — Open/Closed Principle

| # | Item | Weight |
|---|------|--------|
| 6.2.1 | Abstract ports/interfaces allow adding new adapters without modifying existing code | 2 |
| 6.2.2 | Behavior variations (strategies, engines, providers) are extensible via configuration or injection | 2 |
| 6.2.3 | Adding a new feature doesn't require modifying unrelated modules | 1 |

### 6.3 L — Liskov Substitution Principle

| # | Item | Weight |
|---|------|--------|
| 6.3.1 | All implementations of a port/interface are interchangeable (same contract, same return types) | 3 |
| 6.3.2 | Implementations don't throw unexpected exceptions not covered by the contract | 2 |
| 6.3.3 | No `isinstance()` / `typeof` / `type()` checks to differentiate implementations at runtime | 2 |

### 6.4 I — Interface Segregation Principle

| # | Item | Weight |
|---|------|--------|
| 6.4.1 | Interfaces/ports are small and focused — no "god interface" | 2 |
| 6.4.2 | No implementation is forced to define methods it doesn't use | 2 |

### 6.5 D — Dependency Inversion Principle

| # | Item | Weight |
|---|------|--------|
| 6.5.1 | Services depend on abstract ports/interfaces, not concrete implementations | 3 |
| 6.5.2 | Dependency wiring happens in a composition root (entry point / DI container) | 2 |
| 6.5.3 | No direct instantiation of infrastructure adapters inside services | 3 |

---

## Verification commands

```bash
# 6.3.3 — isinstance/typeof checks on adapters
grep -rn "isinstance\|type(\|typeof " SERVICES_PATH/ --include="*.EXT"

# 6.5.3 — Direct instantiation of adapters in services
grep -rn "ADAPTER_CLASS_NAMES" SERVICES_PATH/ --include="*.EXT"

# 6.5.1 — Direct infra imports in services
grep -rn "from INFRA_PATH\|import INFRA_MODULE" SERVICES_PATH/ --include="*.EXT"
```

---

## Scoring rules

- Weight 3 item violated = `[CRIT]` finding
- Weight 2 item violated = `[MAJ]` finding
- Weight 1 item violated = `[MIN]` finding
