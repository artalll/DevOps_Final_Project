# Kubernetes Deployment Guide for QuakeWatch

This document provides instructions for deploying the QuakeWatch Flask application to a Kubernetes cluster.

---

## Preconditions

- A working Kubernetes cluster (e.g., Minikube)
- Docker image published to Docker Hub (e.g., `artalll/quakewatch:latest`)
- `kubectl` installed and configured (`kubectl get nodes` should return a valid node)

---

## Step-by-Step Deployment

### 1. Apply Configuration Files

Navigate to the `k8s/` directory and apply the following YAML files in order:

```bash
kubectl apply -f configmap.yaml
kubectl apply -f secret.yaml
kubectl apply -f deployment.yaml
kubectl apply -f service.yaml
kubectl apply -f hpa.yaml
kubectl apply -f cronjob.yaml


