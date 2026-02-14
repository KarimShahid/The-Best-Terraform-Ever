variable "vpc_name" {
  description = "VPC name"
  type        = string
}

# variable "azs" {
#   description = "List of AZs"
#   type        = list(string)
# }

variable "vpc_cidr" {
  description = "VPC CIDR block"
  type        = string
}

variable "public_subnets" {
  description = "Public subnets as {az = cidr} map (omit for no public subnets)"
  type        = map(string)
  default     = {}
}

variable "private_subnets" {
  description = "Private subnets as {az = cidr} map (omit for no private subnets)"
  type        = map(string)
  default     = {}
}

variable "enable_nat" {
  type    = bool
  default = false
}

variable "default_tags" {
  description = "Common tags"
  type        = map(string)
  default     = {}
}