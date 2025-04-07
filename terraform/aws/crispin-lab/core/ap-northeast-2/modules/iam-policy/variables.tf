variable "iam_policy_name" {
  description = "Name of the IAM policy"
  type        = string
}

variable "iam_policy_description" {
  description = "Description of the IAM policy"
  type        = string
}

variable "iam_policy" {
  description = "IAM policy as a JSON string"
  type        = string
}
