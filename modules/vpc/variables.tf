variable "azs" {
  description = "List of AZs"
  type        = list(string)
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
