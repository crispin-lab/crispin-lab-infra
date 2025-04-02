terraform {
  required_version = ">= 1.0.0"
}

locals {
  test_string = "Hello Terraform"
  test_number = 42
  test_list   = ["item1", "item2", "item3"]
  test_map = {
    key1 = "value1"
    key2 = "value2"
    key3 = "value3"
    env  = "test"
  }
}

output "test_output_string" {
  value = local.test_string
}

output "test_output_number" {
  value = local.test_number
}

output "test_output_list" {
  value = local.test_list
}

output "test_output_map" {
  value = local.test_map
}
