output "arn" {
  description = "ARN of the GitHub OIDC provider"
  value       = aws_iam_openid_connect_provider.github_oidc.arn
}

output "url" {
  description = "URL of the GitHub OIDC provider"
  value       = aws_iam_openid_connect_provider.github_oidc.url
}
