terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
    kubernetes = {
      source = "hashicorp/kubernetes"
    }
  }
  required_version = ">= 1.2.0"
}

provider "aws" {
  region  = "us-east-2"
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 19.0"

  cluster_name                   = "canary-automation"
  cluster_endpoint_public_access = true

  cluster_addons = {
    coredns = {
      preserve    = true
      most_recent = true

      timeouts = {
        create = "25m"
        delete = "10m"
      }
    }
    kube-proxy = {
      most_recent = true
    }
    vpc-cni = {
      most_recent = true
    }
  }
  create_kms_key = false
  cluster_encryption_config = {}
  cloudwatch_log_group_retention_in_days = 0
  create_cloudwatch_log_group = false
  vpc_id                   = "vpc-0026cad49c950ef0f"
  subnet_ids               = [
    "subnet-02c526a278fb3a449",
    "subnet-092db4ffcba06b14c",
    "subnet-042b8612152dcc219",
  ]

  create_iam_role = false
  enable_irsa = false
  attach_cluster_encryption_policy = false
  iam_role_arn = "arn:aws:iam::801176112578:role/eksClusterRole"

  eks_managed_node_groups = {
    canary = {
      name = "canary-automation"
      min_size     = 1
      max_size     = 3
      desired_size = 2

      instance_types = ["t3.medium"]
      capacity_type  = "SPOT"

      create_iam_role = false
      node_role_arn   = "arn:aws:iam::801176112578:role/eksNodeRole"
      iam_role_arn    = "arn:aws:iam::801176112578:role/eksNodeRole"

      create_launch_template = false
      use_custom_launch_template = false
      create_schedule = false
      enable_monitoring = false
      iam_role_attach_cni_policy = false
    }
  }
}
