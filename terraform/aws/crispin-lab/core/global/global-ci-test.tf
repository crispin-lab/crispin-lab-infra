variable "test_string_var" {
  description = "테스트용 문자열 변수"
  type        = string
  default     = "기본 문자열 값"
}

variable "test_number_var" {
  description = "테스트용 숫자 변수"
  type        = number
  default     = 100
}

variable "test_bool_var" {
  description = "테스트용 불리언 변수"
  type        = bool
  default     = true
}

variable "test_list_var" {
  description = "테스트용 리스트 변수"
  type        = list(string)
  default     = ["기본값1", "기본값2", "기본값3"]
}

variable "test_map_var" {
  description = "테스트용 맵 변수"
  type        = map(string)
  default = {
    name  = "test-name"
    group = "test-group"
  }
}

output "combined_output" {
  value = {
    string_value = var.test_string_var
    number_value = var.test_number_var
    bool_value   = var.test_bool_var
    list_values  = var.test_list_var
    map_values   = var.test_map_var
  }
}
