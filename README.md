# budget-orchestrator

> Sre Teams use the service to turn runbooks into checks across latency-sensitive gateways, so runbooks prove they still match production.

**Domain:** sre | **Complexity:** expert | **Stack:** Go, Prometheus, Thanos, Chaos Mesh, Litmus, Multi-region, OTel

| | |
|---|---|
| Use case | Sre Teams use the service to turn runbooks into checks across latency-sensitive gateways, so runbooks prove they still match production. |
| Pain point | Failover plans look good in docs but are rarely rehearsed end to end. |
| Success metric | Warn 30 minutes before projected budget exhaustion and auto-freeze risky deploys. |
| Cost | $0/mo on GCP Free Tier |

## Why this exists

Failover plans look good in docs but are rarely rehearsed end to end.. Sre Teams use the service to turn runbooks into checks across latency-sensitive gateways, so runbooks prove they still match production.

> This production platform is designed for reliability, error budgets, and repeatable recovery drills. For this implementation, the service is designed to remove the operational friction behind Sre Teams use the service to turn runbooks into checks across latency-sensitive gateways, so runbooks prove they still match production..

## What this product does

This project ships a production-oriented service that exposes health, readiness, observability, and domain-specific endpoints for Sre Teams use the service to turn runbooks into checks across latency-sensitive gateways, so runbooks prove they still match production.. The implementation is intended to be deployed behind Kubernetes with secure defaults, CI validation, and rollback-ready manifests.

## Quick start

```bash
docker build -t budget-orchestrator:local .
docker run -p 8080:8080 budget-orchestrator:local
curl http://localhost:8080/healthz
```

## Architecture

```
GitHub CI -> Container Registry -> Kubernetes -> Go -> Operators / SRE
```

See `docs/ARCHITECTURE.md`

## Infrastructure

Full spec: `terraform/INFRA_REQUIREMENTS.md`

TL;DR: K8s cluster, 2-10 pods HPA, $0 on GCP Free Tier

## Docs

- `docs/ARCHITECTURE.md` - components, tradeoffs
- `docs/DESIGN_DISCUSSION.md` - how we decided to build this
- `docs/DEPLOYMENT.md` - GitOps, rollback
- `docs/SECURITY.md` - threat model
- `docs/TROUBLESHOOTING.md` - 3am runbook
- `terraform/INFRA_REQUIREMENTS.md` - **infra: CPU/RAM/storage/cost**

Interview prep: `interview/`
