# SecurePipe — PRD v1

## 需求概述
SecurePipe 是基于 Trivy/Grype 的安全扫描平台，提供容器镜像扫描、SBOM 生成和多引擎漏洞聚合能力。

## 验收标准 (AC)
- AC-1: Trivy 编译 + 容器镜像扫描验证
- AC-2: Grype 安装 + 依赖包 SBOM 生成（CycloneDX/SPDX）
- AC-6: 多引擎聚合仪表盘基础版 + CNVD/NVD 漏洞数据源接入

## 测试场景

### 场景 1：Trivy 扫描验证
1. 运行 trivy fs --severity HIGH,CRITICAL .
2. 验证漏洞报告输出

### 场景 2：SBOM 生成
1. 运行 generate-sbom.sh
2. 验证 sbom-cyclonedx.json 和 sbom-spdx.json 生成
