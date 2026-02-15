output "vpc_id" {
  value = aws_vpc.this.id
}

output "public_subnet_ids" {
  value = { for k, v in aws_subnet.public : k => v.id }
}

output "private_subnet_ids" {
  value = { for k, v in aws_subnet.private : k => v.id }
}

# output "public_subnets" {
#   value = aws_subnet.public
# }

output "nat_gateway_ids" {
  description = "Map of NAT Gateway IDs by AZ"
  value       = { for k, gw in aws_nat_gateway.this : k => gw.id }
}

output "nat_gateway_eip" {
  description = "Elastic IPs assigned to NAT Gateways per AZ"
  value       = { for k, v in aws_nat_gateway.this : k => v.nat_gateway_addresses[0].public_ip }
}