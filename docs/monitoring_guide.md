
# Monitoring Setup Guide: Prometheus & Grafana

This guide explains how to install Prometheus and Grafana into your Kubernetes cluster and configure them to monitor the QuakeWatch application.

---

## Repository Structure (Monitoring Related)

```
DevOps_Final_Project/
├── monitoring/
│   ├── prometheus/            # Prometheus manifests or Helm chart
│   ├── grafana/               # Grafana manifests or Helm chart
│   └── alerting/              # Alert rules (if separate)
├── docs/
│   ├── gitops_guide.md
│   └── monitoring_guide.md    # ← This guide
```

---

## Step 1: Install Prometheus using Helm

```bash
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update

helm install prometheus prometheus-community/prometheus   --namespace monitoring --create-namespace
```

This installs Prometheus in the `monitoring` namespace.

---

## Step 2: Install Grafana using Helm

```bash
helm install grafana prometheus-community/grafana   --namespace monitoring
```

After installation, get your Grafana admin password:

```bash
kubectl get secret --namespace monitoring grafana -o jsonpath="{.data.admin-password}" | base64 --decode ; echo
```

Forward Grafana port:

```bash
kubectl port-forward svc/grafana 3000:80 -n monitoring
```

Open in browser: http://localhost:3000 (login: `admin`, password: from above)

---

## Step 3: Configure Prometheus to Scrape QuakeWatch

If your app exposes `/metrics`, add it to Prometheus scrape config.

If using Helm, override with custom values like:

```yaml
server:
  extraScrapeConfigs:
    - job_name: quakewatch
      static_configs:
        - targets: ['quakewatch-service.default.svc.cluster.local:5000']
```

Or create a `ServiceMonitor` if you're using Prometheus Operator.

---

## Step 4: Setup Grafana Dashboards

1. Login to Grafana
2. Add Prometheus as a data source (URL: `http://prometheus-server.monitoring.svc.cluster.local`)
3. Import dashboards manually or create new ones
4. Suggested panels:
   - CPU Usage (container level)
   - Memory Usage
   - Request Rate / Error Rate (if metrics are exposed)
   - Pod Status / Restarts

---

## Step 5: Alerting with Prometheus

Create alerting rules:

```yaml
groups:
  - name: quakewatch-alerts
    rules:
      - alert: HighPodRestart
        expr: rate(kube_pod_container_status_restarts_total[5m]) > 0.5
        for: 2m
        labels:
          severity: warning
        annotations:
          summary: High restart rate on pod
```

Attach alert rules to Prometheus using Helm values or ConfigMap.

---
