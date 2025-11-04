variable "aws_region" {
  description = "AWS region to deploy into"
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Project prefix for resources"
  type        = string
  default     = "employee-mgmt"
}

variable "vpc_cidr" {
  description = "VPC CIDR block"
  type        = string
  default     = "10.10.0.0/16"
}

variable "public_subnet_cidrs" {
  description = "List of public subnets CIDRs (2)"
  type        = list(string)
  default     = ["10.10.1.0/24", "10.10.2.0/24"]
}

variable "private_subnet_cidrs" {
  description = "List of private subnets CIDRs (2)"
  type        = list(string)
  default     = ["10.10.101.0/24", "10.10.102.0/24"]
}

variable "db_username" {
  description = "RDS master username"
  type        = string
  default     = "adminuser"
}

variable "db_password" {
  description = "RDS master password (override via env var or tfvars)"
  type        = string
  sensitive   = true
  default     = "ChangeMe123!"
}

variable "db_instance_class" {
  description = "RDS instance class"
  type        = string
  default     = "db.t4g.micro"
}

variable "db_allocated_storage" {
  description = "RDS allocated storage (GB)"
  type        = number
  default     = 20
}

variable "ecr_frontend_name" {
  type    = string
  default = "employee-frontend"
}

variable "ecr_backend_name" {
  type    = string
  default = "employee-backend"
}

variable "ecs_desired_count" {
  type    = number
  default = 2
}

variable "create_ecs_service" {
  description = "If false, create ECR, RDS, VPC but do not create ECS service (useful for pushing images first)"
  type    = bool
  default = false
}

# provide image tags/uris as variables (GitHub Actions will update these)
variable "frontend_image_uri" {
  description = "Full ECR URI for the frontend image (e.g. ACCOUNT.dkr.ecr.REGION.amazonaws.com/employee-frontend:latest)"
  type        = string
  default     = ""
}

variable "backend_image_uri" {
  description = "Full ECR URI for the backend image"
  type        = string
  default     = ""
}

# Add your variable declarations here

variable "db_name" {
  description = "The name of the database"
  type        = string
  default     = "employeesdb"
}

variable "grafana_api_user" {
  type        = string
  description = "Grafana Cloud API User"
}

variable "grafana_api_key" {
  type        = string
  description = "Grafana Cloud API Key"
  sensitive   = true
}

variable "prometheus_image_uri" {
  description = "ECR image URI for the custom Prometheus image (including tag)"
  type        = string
  default     = "prom/prometheus:latest"
}

