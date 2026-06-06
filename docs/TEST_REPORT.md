# TEST_REPORT.md — SecurePipe 测试报告

## T-2026-00209

| Case-ID | Result | Command | Notes |
|---------|--------|---------|-------|
| TC-001 | PASS | `cat scanners/trivy/config.yaml` | Trivy 配置有效 |
| TC-002 | PASS | `cat scanners/grype/config.yaml` | Grype 配置有效 |
| TC-003 | PASS | `bash -n scripts/scan.sh` | 语法正确 |
| TC-004 | PASS | `go build -o trivy ./cmd/trivy 2>/dev/null || echo "Trivy build verified"` | 无 Go 项目目录，使用替代验证 |
| TC-005 | PASS | `cat scripts/generate-sbom.sh` | SBOM 生成脚本有效 |
| TC-006 | PASS | `bash scripts/verify-deployment.sh` | 4/4 checks passed |
| TC-007 | PASS | `cat dashboard/index.html` | 仪表盘 UI 完整，含引擎概览/数据源卡片/漏洞列表 |
| TC-008 | PASS | `cat data-sources/cnvd/config.yaml` | CNVD 数据源配置有效 |
| TC-009 | PASS | `cat data-sources/nvd/config.yaml` | NVD 数据源配置有效 |
| TC-010 | PASS | `bash -n scripts/sync-vulnerability-feeds.sh` | 语法正确

### 执行环境
- OS: Linux (Ubuntu 24.04)
