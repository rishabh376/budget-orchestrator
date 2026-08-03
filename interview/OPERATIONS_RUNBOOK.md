# Operations Runbook - budget-orchestrator

Sre Teams use the service to turn runbooks into checks across latency-sensitive gateways, so runbooks prove they still match production.

**On-call? Read this first.**

## Deploy
```
kubectl apply -k k8s/ -n budget-orchestrator
kubectl rollout status deploy/budget-orchestrator -n budget-orchestrator
```

## Rollback (when things go red)
```
./scripts/rollback.sh
# usually < 30sec
```

## Scale up NOW
```
kubectl scale deploy/budget-orchestrator --replicas=10 -n budget-orchestrator
```

## Logs
```
kubectl logs -l app=budget-orchestrator -n budget-orchestrator -f --tail=200
```

## Crashloop?
```
kubectl describe pod -l app=budget-orchestrator -n budget-orchestrator
kubectl logs <pod> --previous -n budget-orchestrator
```
90% of the time: missing env var in ConfigMap.

## Metrics
`curl localhost:8080/metrics` or Grafana dashboard in `monitoring/`

## DR / Failover
See `docs/DISASTER_RECOVERY.md` - RTO 15m

We actually tested this. 11 min.
