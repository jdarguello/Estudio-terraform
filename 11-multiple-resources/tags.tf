locals {
  common_tags = {
    MadeBy  = "Terraform",
    Project = "Multiple-resources"
  }
  ec2_tags = merge(local.common_tags, {
    CostCenter = "1234"
  })
}