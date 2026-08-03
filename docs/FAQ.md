# FAQ - budget-orchestrator

**Q: What problem does this actually solve?**
A: Sre Teams use the service to turn runbooks into checks across latency-sensitive gateways, so runbooks prove they still match production.

Pain point: Failover plans look good in docs but are rarely rehearsed end to end.

**Q: Free to run?**
A: Yep. GCP Free Tier - $0/mo. See `terraform/INFRA_REQUIREMENTS.md`

**Q: Production ready?**
A: Yes - SLOs, security hardening, DR runbook, Helm, Terraform, monitoring.

**Q: Stack?**
A: Go, Prometheus, Thanos, Chaos Mesh, Litmus, Multi-region, OTel

**Q: What infra do I need?**
A: `terraform/INFRA_REQUIREMENTS.md` has the full breakdown - CPU/RAM/storage/network/cost.
