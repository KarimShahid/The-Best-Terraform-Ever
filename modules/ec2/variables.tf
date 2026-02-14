variable "name" {
  description = "Instance name"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "default_tags" {
  description = "Common tags"
  type        = map(string)
  default     = {}
}

variable "instances" {
  description = "Map of EC2 instances to create dynamically. Key is instance name"
  type = map(object({
    instance_type      = string
    subnet_id          = string
    key_name           = string
    volume_type        = string
    volume_size        = number
    tags               = map(string)
    security_group_ids = list(string)  # NEW: must pass SG IDs from root
  }))
}
