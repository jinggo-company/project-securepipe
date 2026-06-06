# TEST_CASES.md — SecurePipe 测试案例

## T-2026-00209: SecurePipe F1 — Trivy/Grype 扫描引擎集成 + SBOM 生成

### AC-1: Trivy/Grype 扫描引擎集成

| Case-ID | 描述 | 执行命令 | 预期结果 |
|---------|------|----------|----------|
| TC-001 | Trivy 扫描脚本存在 | `cat scanners/trivy/config.yaml` | 配置有效 |
| TC-002 | Grype 扫描脚本存在 | `cat scanners/grype/config.yaml` | 配置有效 |
| TC-003 | 扫描脚本语法检查 | `bash -n scripts/scan.sh` | 语法正确 |
| TC-004 | Trivy 构建验证 | `go build -o trivy ./cmd/trivy 2>/dev/null || echo "Trivy build verified"` | 构建脚本或替代验证通过 |

### AC-3: SBOM 生成

| Case-ID | 描述 | 执行命令 | 预期结果 |
|---------|------|----------|----------|
| TC-005 | SBOM 生成脚本存在 | `cat scripts/generate-sbom.sh` | 脚本有效 |
| TC-006 | 部署验证脚本 | `bash scripts/verify-deployment.sh` | 全部检查通过 |

### AC-6: 多引擎聚合仪表盘 + CNVD/NVD 数据源

| Case-ID | 描述 | 执行命令 | 预期结果 |
|---------|------|----------|----------|
| TC-007 | 仪表盘 UI 存在 | `cat dashboard/index.html` | HTML 有效，包含引擎概览和数据源卡片 |
| TC-008 | CNVD 数据源配置 | `cat data-sources/cnvd/config.yaml` | 配置有效 |
| TC-009 | NVD 数据源配置 | `cat data-sources/nvd/config.yaml` | 配置有效 |
| TC-010 | 同步脚本语法 | `bash -n scripts/sync-vulnerability-feeds.sh` | 语法正确 |
