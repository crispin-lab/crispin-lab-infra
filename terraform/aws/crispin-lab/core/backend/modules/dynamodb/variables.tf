variable "table_name" {
  description = "Name of the DynamoDB table for Terraform locks"
  type        = string
}

variable "devops_role" {
  description = "Name of the DevOps IAM role"
  type        = string
  default     = "DevOps"
}

variable "github_actions_role" {
  description = "Name of the GitHubActions IAM role"
  type        = string
  default     = "GitHubActions"
}

variable "kms_key_arn" {
  description = "ARN of the KMS key"
  type        = string
}
