output "arn" {
  description = "ARN of the Cloudwatch"
  value       = aws_cloudwatch_log_group.this.arn
  sensitive   = true
}
