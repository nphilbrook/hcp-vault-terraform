data "aws_iam_policy" "demo_user_permissions_boundary" {
  name = "DemoUser"
}

resource "aws_iam_user" "vault_audit_logs" {
  name                 = "vault-audit-logs"
  permissions_boundary = data.aws_iam_policy.demo_user_permissions_boundary.arn
}

data "aws_iam_policy_document" "audit_logs_policy" {
  statement {
    effect = "Allow"
    sid    = "HCPVaultDedicatedLogsStreaming"
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

# resource "aws_iam_user" "vault_metrics" {
#   name = "vault-metrics"
# }

# data "aws_iam_policy_document" "metrics_policy" {
#   statement {
#     effect = "Allow"
#     sid    = "HCPVaultDedicatedMetricsStreaming"
#     actions = [
#       "cloudwatch:ListMetrics",
#       "cloudwatch:ListMetricStreams",
#       "cloudwatch:ListTagsForResource",
#       "cloudwatch:PutMetricData",
#       "cloudwatch:PutMetricStream",
#       "cloudwatch:TagResource"
#     ]
#     resources = ["*"]
#   }
# }

# resource "aws_iam_user_policy" "metrics_user_policy" {
#   name   = "metrics-user-policy"
#   user   = aws_iam_user.vault_metrics.name
#   policy = data.aws_iam_policy_document.metrics_policy.json
# }

# resource "aws_iam_access_key" "metrics_key" {
#   user = aws_iam_user.vault_metrics.name
# }
