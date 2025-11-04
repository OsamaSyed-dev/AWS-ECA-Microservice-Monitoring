output "vpc_id" {
  value = aws_vpc.this.id
}

output "public_subnets" {
  value = [for s in aws_subnet.public : s.id]
}

output "private_subnets" {
  value = [for s in aws_subnet.private : s.id]
}

output "alb_dns" {
  value = aws_lb.alb.dns_name
}

output "rds_endpoint" {
  value = aws_db_instance.main.address
  description = "RDS endpoint (use in backend DB_HOST)"
}

output "ecr_frontend_uri" {
  value = aws_ecr_repository.frontend.repository_url
}

output "ecr_backend_uri" {
  value = aws_ecr_repository.backend.repository_url
}

output "prometheus_repo_url" {
  value = aws_ecr_repository.prometheus_repo.repository_url
}
