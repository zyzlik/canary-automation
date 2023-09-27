output "cluster_endpoint" {
  description = "Endpoint for EKS control plane."
  value       = module.eks.cluster_endpoint
}

output "region" {
  description = "AWS region"
  value       = "us-east-2"
}

output "cluster_name" {
  description = "Kubernetes Cluster Name"
  value       = "canary-automation"
}
