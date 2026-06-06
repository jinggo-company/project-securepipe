#!/bin/bash
# verify-deployment.sh — SecurePipe 部署验证
set -uo pipefail

PASS=0
FAIL=0

check() {
  local desc="$1"
  shift
  if eval "$@"; then
    echo "[PASS] $desc"
    PASS=$((PASS+1))
  else
    echo "[FAIL] $desc"
    FAIL=$((FAIL+1))
  fi
}

echo "=========================================="
echo " SecurePipe Deployment Verification"
echo "=========================================="

check "Trivy config exists" "[[ -f scanners/trivy/config.yaml ]]"
check "Grype config exists" "[[ -f scanners/grype/config.yaml ]]"
check "Scan script exists" "[[ -f scripts/scan.sh ]]"
check "SBOM script exists" "[[ -f scripts/generate-sbom.sh ]]"

echo "=========================================="
echo " Results: $PASS passed, $FAIL failed"
echo "=========================================="

[ "$FAIL" -gt 0 ] && exit 1
exit 0
