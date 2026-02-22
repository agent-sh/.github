#!/usr/bin/env bash
# design-system/check-sync.sh
#
# Verifies that consumer CSS files import from the shared design-system.
# ROOT is resolved relative to this script's location, not the caller's cwd.

set -euo pipefail

ERRORS=0
ROOT="$(cd "$(dirname "$0")/.." && pwd)"

check_import() {
  local file="$1"
  local pattern="$2"
  local label="$3"

  if [ ! -f "$file" ]; then
    echo "[ERROR] $label: file not found at $file"
    ERRORS=$((ERRORS + 1))
    return
  fi

  if ! grep -qE "^@import.*$pattern" "$file"; then
    echo "[ERROR] $label: missing active @import for $pattern"
    echo "  File: $file"
    ERRORS=$((ERRORS + 1))
  else
    echo "[OK] $label: $pattern"
  fi
}

echo "Checking design-system sync..."
echo ""

# All consumers must import tokens.css
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

# Non-Docusaurus consumers must import base.css
check_import \
  "$ROOT/agentsys/site/assets/css/tokens.css" \
  "design-system/base.css" \
  "agentsys (base)"

check_import \
  "$ROOT/agent-sh.dev/src/styles/tokens.css" \
  "design-system/base.css" \
  "agent-sh.dev (base)"

# Docusaurus consumers must import the bridge
check_import \
  "$ROOT/agnix/website/src/css/custom.css" \
  "design-system/tokens-docusaurus.css" \
  "agnix (docusaurus bridge)"

echo ""
if [ "$ERRORS" -gt 0 ]; then
  echo "[ERROR] $ERRORS check(s) failed"
  exit 1
else
  echo "[OK] All consumers are importing from the shared design-system"
fi
