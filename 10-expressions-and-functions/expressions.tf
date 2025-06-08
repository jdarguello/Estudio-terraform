locals {
  usernames_for_loop = [for user_info in var.users : user_info.username]
  usernames_splat    = var.users[*].username

  subnets = {
    for subnet in var.subnets :
    "${subnet.vpc_id}-${subnet.availability_zone}" => subnet
  }
}

output "subnets" {
  value = local.subnets
}

output "usernames_for_loop" {
  value = local.usernames_for_loop
}

output "usernames_splat" {
  value = local.usernames_splat
}