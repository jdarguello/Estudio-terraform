data "aws_vpc" "eks_vpc" {
  state = "available"
  tags = {
    Name : "eks-vpc"
    "aws:cloudformation:logical-id" : "VPC"
  }
}

data "aws_subnet" "eks_public_subnet_1" {
  state = "available"
  filter {
    name = "tag:Name"
    values = ["eks-public-subnet-1"]
  }
  filter {
    name = "tag:aws:cloudformation:stack-name"
    values = ["eks-vpc"]
  }
}