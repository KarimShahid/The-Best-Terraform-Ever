variable "region" {
  description = "AWS region to deploy into"
  type        = string
  default     = "us-east-1"
}

variable "name" {
  description = "VPC name prefix"
  type        = string
  default     = "my-vpc"
}

variable "azs" {
  description = "List of availability zones"
  type        = list(string)
  default     = ["us-east-1a"]
  # default     = ["us-east-1a", "us-east-1b"]
}

variable "vpc_cidr" {
  description = "VPC CIDR block"
  type        = string
  default = "10.0.0.0/16"
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
  default = {
    "us-east-1a" = "10.0.11.0/24"
    # "us-east-1b" = "10.0.12.0/24"
  }
}

variable "enable_nat" {
  description = "Enable NAT gateways for private subnets"
  type        = bool
  default     = false
}

variable "tags" {
  description = "Common tags for all resources"
  type        = map(string)
  default = {
    Environment = "dev"
    Owner       = "karim"
  }
}
