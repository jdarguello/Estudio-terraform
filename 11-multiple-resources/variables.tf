variable "count_subnets" {
  type    = number
  default = 2
}

variable "ec2_count" {
  type    = number
  default = 1
}

variable "ec2_list" {
  type = list(object({
    ami  = string
    type = string
  }))

  default = []

  validation {
    condition = alltrue(
        [for instancia in var.ec2_list : contains(["t2.micro", "t3.micro"], instancia.type) && contains(["ubuntu", "nginx"], instancia.ami)],
    )
    error_message = "Las instancias deben ser 't2.micro' o 't3.micro'. Las amis deben ser 'ubuntu' o 'nginx'"
  }
}


variable "ec2_map" {
  type = map(object({
    ami = string
    type = string 
    subnet_index = number
  }))

  default = {}

  validation {
    condition = alltrue(
      [
        for key, obj in var.ec2_map : 
        contains(["t3.micro", "t2.micro"], obj.type) && 
        contains(["ubuntu", "nginx"], obj.ami) &&
        obj.subnet_index > 0 && obj.subnet_index <= 3
      ]
    )
    error_message = "El tipo de instancia debe ser 't2.micro' o 't3.micro'. La ami debe ser 'ubuntu' o 'nginx'. El indice del subnet debe estar entre 0 < index <= 3."
  }
}