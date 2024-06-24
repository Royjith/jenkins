provider "aws" {
  region = var.region
}

resource "aws_iam_role" "eks_cluster_role" {
  name        = var.eks_cluster_role_name
  description = "EKS cluster role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "eks.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_policy" "eks_cluster_policy" {
  name        = var.eks_cluster_policy_name
  description = "EKS cluster policy"

  policy      = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "eks:*",
          "iam:PassRole",
          "ec2:*",
          "elasticloadbalancing:*",
          "cloudwatch:*"
        ]
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "eks_cluster_policy_attachment" {
  role       = aws_iam_role.eks_cluster_role.name
  policy_arn = aws_iam_policy.eks_cluster_policy.arn
}

resource "aws_vpc" "eks_vpc" {
  cidr_block = var.vpc_cidr_block
  tags = {
    Name = "eks-vpc"
  }
}

resource "aws_subnet" "eks_subnet" {
  count = var.subnet_count

  cidr_block = cidrsubnet(aws_vpc.eks_vpc.cidr_block, 8, count.index)
  availability_zone = element(var.availability_zones, count.index)
  vpc_id     = aws_vpc.eks_vpc.id
  tags = {
    Name = "eks-subnet-${count.index}"
  }
}
