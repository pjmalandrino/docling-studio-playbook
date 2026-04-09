# Profile: Spring Boot + Angular

Stack: Java Spring Boot backend + Angular / TypeScript frontend.

---

## Layer mapping

| Generic layer | Concrete path | Notes |
|---------------|---------------|-------|
| Domain | `backend/src/main/java/**/domain/` | Entities, value objects, repository interfaces |
| Services | `backend/src/main/java/**/service/` | Use case orchestration |
| API | `backend/src/main/java/**/controller/` | REST controllers, DTOs |
| Infrastructure | `backend/src/main/java/**/infra/` or `**/adapter/` | External service clients, config |
| Persistence | `backend/src/main/java/**/repository/` | Spring Data JPA implementations |
| Entry point | `backend/src/main/java/**/Application.java` | Spring Boot main + bean config |
| Frontend features | `frontend/src/app/features/` | One folder per feature module |
| Frontend shared | `frontend/src/app/shared/` | Cross-feature services, models, pipes |
| Tests backend | `backend/src/test/` | JUnit 5 + Mockito |
| Tests frontend | `frontend/src/**/*.spec.ts` | Jasmine / Karma / Jest |
| Tests e2e | `frontend/e2e/` or `e2e/` | Protractor, Cypress, Playwright |

## File extensions

| Layer | Extensions |
|-------|-----------|
| Backend | `*.java`, `*.kt` |
| Frontend | `*.ts`, `*.html` |

## Exclude patterns

```bash
--exclude-dir=target --exclude-dir=build --exclude-dir=.gradle
--exclude-dir=node_modules --exclude-dir=dist
```

## Tools

| Tool | Command |
|------|---------|
| Backend build + test | `cd backend && ./mvnw clean verify` or `./gradlew build` |
| Backend lint | SpotBugs, Checkstyle, or SonarQube |
| Frontend lint | `cd frontend && npx ng lint` |
| Frontend type check | `cd frontend && npx tsc --noEmit` |
| Frontend tests | `cd frontend && npx ng test --watch=false` |
| E2E tests | `cd frontend && npx ng e2e` |
| Docker build | `docker compose build` |

## Framework-specific imports to detect

```bash
# Domain should not import Spring
FRAMEWORK_IMPORTS="import org.springframework\|import javax.persistence\|import jakarta.persistence"

# Services should not import controller layer
HTTP_FRAMEWORK_IMPORTS="import.*controller\.\|import org.springframework.web"

# Controllers should not import repository directly
PERSISTENCE_IMPORTS="import.*repository\.\|import.*Repository"
```
