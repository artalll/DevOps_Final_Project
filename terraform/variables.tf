variable "region" {
  description = "AWS region for deploying infrastructure"
  type        = string
  default     = "us-east-1"
}

variable "key_name" {
  description = "Existing AWS EC2 key pair name for SSH access"
  type        = string
  default     = "quakewatch-key"
}

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "subnet_cidr" {
  description = "CIDR block for public subnet"
  type        = string
  default     = "10.0.1.0/24"
}

variable "master_instance_type" {
  description = "EC2 instance type for the k3s master node"
  type        = string
  default     = "t3.small"
}

variable "worker_instance_type" {
  description = "EC2 instance type for the k3s worker node"
  type        = string
  default     = "t3.small"
}

variable "ami_id" {
  description = "Ubuntu 22.04 AMI ID for EC2 instances"
  type        = string
  default     = "ami-0c7217cdde317cfec"
}

variable "k3s_token" {
  description = "Shared token for joining worker node to master"
  type        = string
  default     = "mysecret"
}

variable "project_tag" {
  description = "Project name tag"
  type        = string
  default     = "quakewatch"
}
