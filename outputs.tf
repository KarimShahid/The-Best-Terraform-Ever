output "vpc_id" {
  description = "The ID of the created VPC"
  value       = module.vpc.vpc_id
}

output "public_subnet_ids" {
  description = "IDs of the public subnets"
  value       = module.vpc.public_subnet_ids
}

output "private_subnet_ids" {
  description = "IDs of the private subnets"
  value       = module.vpc.private_subnet_ids
}

output "public_subnets" {
  description = "All public subnet resources"
  value       = module.vpc.public_subnets
}

output "ec2_instance_ids" {
  value = module.ec2.instance_ids
}

output "ec2_private_ips" {
  value = module.ec2.private_ips
}

output "ec2_public_ips" {
  value = module.ec2.public_ips
}

output "ec2_instance_tags" {
  value = module.ec2.instance_tags
}

