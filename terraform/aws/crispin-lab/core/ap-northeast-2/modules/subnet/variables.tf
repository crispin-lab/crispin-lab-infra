variable "vpc_id" {
  description = "ID of the VPC"
  type        = string
}

variable "subnet_cidr_block" {
  description = "CIDR block for the subnet"
  type        = string
}

variable "subnet_tags" {
  description = "Tags of subnet"
  type        = map(string)
}

variable "subnet_availability_zone" {
  description = "Availability zone for the subnet"
  type        = string
}
variable "is_map_public_ip_on_launch" {
  description = "Whether to assign public IP on instance launch"
  type        = bool
  default     = false
}
