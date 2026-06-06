# TECH_STACK.md — SecurePipe 技术栈

## 核心技术

| 组件 | 版本 | 说明 |
|------|------|------|
| Trivy | 0.50+ | 综合安全扫描器（核心） |
| Grype | 0.75+ | SBOM 与漏洞扫描 |
| Go | 1.21+ | 编译语言 |
| Docker Compose | 2.20+ | 容器化部署 |
| CycloneDX | 1.4 | SBOM 格式标准 |

## 扫描类型
- 容器镜像扫描
- 文件系统扫描
- 代码依赖扫描
- 许可证检查
- 配置审计

## SBOM 生成
- 格式: CycloneDX JSON + SPDX
- 输出: sbom/ 目录

## 数据源
- CNVD: RSS 订阅（6 小时同步）
- NVD: REST API v2.0（4 小时增量同步）
- 数据存储: data/ 目录（JSON/XML）

## 仪表盘
- 技术: 纯 HTML/CSS/JS，无外部依赖
- 功能: 多引擎聚合概览、按来源标签、CVSS 评分展示
