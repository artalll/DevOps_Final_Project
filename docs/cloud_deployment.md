# Cloud Deployment with Terraform & k3s

## 1. AWS Infrastructure:
- VPC CIDR: 10.0.0.0/16
- Subnet: 10.0.1.0/24 (public)
- Internet Gateway: enabled
- Security Group: SSH, HTTP, 6443 open

## 2. EC2 Instances:
- Master: t3.small, Ubuntu 22.04
- Worker: t3.small, Ubuntu 22.04

## 3. k3s Installation:
- Installed via user_data bootstrap script
- Worker joined master using private IP and token

## 4. QuakeWatch Deployment:
- Deployed via Helm chart
- Accessible externally on NodePort

## 5. Detailed Cluster Deployment Commands:
'''bash
- cd terraform/
- terraform init
- terraform apply
  
## Test access:
'''bash
- kubectl get nodes

## Deploy QuakeWatch App:

'''bash
- helm install quakewatch ./quakewatch-gitops-chart

## Port-forward to access:
'''bash
POD_NAME=$(kubectl get pods --namespace default -l "app.kubernetes.io/name=quakewatch-gitops-chart,app.kubernetes.io/instance=quakewatch" -o jsonpath="{.items[0].metadata.name}")
CONTAINER_PORT=$(kubectl get pod --namespace default $POD_NAME -o jsonpath="{.spec.containers[0].ports[0].containerPort}")
kubectl --namespace default port-forward $POD_NAME 8888:$CONTAINER_PORT

## Visit:
http://localhost:8888




