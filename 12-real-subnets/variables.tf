variable "servers" {
  type = list(object({
    ami       = string
    type      = string
    subnet_id = optional(string)
    root_block_device = object({
      size = number
      type = string
    })
    tags = map(string)
  }))
  default = []
}