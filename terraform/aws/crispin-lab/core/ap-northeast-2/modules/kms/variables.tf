variable "kms_key_description" {
  description = "Description for the KMS key"
  type        = string
}

variable "kms_key_deletion_window_in_days" {
  description = "Duration in days after which the key is deleted after destruction"
  type        = number
  default     = 7
}

variable "kms_key_enable_key_rotation" {
  description = "Specifies whether key rotation is enabled"
  type        = bool
  default     = true
}

variable "kms_key_policy" {
  description = "Policy of the KMS"
  type        = string
}

variable "kms_key_tags" {
  description = "Tag of the KMS"
  type        = map(string)
}
