variable "bucket_name" {
  description = "Name of the S3 bucket to store Terraform state"
  type        = string
}

variable "kms_key_description" {
  description = "Description for the KMS key"
  type        = string
  default     = "KMS key for S3 bucket encryption"
}

variable "kms_deletion_window_in_days" {
  description = "Duration in days after which the key is deleted after destruction"
  type        = number
  default     = 10
}

variable "kms_enable_key_rotation" {
  description = "Specifies whether key rotation is enabled"
  type        = bool
  default     = true
}

variable "bucket_policy" {
  description = "The assume role policy of the IAM role"
  type        = string
}

variable "logging_bucket_name" {
  description = "S3 bucket to store access logs"
  type        = string
}
