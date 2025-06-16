# Get existing VPC by name
data "aws_vpc" "eks_vpc" {
  filter {
    name   = "tag:Name"
    values = ["eks-vpc"]
  }
}



data "aws_subnet" "redis_subnets_1a" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.eks_vpc.id]
  }

  filter {
    name   = "tag:Name"
    values = ["eks-subnet-private1-ap-south-1a"]
  }
}

data "aws_subnet" "redis_subnets_1b" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.eks_vpc.id]
  }

  filter {
    name   = "tag:Name"
    values = ["eks-subnet-private2-ap-south-1b"]
  }
}

#data "aws_secretsmanager_secret" "redis_auth" {
#  name = "dev/redis"
#}

#data "aws_secretsmanager_secret_version" "redis_auth" {
#  secret_id = data.aws_secretsmanager_secret.redis_auth.id
#}

