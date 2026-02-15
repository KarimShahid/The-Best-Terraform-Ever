output "ec2_instance_ids" {
  value = module.ec2.instance_ids
}

output "ec2_private_ips" {
  value = module.ec2.private_ips
}

output "ec2_public_ips" {
  value = module.ec2.public_ips
}

output "ec2_eips" {
  value = module.ec2.eip
}

# output "ec2_instance_tags" {
#   value = module.ec2.instance_tags
# }

