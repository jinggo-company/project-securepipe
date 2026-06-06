#!/bin/bash
# tests/unit/test-scanners.sh — Unit tests for SecurePipe scanner configs and scripts
set -uo pipefail

PASS=0
FAIL=0
PROJ_ROOT="$(cd "$(dirname "$0")/../.." && pwd)"

check() {
  local desc="$1"
  shift
  if eval "$@" >/dev/null 2>&1; then
    echo "[PASS] $desc"
    PASS=$((PASS+1))
  else
    echo "[FAIL] $desc"
    FAIL=$((FAIL+1))
  fi
}

echo "=== SecurePipe Unit Tests: Script Validation ==="

# scan.sh
check "scan.sh exists and is executable" "[[ -x $PROJ_ROOT/scripts/scan.sh ]]"
check "scan.sh has shebang" "head -1 $PROJ_ROOT/scripts/scan.sh | grep -q '^#!/bin/bash'"
check "scan.sh references trivy" "grep -q 'trivy' $PROJ_ROOT/scripts/scan.sh"
check "scan.sh references grype" "grep -q 'grype' $PROJ_ROOT/scripts/scan.sh"

# generate-sbom.sh
check "generate-sbom.sh exists and is executable" "[[ -x $PROJ_ROOT/scripts/generate-sbom.sh ]]"
check "generate-sbom.sh has shebang" "head -1 $PROJ_ROOT/scripts/generate-sbom.sh | grep -q '^#!/bin/bash'"
check "generate-sbom.sh generates CycloneDX" "grep -q 'cyclone' $PROJ_ROOT/scripts/generate-sbom.sh || grep -q 'CycloneDX' $PROJ_ROOT/scripts/generate-sbom.sh"
check "generate-sbom.sh generates SPDX" "grep -q 'spdx' $PROJ_ROOT/scripts/generate-sbom.sh || grep -q 'SPDX' $PROJ_ROOT/scripts/generate-sbom.sh"

# verify-deployment.sh
check "verify-deployment.sh exists and is executable" "[[ -x $PROJ_ROOT/scripts/verify-deployment.sh ]]"
check "verify-deployment.sh has shebang" "head -1 $PROJ_ROOT/scripts/verify-deployment.sh | grep -q '^#!/bin/bash'"
check "verify-deployment.sh checks scanner configs" "grep -q 'scanners' $PROJ_ROOT/scripts/verify-deployment.sh"

echo ""
echo "=== SecurePipe Unit Tests: YAML Config Validation ==="

# Scanner configs
check "Trivy config exists" "[[ -f $PROJ_ROOT/scanners/trivy/config.yaml ]]"
check "Trivy config is valid YAML" "python3 -c 'import yaml; yaml.safe_load(open(\"$PROJ_ROOT/scanners/trivy/config.yaml\"))' 2>/dev/null"
check "Grype config exists" "[[ -f $PROJ_ROOT/scanners/grype/config.yaml ]]"
check "Grype config is valid YAML" "python3 -c 'import yaml; yaml.safe_load(open(\"$PROJ_ROOT/scanners/grype/config.yaml\"))' 2>/dev/null"

echo ""
echo "=== Results: $PASS passed, $FAIL failed ==="

if [ "$FAIL" -gt 0 ]; then
  exit 1
fi
exit 0
