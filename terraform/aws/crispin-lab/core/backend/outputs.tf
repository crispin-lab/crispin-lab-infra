output "s3_bucket_name" {
  description = "Name of the s3 bucket name"
  value       = module.terraform_state_bucket.bucket_name
}

output "dynamodb_table_name" {
  description = "Name of the DynamoDB table name"
  value       = module.terraform_lock_table.table_name
}
