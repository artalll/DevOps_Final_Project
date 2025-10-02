
# GitOps Deployment Guide using ArgoCD

This guide explains how to configure GitOps deployment for the QuakeWatch application using ArgoCD.

## Repository Structure

```
DevOps_Final_Project/
├── quakewatch-chart/                   # Helm chart for the application
├── argocd/
│   └── quakewatch-application.yaml     # ArgoCD Application manifest
├── docs/
│   └── gitops_guide.md                 # ← This guide
```

---

## Prerequisites

- Kubernetes cluster (e.g., Minikube)
- ArgoCD installed in the cluster
- Helm chart of your app committed to a Git repository (e.g., GitHub)

---

## Step 1: Create ArgoCD Application Manifest

File: `argocd/quakewatch-application.yaml`

```yaml
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: quakewatch
  namespace: argocd
spec:
  project: default
  source:
    repoURL: https://github.com/artalll/DevOps_Final_Project
    targetRevision: main
    path: quakewatch-gitops-chart
    helm:
      valueFiles:
        - values.yaml
  destination:
    server: https://kubernetes.default.svc
    namespace: default
  syncPolicy:
    automated:
      prune: true
      selfHeal: true
```

> This manifest tells ArgoCD to deploy the Helm chart from GitHub and auto-sync any changes.

---

## Step 2: Apply the ArgoCD Application

```bash
kubectl apply -f argocd/quakewatch-application.yaml
```

> This registers the app in ArgoCD.

---

## Step 3: Enable Auto-Sync in ArgoCD UI

Auto-sync is already enabled in the manifest:

```yaml
syncPolicy:
  automated:
    prune: true
    selfHeal: true
```

- Changes in Git will be automatically applied to the cluster.
- Old resources will be pruned.
- Manual changes in the cluster will be reverted.

---

## Step 4: Verify in ArgoCD UI

1. Open ArgoCD web UI.
2. Locate your `quakewatch` app.
3. Confirm the following states:
   - `Synced` (green)
   - `Healthy`

---

## Success!

Your application is now fully GitOps-enabled.
Changes to your Helm chart in the Git repository will trigger automatic updates in your Kubernetes cluster.
