resource "aws_iam_user_policy" "this" {
  policy = var.iam_user_policy
  user   = var.iam_user_policy_user
}
