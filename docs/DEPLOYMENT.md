# SecurePipe — 部署指南

> 本文档面向首次接触 SecurePipe 的开发者/运维人员。按步骤操作即可完整跑通。

## 前置条件

- Linux (Ubuntu 20.04+) / macOS
- Bash 4.0+
- curl
- (可选) NVD API Key（用于 NVD 同步，无 Key 也可运行但有速率限制）

## Step 1: 克隆仓库

```bash
cd /mnt/d/openworkspace/jinggo-company/company-repos
# 仓库已存在则跳过
ls project-securepipe/
```

## Step 2: 安装 Trivy

```bash
# 使用官方安装脚本
curl -sfL https://raw.githubusercontent.com/aquasecurity/trivy/main/contrib/install.sh | sh -s -- -b /usr/local/bin

# 验证
trivy --version
```

### 国内加速方案

如果 GitHub 直连缓慢：

```bash
# 使用 gh-proxy 镜像
curl -sfL "https://gh-proxy.com/https://github.com/aquasecurity/trivy/releases/download/v0.71.0/trivy_0.71.0_linux-64bit.tar.gz" -o trivy.tar.gz
tar xzf trivy.tar.gz trivy
chmod +x trivy
sudo mv trivy /usr/local/bin/
```

## Step 3: 安装 Grype

```bash
# 使用官方安装脚本
curl -sSfL https://raw.githubusercontent.com/anchore/grype/main/install.sh | sh -s -- -b /usr/local/bin

# 验证
grype --version
```

### 国内加速方案

```bash
curl -sfL "https://gh-proxy.com/https://github.com/anchore/grype/releases/download/v0.114.0/grype_0.114.0_linux_amd64.tar.gz" -o grype.tar.gz
tar xzf grype.tar.gz grype
chmod +x grype
sudo mv grype /usr/local/bin/
```

## Step 4: 运行安全扫描

```bash
cd project-securepipe
./scripts/scan.sh
```

预期输出：
```
[SecurePipe] Running security scans...
[SecurePipe] Running Trivy scan...
<Trivy 扫描结果表格>
[SecurePipe] Running Grype scan...
<Grype 扫描结果>
[SecurePipe] Scan complete.
```

## Step 5: 生成 SBOM

```bash
./scripts/generate-sbom.sh
```

预期输出：
```
[SecurePipe] Generating SBOM...
[SecurePipe] Generating CycloneDX JSON...
[SecurePipe] Generating SPDX...
[SecurePipe] SBOM generated in sbom/
```

验证生成文件：
```bash
ls -la sbom/
# 应看到 sbom-cyclonedx.json 和 sbom-spdx.json
```

## Step 6: 同步漏洞数据源

```bash
./scripts/sync-vulnerability-feeds.sh
```

预期输出：
```
[SecurePipe] Syncing NVD feed...
[SecurePipe] NVD sync OK -> data/nvd/nvd-vulns-<timestamp>.json
[SecurePipe] Syncing CNVD feed (RSS)...
[SecurePipe] CNVD sync OK -> data/cnvd/cnvd-feed-<timestamp>.xml
[SecurePipe] Vulnerability feed sync complete.
```

## Step 7: 查看仪表盘

```bash
# 在浏览器中打开仪表盘 UI
xdg-open dashboard/index.html
# 或
open dashboard/index.html  # macOS
```

## Step 8: 运行部署验证

```bash
./scripts/verify-deployment.sh
```

预期输出：
```
==========================================
 SecurePipe Deployment Verification
==========================================
[PASS] Trivy config exists
[PASS] Grype config exists
[PASS] Scan script exists
[PASS] SBOM script exists
==========================================
 Results: 4 passed, 0 failed
==========================================
```

## 端到端验证检查清单

| # | 检查项 | 命令 | 预期结果 |
|---|--------|------|----------|
| 1 | Trivy 已安装 | `trivy --version` | 输出版本号 v0.71.0+ |
| 2 | Grype 已安装 | `grype --version` | 输出版本号 v0.114.0+ |
| 3 | 扫描可运行 | `./scripts/scan.sh` | 输出 Trivy + Grype 扫描结果 |
| 4 | SBOM 可生成 | `./scripts/generate-sbom.sh` | sbom/ 下有 2 个 JSON 文件 |
| 5 | 数据源可同步 | `./scripts/sync-vulnerability-feeds.sh` | data/ 下有 NVD + CNVD 文件 |
| 6 | 仪表盘可访问 | 打开 dashboard/index.html | 浏览器显示完整 UI |
| 7 | 部署验证通过 | `./scripts/verify-deployment.sh` | 4/4 passed |

## 故障排除

### Trivy/Grype 下载超时
- 使用 `gh-proxy.com` 或 `mirror.ghproxy.com` 代理
- 或手动从国内 Gitee 镜像下载

### NVD 同步失败
- 检查网络是否可访问 `services.nvd.nist.gov`
- 设置 `NVD_API_KEY` 环境变量提高速率限制

### CNVD 同步失败
- CNVD RSS 可能被反爬
- 可手动下载 XML 文件放入 `data/cnvd/`

## 目录结构

```
project-securepipe/
├── README.md                 # 本文档
├── scripts/
│   ├── scan.sh               # 安全扫描入口
│   ├── generate-sbom.sh      # SBOM 生成
│   ├── sync-vulnerability-feeds.sh  # 数据源同步
│   └── verify-deployment.sh  # 部署验证
├── scanners/
│   ├── trivy/config.yaml     # Trivy 配置
│   └── grype/config.yaml     # Grype 配置
├── dashboard/
│   └── index.html            # 漏洞聚合仪表盘
├── sbom/                     # SBOM 输出目录
├── data/
│   ├── cnvd/                 # CNVD 漏洞数据
│   └── nvd/                  # NVD 漏洞数据
├── data-sources/             # 数据源配置
└── docs/                     # 项目文档
    ├── PRD.md
    ├── ARCHITECTURE.md
    ├── TECH_STACK.md
    ├── TEST_CASES.md
    ├── TEST_REPORT.md
    └── SALES_MATERIALS.md
```
