#!/usr/bin/env bash
# =============================================================================
# Verification commands for the Django + React profile
#
# Usage:
#   cd /path/to/your/project
#   BACKEND=backend FRONTEND=frontend/src \
#     bash /path/to/release-audit-framework/profiles/django-react/commands.sh
#
# Environment variables (override as needed):
#   BACKEND   — path to the backend root (default: "backend")
#   FRONTEND  — path to the frontend src dir (default: "frontend/src")
# =============================================================================

set -euo pipefail

BACKEND="${BACKEND:-backend}"
FRONTEND="${FRONTEND:-frontend/src}"
EXCLUDE_BE="--exclude-dir=.venv --exclude-dir=__pycache__ --exclude-dir=migrations --exclude-dir=tests"

echo "========================================"
echo "  RELEASE AUDIT — Django + React"
echo "========================================"
echo ""

# --- 01 Clean Architecture ---------------------------------------------------
echo "=== 01 — Clean Architecture ==="

echo "[1.1.1] Domain importing Django ORM / DRF:"
grep -rn "from django.db\|from rest_framework\|import django" "$BACKEND/*/domain/" 2>/dev/null || echo "  PASS"

echo "[1.2.1] Services importing DRF views:"
grep -rn "from rest_framework.views\|from rest_framework.decorators\|from django.http" "$BACKEND/*/services/" "$BACKEND/*/services.py" 2>/dev/null || echo "  PASS"

echo "[1.3.1] Views importing ORM directly (bypassing services):"
grep -rn "\.objects\.\|from.*models import" "$BACKEND/*/views.py" 2>/dev/null | grep -v "serializers" || echo "  PASS"
echo ""

# --- 02 DDD -------------------------------------------------------------------
echo "=== 02 — DDD ==="

echo "[2.1.2] Large model files:"
find "$BACKEND" -name "models.py" -not -path "*/.venv/*" | xargs wc -l 2>/dev/null | sort -rn | head -5

echo "[2.5.3] External lib imports leaking to services:"
grep -rn "import requests\|from requests\|import boto3\|from boto3" "$BACKEND/*/services/" "$BACKEND/*/services.py" 2>/dev/null || echo "  PASS"
echo ""

# --- 03 Clean Code ------------------------------------------------------------
echo "=== 03 — Clean Code ==="

echo "[3.3.1] Backend files > 300 lines:"
find "$BACKEND" -name "*.py" -not -path "*/.venv/*" -not -path "*/__pycache__/*" -not -path "*/migrations/*" | xargs wc -l 2>/dev/null | sort -rn | head -10

echo "[3.3.1] Frontend files > 300 lines:"
find "$FRONTEND" \( -name "*.tsx" -o -name "*.ts" \) | xargs wc -l 2>/dev/null | sort -rn | head -10

echo "[3.2.3] Functions with > 4 params:"
grep -rn "def .*,.*,.*,.*,.*," "$BACKEND" --include="*.py" $EXCLUDE_BE 2>/dev/null || echo "  PASS"
echo ""

# --- 04 KISS ------------------------------------------------------------------
echo "=== 04 — KISS ==="

echo "[4.1.1] Potentially superfluous design patterns:"
grep -rn "class.*Factory\|class.*Strategy\|class.*Observer\|class.*Builder\|class.*Singleton" "$BACKEND" --include="*.py" $EXCLUDE_BE 2>/dev/null || echo "  PASS"

echo "[4.2.3] Metaprogramming / magic:"
grep -rn "__metaclass__\|type(.*,.*,.*)\|__init_subclass__" "$BACKEND" --include="*.py" $EXCLUDE_BE 2>/dev/null || echo "  PASS"
echo ""

# --- 05 DRY -------------------------------------------------------------------
echo "=== 05 — DRY ==="

echo "[5.1.3] Magic numbers (backend):"
grep -rn "[^a-zA-Z_\"'][0-9]\{3,\}[^a-zA-Z_\"']" "$BACKEND" --include="*.py" $EXCLUDE_BE 2>/dev/null | head -20 || echo "  PASS"

echo "[5.2.1] HTTP calls outside centralized client (frontend):"
grep -rn "fetch(\|axios\." "$FRONTEND" --include="*.ts" --include="*.tsx" 2>/dev/null | grep -v "api.ts\|client.ts\|httpClient\|apiClient" || echo "  PASS"
echo ""

# --- 06 SOLID -----------------------------------------------------------------
echo "=== 06 — SOLID ==="

echo "[6.1.1] God classes (> 500 lines):"
find "$BACKEND" -name "*.py" -not -path "*/.venv/*" -not -path "*/__pycache__/*" -not -path "*/migrations/*" | while read -r f; do
  lines=$(wc -l < "$f")
  [ "$lines" -gt 500 ] && echo "  $f: $lines lines"
done || echo "  PASS"

echo "[6.2.1] Hardcoded switch/if-chains on type:"
grep -rn "if.*type.*==\|isinstance.*if\|match.*case" "$BACKEND" --include="*.py" $EXCLUDE_BE 2>/dev/null | head -10 || echo "  PASS"
echo ""

# --- 07 Decoupling ------------------------------------------------------------
echo "=== 07 — Decoupling ==="

echo "[7.2.2] Cross-imports between frontend features:"
grep -rn "from.*features/" "$FRONTEND/features/" --include="*.ts" --include="*.tsx" 2>/dev/null | grep -v "__tests__" || echo "  PASS"
echo ""

# --- 08 Security --------------------------------------------------------------
echo "=== 08 — Security ==="

echo "[8.1.1] Hardcoded secrets:"
grep -rni "password\s*=\|secret\s*=\|api_key\s*=" "$BACKEND" --include="*.py" $EXCLUDE_BE 2>/dev/null || echo "  PASS"

echo "[8.3.1] SQL injection via raw queries / f-strings:"
grep -rn "raw(\|extra(\|f\".*SELECT\|f\".*INSERT" "$BACKEND" --include="*.py" $EXCLUDE_BE 2>/dev/null || echo "  PASS"

echo "[8.3.2] Dangerous functions:"
grep -rn "eval(\|exec(\|os\.system(" "$BACKEND" --include="*.py" $EXCLUDE_BE 2>/dev/null || echo "  PASS"

echo "[8.4.1] CORS wildcard:"
grep -rn "CORS_ALLOW_ALL_ORIGINS\s*=\s*True\|allow_origins.*\*" "$BACKEND" --include="*.py" $EXCLUDE_BE 2>/dev/null || echo "  PASS"
echo ""

# --- 09 Tests -----------------------------------------------------------------
echo "=== 09 — Tests ==="

echo "[9.3.1] Focused tests (.only / fit / fdescribe):"
grep -rn "\.only\|fdescribe\|fit(" "$FRONTEND" --include="*.test.*" 2>/dev/null || echo "  PASS"

echo "[9.3.2] Skipped tests:"
grep -rn "@pytest.mark.skip\|@unittest.skip\|\.skip(" "$BACKEND" "$FRONTEND" 2>/dev/null || echo "  PASS"
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
grep -rn "console\.log\|console\.debug" "$FRONTEND" --include="*.ts" --include="*.tsx" 2>/dev/null || echo "  PASS"

echo "[11.3.3] Debug print() in backend:"
grep -rn "^\s*print(" "$BACKEND" --include="*.py" $EXCLUDE_BE 2>/dev/null || echo "  PASS"
echo ""

# --- 12 Performance -----------------------------------------------------------
echo "=== 12 — Performance ==="

echo "[12.1.1] N+1 suspect — queries in loops:"
grep -rn "for.*:\s*$" -A5 "$BACKEND" --include="*.py" $EXCLUDE_BE 2>/dev/null | grep -i "\.objects\.\|query\|select\|fetch" || echo "  PASS"

echo "[12.3.1] Missing select_related / prefetch_related:"
grep -rn "\.objects\.all()\|\.objects\.filter(" "$BACKEND" --include="*.py" $EXCLUDE_BE 2>/dev/null | grep -v "select_related\|prefetch_related" | head -10 || echo "  PASS"
echo ""

echo "========================================"
echo "  AUDIT COMPLETE — Review findings above"
echo "========================================"
