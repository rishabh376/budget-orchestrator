# Setup - budget-orchestrator

Sre Teams use the service to turn runbooks into checks across latency-sensitive gateways, so runbooks prove they still match production.

1. **Infra first**: `cd terraform && terraform init && terraform apply`
2. `kubectl apply -k k8s/ -n budget-orchestrator`
3. `kubectl port-forward svc/budget-orchestrator 8080:80 -n budget-orchestrator`
4. `curl localhost:8080/healthz`

Env vars: `PORT=8080`, `LOG_LEVEL=info`

We treat observability as a first-class citizen with alerts tuned to what actually matters in an outage.
