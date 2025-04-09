variable "vpc_tags" {
  description = ""
  type        = map(string)
}

variable "vpc_cidr_block" {
  description = ""
  type        = string
  default     = "10.0.0.0/16"
}

variable "is_enable_dns_support" {
  description = ""
  type        = bool
  default     = true
}

variable "is_enable_dns_hostnames" {
  description = ""
  type        = bool
  default     = true
}
