variable "log_group_name" {
  description = ""
  type        = string
}

variable "retention_days" {
  description = ""
  type        = number
  default     = 14
}

variable "kms_key_id" {
  description = ""
  type        = string
}
