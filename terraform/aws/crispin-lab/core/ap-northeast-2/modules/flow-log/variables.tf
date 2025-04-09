variable "iam_role_arn" {
  description = "IAM role ARN used for publishing VPC flow logs"
  type        = string
}

variable "flow_log_destination" {
  description = "The destination (CloudWatch Logs or S3) for VPC flow logs"
  type        = string
}

variable "flow_log_destination_type" {
  description = "The type of flow log destination: cloud-watch-logs or s3"
  type        = string
}

variable "traffic_type" {
  description = "Type of traffic to log: ACCEPT, REJECT, or ALL"
  type        = string
  default     = "ALL"
}

variable "vpc_id" {
  description = "The ID of the VPC to enable flow logs for"
  type        = string
}
