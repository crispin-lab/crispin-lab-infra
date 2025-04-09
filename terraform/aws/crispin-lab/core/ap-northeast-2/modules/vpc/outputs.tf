output "id" {
  description = ""
  value       = aws_vpc.this.id
}

output "name_prefix" {
  description = ""
  value       = aws_vpc.this.tags["Name"]
}
