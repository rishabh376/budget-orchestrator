# Infrastructure Requirements - budget-orchestrator

**Use Case:** Sre Teams use the service to turn runbooks into checks across latency-sensitive gateways, so runbooks prove they still match production.

## Compute
- Kubernetes cluster (K3s / EKS / AKS / GKE)
- Minimum nodes: 3 x 2vCPU / 4GB (HA)
- CPU per pod: 100m request / 500m limit
- Memory per pod: 128Mi request / 512Mi limit
- Replicas: 2-10 (HPA)

## Storage
- Prometheus TSDB: 20GB PVC
- Thanos / long-term storage optional

## Network
- Ingress controller (nginx / traefik)
- Service type: ClusterIP
- TLS: cert-manager recommended

## Dependencies
- Prometheus + Thanos
- Grafana
- Alertmanager
- Chaos Mesh

## Free Tier Options
- Oracle Cloud Always Free: 4 ARM OCPUs, 24GB RAM - FREE
- Fly.io: 3 shared VMs - FREE
- Render/Railway: $5 free credit

## Cost Estimate
**$0/month** Oracle Always Free x2 VMs (4 OCPUs, 24GB total)

## Setup Steps
1. `terraform init`
2. `terraform plan -out=tfplan`
3. `terraform apply tfplan`
4. `kubectl get pods -n budget-orchestrator`
5. `kubectl port-forward svc/budget-orchestrator 8080:80 -n budget-orchestrator`

## Scaling
HPA configured: 70% CPU target, 2-10 pods

## Disaster Recovery
RTO 15m, RPO 1h. Backup with Velero.
