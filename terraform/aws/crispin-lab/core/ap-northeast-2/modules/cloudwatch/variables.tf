variable "log_group_name" {
  description = "The name of the CloudWatch log group"
  type        = string
}

variable "retention_days" {
  description = "Number of days to retain log events in CloudWatch Logs"
  type        = number
  default     = 14
}

variable "kms_key_id" {
  description = "The KMS key ID used to encrypt the log group"
  type        = string
}
