resource "aws_iam_policy" "this" {
  name        = var.iam_policy_name
  description = var.iam_policy_description
  policy      = var.iam_policy
}
