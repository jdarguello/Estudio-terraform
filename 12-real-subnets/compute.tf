locals {
  commonTags = {
    MappedBy   = "Terraform"
    CostCenter = "1234"
  }

  amis = {
    ubuntu       = data.aws_ami.ubuntu.id
    amazon_linux = "ami-02457590d33d576c3"
  }

  servers = {
    for count in range(length(var.servers)) :
    var.servers[count].tags.Name =>
    merge(var.servers[count], {
      subnet_id = data.aws_subnets.eks_subnets.ids[
        length(var.servers)/length(data.aws_subnets.eks_subnets) < 1 ?
        count : count
      ]
    })
  }
}

output "servers" {
    value = local.servers
}

resource "aws_instance" "name" {
  for_each      = local.servers
  ami           = local.amis[each.value.ami]
  instance_type = each.value.type

  subnet_id = each.value.subnet_id

  root_block_device {
    volume_size = each.value.root_block_device.size
    volume_type = each.value.root_block_device.type
  }

  tags = merge(local.commonTags, each.value.tags)
}