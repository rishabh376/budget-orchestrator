# budget-orchestrator
# Sre Teams use the service to turn runbooks into checks across latency-sensitive gateways, so runbooks prove they still match production.
#
# INFRASTRUCTURE REQUIREMENTS
# Kubernetes 3 x 2vCPU / 4GB (HA)
# CPU: 100m / 500m, MEM: 128Mi / 512Mi
# - Prometheus TSDB: 20GB PVC
# - Thanos / long-term storage optional
# Dependencies: - Prometheus + Thanos
# - Grafana
# - Alertmanager
# - Chaos Mesh
# Cost: **$0/month** Oracle Always Free x2 VMs (4 OCPUs, 24GB total)

resource "kubernetes_namespace" "app" {
  metadata {
    name = var.namespace
    labels = { "app" = "budget-orchestrator", "managed-by" = "terraform" }
  }
}

resource "kubernetes_deployment" "app" {
  metadata {
    name = "budget-orchestrator"
    namespace = kubernetes_namespace.app.metadata[0].name
  }
  spec {
    replicas = var.replicas
    selector { match_labels = { app = "budget-orchestrator" } }
    template {
      metadata { labels = { app = "budget-orchestrator" } }
      spec {
        container {
          image = var.image
          name  = "app"
          port { container_port = 8080 }
          resources {
            requests = { cpu = "100m", memory = "128Mi" }
            limits   = { cpu = "500m", memory = "512Mi" }
          }
          liveness_probe {
            http_get { path = "/healthz" port = 8080 }
            initial_delay_seconds = 5
          }
          readiness_probe {
            http_get { path = "/readyz" port = 8080 }
            initial_delay_seconds = 3
          }
          security_context {
            run_as_non_root = true
            run_as_user = 10001
            allow_privilege_escalation = false
            read_only_root_filesystem = true
          }
        }
        security_context { fs_group = 10001 }
      }
    }
  }
}

resource "kubernetes_service" "app" {
  metadata {
    name = "budget-orchestrator"
    namespace = kubernetes_namespace.app.metadata[0].name
  }
  spec {
    selector = { app = "budget-orchestrator" }
    port {
      port = 80
      target_port = 8080
    }
    type = "ClusterIP"
  }
}

resource "kubernetes_horizontal_pod_autoscaler_v2" "app" {
  metadata {
    name = "budget-orchestrator"
    namespace = kubernetes_namespace.app.metadata[0].name
  }
  spec {
    scale_target_ref {
      api_version = "apps/v1"
      kind = "Deployment"
      name = kubernetes_deployment.app.metadata[0].name
    }
    min_replicas = 2
    max_replicas = 10
    metric {
      type = "Resource"
      resource {
        name = "cpu"
        target {
          type = "AverageUtilization"
          average_utilization = 70
        }
      }
    }
  }
}
