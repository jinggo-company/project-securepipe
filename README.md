# project-securepipe

> SecurePipe — 面向企业的 DevSecOps 安全扫描与 SBOM 管理平台

## 状态
- **Phase:** `dev`
- **Project ID:** P-2026-00030
- **Lead Dev:** quanchen

## 概述
SecurePipe 集成 Trivy/Grype 漏洞扫描引擎，提供容器、文件系统、代码依赖的安全扫描，以及 SBOM（软件物料清单）自动生成能力。

## 本地运行
```bash
cd /mnt/d/openworkspace/jinggo-company/company-repos/project-securepipe
./scripts/scan.sh
./scripts/generate-sbom.sh
```
