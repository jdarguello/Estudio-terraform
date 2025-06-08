variable "users" {
  type = list(object({
    username = string
    role     = string
  }))
}

variable "subnets" {
  type = list(object({
    cidr_block        = string
    availability_zone = string
    vpc_id            = string
    id                = string
  }))
}