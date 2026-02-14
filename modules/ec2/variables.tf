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

# variable "ports" {
#   description = "List of additional TCP ports to open in the security group"
#   type        = list(number)
#   default     = []
# }

# variable "instances" {
#   description = "Map of EC2 instances to create dynamically. Key is instance name."
#   type = map(object({
#     instance_type      = string               # EC2 instance type
#     subnet_id          = string               # Subnet ID to launch the instance in
#     key_name           = string               # SSH Key pair name
#     volume_type        = string               # Root volume type (gp2, gp3, etc.)
#     volume_size        = number               # Root volume size in GB
#     tags               = map(string)          # Optional tags
#   }))
# } 

variable "instances" {
  description = "Map of EC2 instances to create dynamically. Key is instance name."
  type = map(object({
    instance_type      = string
    subnet_id          = string
    key_name           = string
    volume_type        = string
    volume_size        = number
    tags               = map(string)
    ports              = list(number)  # NEW: ports for this instance
  }))
}


