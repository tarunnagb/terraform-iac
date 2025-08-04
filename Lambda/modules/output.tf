output "private_subnet_ids_1a" {
  value = data.aws_subnets.app-private.ids
}

output "private_subnet_ids_1b" {
  value = data.aws_subnets.app-private-2.ids
}


