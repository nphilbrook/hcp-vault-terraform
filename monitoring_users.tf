data "hcp_project" "this" {}
data "hcp_organization" "this" {}
data "aws_caller_identity" "this" {}

data "aws_iam_policy" "demo_user_permissions_boundary" {
  name = "DemoUser"
}

resource "aws_iam_user" "vault_monitoring" {
  name                 = "vault-audit-logs"
  permissions_boundary = data.aws_iam_policy.demo_user_permissions_boundary.arn
  tags = {
    hcp-org-id     = data.hcp_organization.this.resource_id
    hcp-project-id = data.hcp_project.this.resource_id
  }
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
    resources = [
      "arn:aws:logs:*:${data.aws_caller_identity.this.account_id}:log-group:hashicorp/${data.hcp_organization.this.resource_id}/${data.hcp_project.this.resource_id}",
      "arn:aws:logs:*:${data.aws_caller_identity.this.account_id}:log-group:hashicorp/${data.hcp_organization.this.resource_id}/${data.hcp_project.this.resource_id}:*"
    ]
  }
}

data "aws_iam_policy_document" "metrics_policy" {
  statement {
    effect = "Allow"
    sid    = "HCPVaultDedicatedMetricsStreaming"
    actions = [
      "cloudwatch:ListMetrics",
      "cloudwatch:PutMetricData",
    ]
    resources = ["*"]
    condition {
      test     = "StringEquals"
      variable = "cloudwatch:namespace"
      values = [
        "hcp",
        "host"
      ]
    }
  }
}

resource "aws_iam_user_policy" "audit_logs_user_policy" {
  name   = "audit-logs-user-policy"
  user   = aws_iam_user.vault_monitoring.name
  policy = data.aws_iam_policy_document.audit_logs_policy.json
}

resource "aws_iam_user_policy" "metrics_user_policy" {
  name   = "audit-logs-user-policy"
  user   = aws_iam_user.vault_monitoring.name
  policy = data.aws_iam_policy_document.metrics_policy.json
}

resource "aws_iam_access_key" "monitoring" {
  user = aws_iam_user.vault_monitoring.name
}

# resource "aws_iam_user" "vault_metrics" {
#   name = "vault-metrics"
# }


# resource "aws_iam_user_policy" "metrics_user_policy" {
#   name   = "metrics-user-policy"
#   user   = aws_iam_user.vault_metrics.name
#   policy = data.aws_iam_policy_document.metrics_policy.json
# }

# resource "aws_iam_access_key" "metrics_key" {
#   user = aws_iam_user.vault_metrics.name
# }
