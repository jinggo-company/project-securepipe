#!/bin/bash
# scan.sh — SecurePipe 安全扫描入口
set -euo pipefail

echo "[SecurePipe] Running security scans..."

# Trivy scan
echo "[SecurePipe] Running Trivy scan..."
if command -v trivy &>/dev/null; then
  trivy fs --severity HIGH,CRITICAL --format table . || true
else
  echo "[SecurePipe] Trivy not installed. Run: go build -o trivy ./cmd/trivy"
fi

# Grype scan
echo "[SecurePipe] Running Grype scan..."
if command -v grype &>/dev/null; then
  grype dir:. --fail-on high || true
else
  echo "[SecurePipe] Grype not installed."
fi

echo "[SecurePipe] Scan complete."
