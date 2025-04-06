variable "bucket_name" {
  description = "Name of the S3 bucket to store Terraform state"
  type        = string
}

variable "kms_key_arn" {
  description = "ARN of the KMS key"
  type        = string
}

variable "bucket_policy" {
  description = "The assume role policy of the IAM role"
  type        = string
}

variable "logging_bucket_name" {
  description = "S3 bucket to store access logs"
  type        = string
}
