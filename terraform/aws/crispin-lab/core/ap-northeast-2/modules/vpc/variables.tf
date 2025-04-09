variable "vpc_tags" {
  description = "Tags of the VPC"
  type        = map(string)
}

variable "vpc_cidr_block" {
  description = "CIDR of the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "is_enable_dns_support" {
  description = "Enable DNS resolution in the VPC"
  type        = bool
  default     = true
}

variable "is_enable_dns_hostnames" {
  description = "Enable DNS hostnames for instances in the VPC"
  type        = bool
  default     = true
}
