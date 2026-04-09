#!/usr/bin/env bash
# =============================================================================
# Verification commands for the Spring Boot + Angular profile
#
# Usage:
#   cd /path/to/your/project
#   BACKEND=backend FRONTEND=frontend/src \
#     bash /path/to/release-audit-framework/profiles/spring-angular/commands.sh
#
# Environment variables (override as needed):
#   BACKEND   — path to the backend root (default: "backend")
#   FRONTEND  — path to the frontend src dir (default: "frontend/src")
# =============================================================================

set -euo pipefail

BACKEND="${BACKEND:-backend}"
FRONTEND="${FRONTEND:-frontend/src}"
BACKEND_SRC="$BACKEND/src/main/java"
EXCLUDE_BE="--exclude-dir=target --exclude-dir=build --exclude-dir=.gradle"

echo "========================================"
echo "  RELEASE AUDIT — Spring Boot + Angular"
echo "========================================"
echo ""

# --- 01 Clean Architecture ---------------------------------------------------
echo "=== 01 — Clean Architecture ==="

echo "[1.1.1] Domain importing Spring framework:"
grep -rn "import org.springframework\|import javax.persistence\|import jakarta.persistence" "$BACKEND_SRC"/**/domain/ 2>/dev/null || echo "  PASS"

echo "[1.2.1] Services importing controller layer:"
grep -rn "import.*controller\.\|import org.springframework.web" "$BACKEND_SRC"/**/service/ 2>/dev/null || echo "  PASS"

echo "[1.3.1] Controllers importing repository directly:"
grep -rn "import.*repository\.\|import.*Repository" "$BACKEND_SRC"/**/controller/ 2>/dev/null || echo "  PASS"
echo ""

# --- 02 DDD -------------------------------------------------------------------
echo "=== 02 — DDD ==="

echo "[2.1.2] Large domain entity files:"
find "$BACKEND_SRC" -path "*/domain/*.java" | xargs wc -l 2>/dev/null | sort -rn | head -5

echo "[2.5.3] External lib imports leaking to services:"
grep -rn "import com.amazonaws\|import okhttp3\|import org.apache.http" "$BACKEND_SRC"/**/service/ 2>/dev/null || echo "  PASS"
echo ""

# --- 03 Clean Code ------------------------------------------------------------
echo "=== 03 — Clean Code ==="

echo "[3.3.1] Backend files > 300 lines:"
find "$BACKEND_SRC" -name "*.java" | xargs wc -l 2>/dev/null | sort -rn | head -10

echo "[3.3.1] Frontend files > 300 lines:"
find "$FRONTEND" \( -name "*.ts" -o -name "*.html" \) | xargs wc -l 2>/dev/null | sort -rn | head -10

echo "[3.2.3] Methods with > 4 params:"
grep -rn "public.*(.*, .*, .*, .*, .*)" "$BACKEND_SRC" --include="*.java" 2>/dev/null | head -10 || echo "  PASS"
echo ""

# --- 04 KISS ------------------------------------------------------------------
echo "=== 04 — KISS ==="

echo "[4.1.1] Potentially superfluous design patterns:"
grep -rn "class.*Factory\|class.*Strategy\|class.*Observer\|class.*Builder\b" "$BACKEND_SRC" --include="*.java" 2>/dev/null || echo "  PASS"

echo "[4.2.3] Reflection / magic:"
grep -rn "Method\.invoke\|Field\.set\|Constructor\.newInstance\|Proxy\.newProxyInstance" "$BACKEND_SRC" --include="*.java" 2>/dev/null || echo "  PASS"
echo ""

# --- 05 DRY -------------------------------------------------------------------
echo "=== 05 — DRY ==="

echo "[5.1.3] Magic numbers:"
grep -rn "[^a-zA-Z_\"'][0-9]\{3,\}[^a-zA-Z_\"']" "$BACKEND_SRC" --include="*.java" 2>/dev/null | head -20 || echo "  PASS"

echo "[5.2.1] HTTP calls outside centralized client (frontend):"
grep -rn "HttpClient\|fetch(" "$FRONTEND" --include="*.ts" 2>/dev/null | grep -v "http.service\|api.service\|http-client" || echo "  PASS"
echo ""

# --- 06 SOLID -----------------------------------------------------------------
echo "=== 06 — SOLID ==="

echo "[6.1.1] God classes (> 500 lines):"
find "$BACKEND_SRC" -name "*.java" | while read -r f; do
  lines=$(wc -l < "$f")
  [ "$lines" -gt 500 ] && echo "  $f: $lines lines"
done || echo "  PASS"

echo "[6.2.1] Hardcoded switch/if-chains on type:"
grep -rn "instanceof.*if\|switch.*getType\|switch.*getClass" "$BACKEND_SRC" --include="*.java" 2>/dev/null | head -10 || echo "  PASS"
echo ""

# --- 07 Decoupling ------------------------------------------------------------
echo "=== 07 — Decoupling ==="

echo "[7.2.2] Cross-imports between frontend feature modules:"
grep -rn "from.*features/" "$FRONTEND/app/features/" --include="*.ts" 2>/dev/null | grep -v "shared\|index" || echo "  PASS"
echo ""

# --- 08 Security --------------------------------------------------------------
echo "=== 08 — Security ==="

echo "[8.1.1] Hardcoded secrets:"
grep -rni "password\s*=\|secret\s*=\|apiKey\s*=" "$BACKEND_SRC" --include="*.java" 2>/dev/null | grep -v "test" || echo "  PASS"

echo "[8.3.1] SQL injection — string concatenation in queries:"
grep -rn '\".*SELECT.*\" +\|\".*INSERT.*\" +\|\".*UPDATE.*\" +' "$BACKEND_SRC" --include="*.java" 2>/dev/null || echo "  PASS"

echo "[8.3.2] Dangerous APIs:"
grep -rn "Runtime\.getRuntime().exec\|ProcessBuilder\|ScriptEngine" "$BACKEND_SRC" --include="*.java" 2>/dev/null || echo "  PASS"

echo "[8.4.1] CORS wildcard:"
grep -rn 'allowedOrigins.*\*\|@CrossOrigin' "$BACKEND_SRC" --include="*.java" 2>/dev/null || echo "  PASS"
echo ""

# --- 09 Tests -----------------------------------------------------------------
echo "=== 09 — Tests ==="

echo "[9.3.1] Focused tests (fdescribe / fit):"
grep -rn "fdescribe\|fit(" "$FRONTEND" --include="*.spec.ts" 2>/dev/null || echo "  PASS"

echo "[9.3.2] Skipped / disabled tests:"
grep -rn "@Disabled\|@Ignore\|xdescribe\|xit(" "$BACKEND/src/test/" "$FRONTEND" 2>/dev/null || echo "  PASS"
echo ""

# --- 10 CI / Build ------------------------------------------------------------
echo "=== 10 — CI / Build ==="

echo "[10.1.1] Dockerfile health check:"
grep -rn "HEALTHCHECK" Dockerfile* docker-compose*.yml 2>/dev/null || echo "  WARN — no HEALTHCHECK found"
echo ""

# --- 11 Documentation ---------------------------------------------------------
echo "=== 11 — Documentation ==="

echo "[11.1.1] Unreleased section still present:"
grep -n "Unreleased" CHANGELOG.md 2>/dev/null || echo "  PASS (no Unreleased section)"

echo "[11.3.2] Debug console.log in frontend:"
grep -rn "console\.log\|console\.debug" "$FRONTEND" --include="*.ts" 2>/dev/null || echo "  PASS"

echo "[11.3.3] Debug System.out in backend:"
grep -rn "System\.out\.print\|System\.err\.print" "$BACKEND_SRC" --include="*.java" 2>/dev/null || echo "  PASS"
echo ""

# --- 12 Performance -----------------------------------------------------------
echo "=== 12 — Performance ==="

echo "[12.1.1] N+1 suspect — lazy loading without fetch join:"
grep -rn "FetchType\.LAZY" "$BACKEND_SRC" --include="*.java" 2>/dev/null | head -10 || echo "  INFO — check fetch strategies"

echo "[12.3.1] Large payloads — missing pagination:"
grep -rn "findAll()" "$BACKEND_SRC" --include="*.java" 2>/dev/null | grep -v "Pageable\|Page<" | head -5 || echo "  PASS"
echo ""

echo "========================================"
echo "  AUDIT COMPLETE — Review findings above"
echo "========================================"
