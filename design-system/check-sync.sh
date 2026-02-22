#!/usr/bin/env bash
# design-system/check-sync.sh
#
# Verifies that consumer CSS files import from the shared design-system.
# Run from the monorepo root.

set -euo pipefail

ERRORS=0
ROOT="$(cd "$(dirname "$0")/.." && pwd)"

check_import() {
  local file="$1"
  local pattern="$2"
  local label="$3"

  if [ ! -f "$file" ]; then
    echo "[WARN] $label: file not found at $file (submodule may not be initialized)"
    return
  fi

  if ! grep -q "$pattern" "$file"; then
    echo "[ERROR] $label: missing @import for design-system"
    echo "  Expected pattern: $pattern"
    echo "  File: $file"
    ERRORS=$((ERRORS + 1))
  else
    echo "[OK] $label"
  fi
}

echo "Checking design-system sync..."
echo ""

check_import \
  "$ROOT/agentsys/site/assets/css/tokens.css" \
  "design-system/tokens.css" \
  "agentsys"

check_import \
  "$ROOT/agent-sh.dev/src/styles/tokens.css" \
  "design-system/tokens.css" \
  "agent-sh.dev"

check_import \
  "$ROOT/agnix/website/src/css/custom.css" \
  "design-system/tokens.css" \
  "agnix"

echo ""
if [ "$ERRORS" -gt 0 ]; then
  echo "[ERROR] $ERRORS consumer(s) out of sync with design-system"
  exit 1
else
  echo "[OK] All consumers are importing from the shared design-system"
fi
