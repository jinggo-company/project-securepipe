# project-securepipe

> SecurePipe — 面向中国企业的 CI/CD 软件供应链安全平台（基于 Trivy/Grype）

## 状态
- **Phase:** `ready` (产品验收)
- **Project ID:** P-2026-00030
- **Lead Dev:** quanchen

## 概述
SecurePipe 集成 Trivy/Grype 漏洞扫描引擎，提供容器、文件系统、代码依赖的安全扫描，以及 SBOM（软件物料清单）自动生成能力。支持等保 2.0 合规报告自动生成、CI/CD 流水线集成、CNVD/NVD 中文漏洞数据源同步。

## 快速安装（Trivy + Grype）

### 安装 Trivy
```bash
# 方式 1：使用官方安装脚本
curl -sfL https://raw.githubusercontent.com/aquasecurity/trivy/main/contrib/install.sh | sh -s -- -b /usr/local/bin

# 方式 2：手动下载（推荐国内用户）
# 使用代理或从 Gitee 镜像获取二进制
curl -sfL https://gh-proxy.com/https://github.com/aquasecurity/trivy/releases/download/v0.71.0/trivy_0.71.0_linux-64bit.tar.gz -o trivy.tar.gz
tar xzf trivy.tar.gz trivy
chmod +x trivy
sudo mv trivy /usr/local/bin/
```

### 安装 Grype
```bash
# 方式 1：使用官方安装脚本
curl -sSfL https://raw.githubusercontent.com/anchore/grype/main/install.sh | sh -s -- -b /usr/local/bin

# 方式 2：手动下载（推荐国内用户）
curl -sfL https://gh-proxy.com/https://github.com/anchore/grype/releases/download/v0.114.0/grype_0.114.0_linux_amd64.tar.gz -o grype.tar.gz
tar xzf grype.tar.gz grype
chmod +x grype
sudo mv grype /usr/local/bin/
```

### 验证安装
```bash
trivy --version    # 应输出 v0.71.0+
grype --version    # 应输出 v0.114.0+
```

## 本地运行

### 1. 安全扫描
```bash
cd /mnt/d/openworkspace/jinggo-company/company-repos/project-securepipe
./scripts/scan.sh
```

### 2. SBOM 生成
```bash
./scripts/generate-sbom.sh
# 输出到 sbom/ 目录
ls sbom/
```

### 3. 漏洞数据源同步
```bash
./scripts/sync-vulnerability-feeds.sh
# 同步 CNVD + NVD 数据到 data/ 目录
```

### 4. 部署验证
```bash
./scripts/verify-deployment.sh
# 输出 4/4 checks passed
```

## 产品演示

### 录屏视频
- **文件：** `docs/demo/securepipe_demo.mp4`（70 秒）
- **内容：** 完整核心流程（仪表盘 → SBOM 管理 → CI/CD 集成）

### Demo 截图
- `docs/demo/securepipe_demo_01_dashboard.png` — 漏洞聚合仪表盘
- `docs/demo/securepipe_demo_02_sbom.png` — SBOM 管理与差异对比
- `docs/demo/securepipe_demo_03_cicd.png` — CI/CD 流水线集成

## 文档
- [PRD](docs/PRD.md) — 产品需求文档
- [ARCHITECTURE](docs/ARCHITECTURE.md) — 系统架构
- [TECH_STACK](docs/TECH_STACK.md) — 技术栈说明
- [SALES_MATERIALS](docs/SALES_MATERIALS.md) — 销售材料
- [TEST_CASES](docs/TEST_CASES.md) — 测试案例
- [TEST_REPORT](docs/TEST_REPORT.md) — 测试报告
