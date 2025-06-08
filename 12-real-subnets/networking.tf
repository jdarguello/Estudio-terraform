data "aws_vpc" "eks-vpc" {
  filter {
    name   = "tag:Name"
    values = ["eks-vpc"]
  }

  filter {
    name   = "tag:aws:cloudformation:logical-id"
    values = ["VPC"]
  }
}

data "aws_subnets" "eks_subnets" {
  filter {
    name   = "tag:aws:cloudformation:stack-name"
    values = ["eks-vpc"]
  }
}