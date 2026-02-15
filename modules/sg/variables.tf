variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "sg_map" {
  description = "Map of SGs to create. Key = instance name, value = object with ports list"
  type = map(object({
    ports = list(number)
  }))
}

variable "default_tags" {
  description = "Common tags"
  type        = map(string)
  default     = {}
}