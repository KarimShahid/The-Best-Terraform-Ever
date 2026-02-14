variable "region" {
  description = "AWS region to deploy into"
  type        = string
  default     = "us-east-1"
}

variable "vpc_name" {
  description = "VPC name prefix"
  type        = string
  default     = "my-vpc"
}

variable "vpc_cidr" {
  description = "VPC CIDR block"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnets" {
  description = "Map of public subnets per AZ (az = cidr)"
  type        = map(string)
  default = {
    "us-east-1a" = "10.0.1.0/24"
    # "us-east-1b" = "10.0.2.0/24"
  }
}

variable "private_subnets" {
  description = "Map of private subnets per AZ (az = cidr)"
  type        = map(string)
  # default = {
  #   "us-east-1a" = "10.0.11.0/24"
  #   "us-east-1b" = "10.0.12.0/24"
  # }
}

variable "enable_nat" {
  description = "Enable NAT gateways for private subnets"
  type        = bool
  default     = false
}

variable "default_tags" {
  description = "Common tags for all resources"
  type        = map(string)
  default = {
    Environment = "dev"
    Owner       = "karim"
  }
}


# Map of SGs to create per instance
variable "sg_map" {
  description = "Map of security groups to create. Key = instance name, value = object with ports list"
  type = map(object({
    ports = list(number)
  }))
}

# EC2 name
variable "ec2_name" {
  description = "EC2 instance name"
  type        = string
  default     = "demo-server"
}

variable "ec2_instances" {
  description = "Map of EC2 instances to create dynamically. Key is instance name"
  type = map(object({
    instance_type      = string
    subnet_id          = string
    key_name           = string
    volume_type        = string
    volume_size        = number
    tags               = map(string)
  }))
}