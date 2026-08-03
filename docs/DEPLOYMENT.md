# Deployment - budget-orchestrator

**Use case:** Sre Teams use the service to turn runbooks into checks across latency-sensitive gateways, so runbooks prove they still match production.

## Infra requirements
→ `terraform/INFRA_REQUIREMENTS.md` - CPU/RAM/storage/network/cost breakdown

## GitOps
Flux watches `main` and reconciles changes automatically.

## Rollback
```
./scripts/rollback.sh
kubectl rollout undo deploy/budget-orchestrator -n budget-orchestrator
```
Usually < 30 sec.

## Cost
GCP Free Tier - $0/mo

Reliability and safety go hand-in-hand: SLO guardrails, incident runbooks, and control-plane failure mode analysis.
