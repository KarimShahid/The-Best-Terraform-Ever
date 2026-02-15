# EC2 instance IDs
output "instance_ids" {
  description = "IDs of all created EC2 instances"
  value       = { for k, v in aws_instance.this : k => v.id }
}

# Private IPs
output "private_ips" {
  description = "Private IPs of all EC2 instances"
  value       = { for k, v in aws_instance.this : k => v.private_ip }
}

# Public IPs (EIPs)
output "public_ips" {
  description = "Public Elastic IPs of all EC2 instances"
  value       = { for k, v in aws_eip.this : k => v.public_ip }
}

output "eip" {
  description = "EIP of the EC2 instance"
  value       = { for k, v in aws_eip.this : k => v.public_ip }
}

# Tags of instances (optional)
output "instance_tags" {
  description = "Tags assigned to each instance"
  value       = { for k, v in aws_instance.this : k => v.tags }
}
