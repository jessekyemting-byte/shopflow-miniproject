# Security findings

## 1. Vulnerable pinned dependencies (found by pip-audit in CI)

| Package | Version | Advisory | Risk | Fix |
|---|---|---|---|---|
| Flask | 3.1.2 | PYSEC-2026-2151 / CVE-2026-27205 | Missing `Vary: Cookie` on some session access; only exploitable behind a caching proxy. ShopFlow does not use Flask sessions. | Upgraded to 3.1.3 |
| pytest | 8.4.2 | PYSEC-2026-1845 / CVE-2025-71176 | Predictable temp directory handling (local DoS or privilege escalation) where tests run | Upgraded to 9.0.3 |

Detection: the `pip-audit` step in the CI workflow failed the pull request until both were fixed.
