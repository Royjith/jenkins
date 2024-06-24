variable "region" {
  type        = string
  default     = "us-west-2"
  description = "AWS region"
}

variable "eks_cluster_role_name" {
  type        = string
  default     = "eks-cluster-role"
  description = "EKS cluster role name"
}

variable "eks_cluster_policy_name" {
  type        = string
  default     = "eks-cluster-policy"
  description = "EKS cluster policy name"
}

variable "vpc_cidr_block" {
  type        = string
  default     = "10.0.0.0/16"
  description = "VPC CIDR block"
}

variable "availability_zones" {
  type        = list(string)
  default     = ["us-west-2a", "us-west-2b"]
  description = "Availability zones for subnets"
}

variable "subnet_count" {
  type        = number
  default     = 2
  description = "Number of subnets to create"
}
