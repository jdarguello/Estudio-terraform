locals {
  usernames_for_loop = [for user_info in var.users : user_info.username]
  usernames_splat    = var.users[*].username
}

output "usernames_for_loop" {
  value = local.usernames_for_loop
}

output "usernames_splat" {
  value = local.usernames_splat
}