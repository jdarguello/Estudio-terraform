variable "users" {
  type = list(object({
    username = string
    role     = string
  }))
}