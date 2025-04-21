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
| <a name="module_ap_northeast_2_kms_key"></a> [ap\_northeast\_2\_kms\_key](#module\_ap\_northeast\_2\_kms\_key) | ./modules/kms | n/a |
| <a name="module_cloudwatch_log_group"></a> [cloudwatch\_log\_group](#module\_cloudwatch\_log\_group) | ./modules/cloudwatch | n/a |
| <a name="module_crispin-lab-vpc"></a> [crispin-lab-vpc](#module\_crispin-lab-vpc) | ./modules/vpc | n/a |
| <a name="module_developer_iam_user_policy"></a> [developer\_iam\_user\_policy](#module\_developer\_iam\_user\_policy) | ./modules/iam-user-policy | n/a |
| <a name="module_developer_role"></a> [developer\_role](#module\_developer\_role) | ./modules/iam-role | n/a |
| <a name="module_developer_user"></a> [developer\_user](#module\_developer\_user) | ./modules/iam-user | n/a |
| <a name="module_devops_iam_user_policy"></a> [devops\_iam\_user\_policy](#module\_devops\_iam\_user\_policy) | ./modules/iam-user-policy | n/a |
| <a name="module_devops_role"></a> [devops\_role](#module\_devops\_role) | ./modules/iam-role | n/a |
| <a name="module_devops_user"></a> [devops\_user](#module\_devops\_user) | ./modules/iam-user | n/a |
| <a name="module_github_actions_iam_policy"></a> [github\_actions\_iam\_policy](#module\_github\_actions\_iam\_policy) | ./modules/iam-policy | n/a |
| <a name="module_github_actions_role"></a> [github\_actions\_role](#module\_github\_actions\_role) | ./modules/iam-role | n/a |
| <a name="module_github_oidc_provider"></a> [github\_oidc\_provider](#module\_github\_oidc\_provider) | ./modules/github-oidc-provider | n/a |
| <a name="module_iam_role_policy_attachment"></a> [iam\_role\_policy\_attachment](#module\_iam\_role\_policy\_attachment) | ./modules/iam-attachment | n/a |
| <a name="module_private_subnet"></a> [private\_subnet](#module\_private\_subnet) | ./modules/subnet | n/a |
| <a name="module_vpc_flow_log"></a> [vpc\_flow\_log](#module\_vpc\_flow\_log) | ./modules/flow-log | n/a |
| <a name="module_vpc_flow_log_role"></a> [vpc\_flow\_log\_role](#module\_vpc\_flow\_log\_role) | ./modules/iam-role | n/a |
| <a name="module_vpc_flow_log_role_policy"></a> [vpc\_flow\_log\_role\_policy](#module\_vpc\_flow\_log\_role\_policy) | ./modules/iam-policy | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/5.81.0/docs/data-sources/caller_identity) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_default_aws_region"></a> [default\_aws\_region](#input\_default\_aws\_region) | AWS default region | `string` | `"ap-northeast-2"` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->