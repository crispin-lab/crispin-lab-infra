<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

No providers.

## Modules

No modules.

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_test_bool_var"></a> [test\_bool\_var](#input\_test\_bool\_var) | 테스트용 불리언 변수 | `bool` | `true` | no |
| <a name="input_test_list_var"></a> [test\_list\_var](#input\_test\_list\_var) | 테스트용 리스트 변수 | `list(string)` | <pre>[<br/>  "기본값1",<br/>  "기본값2",<br/>  "기본값3"<br/>]</pre> | no |
| <a name="input_test_map_var"></a> [test\_map\_var](#input\_test\_map\_var) | 테스트용 맵 변수 | `map(string)` | <pre>{<br/>  "group": "test-group",<br/>  "name": "test-name"<br/>}</pre> | no |
| <a name="input_test_number_var"></a> [test\_number\_var](#input\_test\_number\_var) | 테스트용 숫자 변수 | `number` | `100` | no |
| <a name="input_test_string_var"></a> [test\_string\_var](#input\_test\_string\_var) | 테스트용 문자열 변수 | `string` | `"기본 문자열 값"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_combined_output"></a> [combined\_output](#output\_combined\_output) | n/a |
<!-- END_TF_DOCS -->