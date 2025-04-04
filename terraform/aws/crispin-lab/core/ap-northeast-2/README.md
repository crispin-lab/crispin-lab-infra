<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | 5.81.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.81.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_developer_role"></a> [developer\_role](#module\_developer\_role) | ./modules/iam-role | n/a |
| <a name="module_developer_user"></a> [developer\_user](#module\_developer\_user) | ./modules/iam-user | n/a |
| <a name="module_devops_role"></a> [devops\_role](#module\_devops\_role) | ./modules/iam-role | n/a |
| <a name="module_devops_user"></a> [devops\_user](#module\_devops\_user) | ./modules/iam-user | n/a |
| <a name="module_github_actions_role"></a> [github\_actions\_role](#module\_github\_actions\_role) | ./modules/iam-role | n/a |
| <a name="module_github_oidc_provider"></a> [github\_oidc\_provider](#module\_github\_oidc\_provider) | ./modules/github-oidc-provider | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/5.81.0/docs/data-sources/caller_identity) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_default_aws_region"></a> [default\_aws\_region](#input\_default\_aws\_region) | AWS default region | `string` | `"ap-northeast-2"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_github_actions_role_arn"></a> [github\_actions\_role\_arn](#output\_github\_actions\_role\_arn) | ARN of the GitHub Actions IAM role |
<!-- END_TF_DOCS -->