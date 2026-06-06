#!/bin/bash
# generate-sbom.sh — Generate SBOM (CycloneDX + SPDX)
set -euo pipefail

OUTPUT_DIR="sbom"
mkdir -p "$OUTPUT_DIR"

echo "[SecurePipe] Generating SBOM..."

# CycloneDX JSON
echo "[SecurePipe] Generating CycloneDX JSON..."
if command -v grype &>/dev/null; then
  grype dir:. -o cyclonedx-json > "$OUTPUT_DIR/sbom-cyclonedx.json" 2>/dev/null || echo "[WARN] Grype not available for CycloneDX"
fi

# SPDX
echo "[SecurePipe] Generating SPDX..."
if command -v trivy &>/dev/null; then
  trivy fs --format spdx-json . > "$OUTPUT_DIR/sbom-spdx.json" 2>/dev/null || echo "[WARN] Trivy not available for SPDX"
fi

echo "[SecurePipe] SBOM generated in $OUTPUT_DIR/"
ls -la "$OUTPUT_DIR/" 2>/dev/null || true
