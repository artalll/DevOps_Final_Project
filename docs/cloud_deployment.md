# Cloud Deployment with Terraform & k3s

## 1. AWS Infrastructure
- VPC CIDR: 10.0.0.0/16
- Subnet: 10.0.1.0/24 (public)
- Internet Gateway: enabled
- Security Group: SSH, HTTP, 6443 open

## 2. EC2 Instances
- Master: t3.small, Ubuntu 22.04
- Worker: t3.small, Ubuntu 22.04

## 3. k3s Installation
- Installed via user_data bootstrap script
- Worker joined master using private IP and token

## 4. QuakeWatch Deployment
- Deployed via Helm chart
- Accessible externally on NodePort
