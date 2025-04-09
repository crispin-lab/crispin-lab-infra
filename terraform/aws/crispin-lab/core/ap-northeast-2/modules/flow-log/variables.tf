variable "iam_role_arn" {
  description = ""
  type        = string
}

variable "flow_log_destination" {
  description = ""
  type        = string
}

variable "flow_log_destination_type" {
  description = ""
  type        = string
}

variable "traffic_type" {
  description = ""
  type        = string
  default     = "ALL"
}

variable "vpc_id" {
  description = ""
  type        = string
}
