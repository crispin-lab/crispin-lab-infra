output "github_actions_role_arn" {
  description = "ARN of the GitHub Actions IAM role"
  value       = module.github_actions_role.arn
}
