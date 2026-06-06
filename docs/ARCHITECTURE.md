# ARCHITECTURE.md — SecurePipe 架构设计

## 模块概览

```
┌─────────────────────────────────────────────────┐
│                  SecurePipe                      │
├────────────┬──────────────┬─────────────────────┤
│  Trivy     │  Grype       │  SBOM Engine        │
│  Scanner   │  Scanner     │                     │
│            │              │                     │
│ • Image    │ • SBOM       │ • CycloneDX JSON    │
│   scanning │   gen        │ • SPDX XML          │
│ • FS       │ • Vulnerab.  │ • License inventory │
│   scanning │   matching   │                     │
│ • Config   │ • Severity   │                     │
│   audit    │   filtering  │                     │
└────────────┴──────────────┴─────────────────────┘
```

## PRD AC 映射

| AC | 架构覆盖 | 实现位置 |
|----|----------|----------|
| AC-1 | Trivy/Grype 扫描引擎集成 | scanners/, scripts/scan.sh |
| AC-3 | SBOM 自动生成 | sbom/, scripts/generate-sbom.sh |
