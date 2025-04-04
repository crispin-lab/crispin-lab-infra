variable "default_aws_region" {
  description = "AWS default region"
  type        = string
  default     = "ap-northeast-2"
}

variable "iam_role_name" {
  description = "The name of the IAM role"
  type        = string
}

variable "assume_role_policy" {
  description = "The assume role policy of the IAM role"
  type        = string
}

variable "max_session_duration" {
  description = "The max session duration of the IAM role"
  type        = number
  default     = 3600
}
