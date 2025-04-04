variable "default_aws_region" {
  description = "AWS default region"
  type        = string
  default     = "ap-northeast-2"
}

variable "client_id_list" {
  description = "List of client IDs to be trusted by the OIDC provider"
  type        = list(string)
  default     = ["sts.amazonaws.com"]
}

variable "thumbprint_list" {
  description = "List of thumbprints for the OIDC provider"
  type        = list(string)
  default     = ["6938fd4d98bab03faadb97b34396831e3780aea1"]
}
