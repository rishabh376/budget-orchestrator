# Architecture - budget-orchestrator

> Sre Teams use the service to turn runbooks into checks across latency-sensitive gateways, so runbooks prove they still match production.

**Pain:** Failover plans look good in docs but are rarely rehearsed end to end.  
**Success metric:** Warn 30 minutes before projected budget exhaustion and auto-freeze risky deploys.

## Decision log

We chose K8s + go because the service needs to be deployed, observed, and rolled back under real production conditions. The architecture reflects the operational problem behind Sre Teams use the service to turn runbooks into checks across latency-sensitive gateways, so runbooks prove they still match production.: we need something that ships quickly, is observable, and can be recovered without hand-waving.

We also prioritized Reliability and safety go hand-in-hand: SLO guardrails, incident runbooks, and control-plane failure mode analysis. and We treat observability as a first-class citizen with alerts tuned to what actually matters in an outage. so the architecture is built around real operational signal, not just feature scope.

See `docs/architecture/ADR-001-runtime-choice.md`

## Components

- go service with health, readiness, and domain-specific endpoints for Sre Teams use the service to turn runbooks into checks across latency-sensitive gateways, so runbooks prove they still match production.
- Prometheus metrics and structured logging for operators
- Docker image with non-root runtime and secure defaults
- K8s Deployment + HPA 2-10, 70% CPU
- GitOps (FluxCD) and rollback scripts
- The operational stack implied by the project: Go, Prometheus, Thanos, Chaos Mesh, Litmus, Multi-region, OTel

## Trade-offs

| Choice | Why | Cost |
|---|---|---|
| K8s over serverless | team expertise, portability, predictable ops | more YAML |
| Self-hosted observability | lower cost than SaaS alternatives | we run it |
| RollingUpdate first | simpler for v0.1, canary later | faster shipping |

## Data flow

```
Client -> Ingress -> Service -> Pod
Pod -> /metrics -> Prometheus -> Alertmanager -> Slack
Domain actions -> API -> logs/metrics -> operators
```

## Scaling

HPA 2-10 pods. Stateless. 50m/64Mi request.

## Why not...

- **Serverless?** Cold start would hurt the main user flow and violate the reliability target.
- **Managed SaaS only?** The project must remain cost-effective and under operational control.
