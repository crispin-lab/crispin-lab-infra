variable "kms_key_description" {
  description = ""
  type        = string
}

variable "kms_key_deletion_window_in_days" {
  description = ""
  type        = number
  default     = 7
}

variable "kms_key_enable_key_rotation" {
  description = ""
  type        = bool
  default     = true
}

variable "kms_key_policy" {
  description = ""
  type        = string
}

variable "kms_key_tags" {
  description = ""
  type        = map(string)
}
