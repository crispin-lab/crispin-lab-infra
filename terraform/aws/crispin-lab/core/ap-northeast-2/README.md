<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | 5.81.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_developer_user"></a> [developer\_user](#module\_developer\_user) | ./modules/iam | n/a |
| <a name="module_devops_user"></a> [devops\_user](#module\_devops\_user) | ./modules/iam | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_default_aws_region"></a> [default\_aws\_region](#input\_default\_aws\_region) | AWS default region | `string` | `"ap-northeast-2"` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->