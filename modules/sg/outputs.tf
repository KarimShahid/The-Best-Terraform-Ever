output "sg_ids" {
  description = "IDs of all security groups created"
  value       = { for k, v in aws_security_group.this : k => v.id }
}
