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
| <a name="module_terraform_lock_table"></a> [terraform\_lock\_table](#module\_terraform\_lock\_table) | ./modules/dynamodb | n/a |
| <a name="module_terraform_state_bucket"></a> [terraform\_state\_bucket](#module\_terraform\_state\_bucket) | ./modules/s3 | n/a |
| <a name="module_terraform_state_log_bucket"></a> [terraform\_state\_log\_bucket](#module\_terraform\_state\_log\_bucket) | ./modules/s3 | n/a |

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
| <a name="output_dynamodb_table_name"></a> [dynamodb\_table\_name](#output\_dynamodb\_table\_name) | n/a |
| <a name="output_s3_bucket_name"></a> [s3\_bucket\_name](#output\_s3\_bucket\_name) | n/a |
<!-- END_TF_DOCS -->