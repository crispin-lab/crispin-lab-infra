resource "aws_kms_key" "this" {
  description             = var.kms_key_description
  deletion_window_in_days = var.kms_key_deletion_window_in_days
  enable_key_rotation     = var.kms_key_enable_key_rotation
  policy                  = var.kms_key_policy
  tags                    = var.kms_key_tags
}

