# Security - budget-orchestrator

What we do:
- Trivy scan in CI - blocks HIGH/CRITICAL
- Cosign sign images
- Non-root UID 10001, readOnlyRootFilesystem
- NetworkPolicy default-deny
- RBAC least-privilege
- Secrets via External Secrets / Vault (not in git)
- Dependabot + CodeQL on

Threat model: Failover plans look good in docs but are rarely rehearsed end to end.

Reliability and safety go hand-in-hand: SLO guardrails, incident runbooks, and control-plane failure mode analysis.
