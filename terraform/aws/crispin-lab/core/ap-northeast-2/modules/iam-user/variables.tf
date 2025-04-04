variable "default_aws_region" {
  description = "AWS default region"
  type        = string
  default     = "ap-northeast-2"
}

variable "user_name" {
  description = "The name of the IAM user"
  type        = string
}
