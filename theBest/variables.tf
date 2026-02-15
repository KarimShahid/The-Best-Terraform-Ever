variable "region" {
  description = "AWS region to deploy into"
  type        = string
  default     = "us-east-1"
}



# Map of SGs to create per instance
variable "sg_map" {
  description = "Map of security groups to create. Key = instance name, value = object with ports list"
  type = map(object({
    ports = list(number)
  }))
}


variable "ec2_instances" {
  description = "Map of EC2 instances to create dynamically. Key is instance name"
  type = map(object({
    instance_type = string
    subnet_id     = string
    key_name      = string
    volume_type   = string
    volume_size   = number
    tags          = map(string)
    subnet_key    = string
    subnet_type   = string # "public" or "private"
    associate_eip = bool   # true/false

  }))
}

variable "default_tags" {
  description = "Common tags for all resources"
  type        = map(string)
  default = {
    Environment = "dev"
    Owner       = "karim"
  }
}