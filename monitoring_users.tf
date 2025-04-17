resource "aws_iam_user" "vault_audit_logs" {
  name = "vault-audit-logs"
}

data "aws_iam_policy_document" "audit_logs_policy" {
  statement {
    effect = "Allow"
    actions = [
      "logs:PutLogEvents",
      "logs:DescribeLogStreams",
      "logs:DescribeLogGroups",
      "logs:CreateLogStream",
      "logs:CreateLogGroup",
      "logs:TagLogGroup"
    ]
    resources = ["*"]
  }
}

resource "aws_iam_user_policy" "audit_logs_user_policy" {
  name   = "audit-logs-user-policy"
  user   = aws_iam_user.vault_audit_logs.name
  policy = data.aws_iam_policy_document.audit_logs_policy.json
}

resource "aws_iam_access_key" "audit_logs_key" {
  user = aws_iam_user.vault_audit_logs.name
}
