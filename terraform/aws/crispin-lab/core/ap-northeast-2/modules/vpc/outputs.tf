output "id" {
  description = "Id of the VPC"
  value       = aws_vpc.this.id
}

output "name_prefix" {
  description = "Prefix name of the VPC"
  value       = aws_vpc.this.tags["Name"]
}
