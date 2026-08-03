package main

// budget-orchestrator
// Sre Teams use the service to turn runbooks into checks across latency-sensitive gateways, so runbooks prove they still match production.
// Domain: sre

import (
    "encoding/json"
    "log"
    "net/http"
    "github.com/prometheus/client_golang/prometheus"
    "github.com/prometheus/client_golang/prometheus/promhttp"
)

var reqs = prometheus.NewCounterVec(prometheus.CounterOpts{
    Name: "requests_total", Help: "Total requests"}, []string{"endpoint"})

func main() {
    prometheus.MustRegister(reqs)
    http.Handle("/metrics", promhttp.Handler())
    http.HandleFunc("/healthz", func(w http.ResponseWriter, r *http.Request) {
        json.NewEncoder(w).Encode(map[string]string{"status":"ok","project":"budget-orchestrator","domain":"sre"})
    })
    http.HandleFunc("/readyz", func(w http.ResponseWriter, r *http.Request) {
        // TODO: add real readiness check
        w.Write([]byte(`{"ready":true}`))
    })
    http.HandleFunc("/slo", func(w http.ResponseWriter, r *http.Request) {
        json.NewEncoder(w).Encode(map[string]interface{}{"target":0.999,"error_budget_remaining":0.72,"burn_rate":0.8})
    })

    http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
        reqs.WithLabelValues("/").Inc()
        json.NewEncoder(w).Encode(map[string]string{"message":"Sre Teams use the service to turn runbooks into checks across latency-sensitive gateways, so runbooks prove they still match production.","service":"budget-orchestrator"})
    })
    log.Println("budget-orchestrator listening :8080")
    log.Fatal(http.ListenAndServe(":8080", nil))
}
