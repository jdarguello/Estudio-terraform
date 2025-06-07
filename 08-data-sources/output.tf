output "ubuntu_image_ref" {
  value = data.aws_ami.ubuntu_22.name
}

output "eks_vpc" {
  value = data.aws_vpc.eks_vpc.arn
}

output "eks_subnet" {
  value = data.aws_subnet.eks_public_subnet_1.arn
}

output "iam_caller" {
  value = data.aws_caller_identity.current.arn
}

output "cloud_region" {
  value = data.aws_region.region.name
}
