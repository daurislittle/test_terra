// modules/iam/main.tf

resource "aws_iam_role" "this" {
    name                = var.role_name
    assume_role_policy  = var.assume_role_policy
    tags                = var.tags
}

locals {
  s3_resources = concat(
    var.s3_bucket_arns,
    [for arn in var.s3_bucket_arns : "${arn}/*"]
  )
}

data "aws_iam_policy_document" "api_access" {
    statement {
      effect = "Allow"
      actions = ["execute-api:Invoke"]
      resources = var.api_resources
    }
}

data "aws_iam_policy_document" "s3_rw" {
    statement {
      effect = "Allow"
      actions = [
        "s3:ListBucket",
        "s3:GetObject",
        "s3:PutObject",
        "s3:DeleteObject"
      ]
      resources = local.s3_resources
    }
}

data "aws_iam_policy_document" "logging_and_monitoring" {
    statement {
      effect = "Allow"
      actions = [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents",
        "cloudwatch:PutMetricData"
      ]
      resources = ["*"]
    }
}

data "aws_iam_policy_document" "cloudtrail" {
  statement {
    effect = "Allow"
    actions = [
      "cloudtrail:DescribeTrails",
      "cloudtrail:GetTrailStatus",
      "cloudtrail:StartLogging",
      "cloudtrail:StopLogging"
    ]
    resources = ["*"]
  }
}

data "aws_iam_policy_document" "secret_management" {
  statement {
    effect = "Allow"
    actions = [
      "secretsmanager:GetSecretValue",
      "secretsmanager:DescribeSecret"
    ]
  }
}

resource "aws_iam_role_policy" "api_access" {
  name = "${var.role_name}-api-access"
  role = aws_iam_role.this.name
  policy = data.aws_iam_policy_document.api_access.json
}

resource "aws_iam_role_policy" "s3_rw" {
  name = "${var.role_name}-s3-rw"
  role = aws_iam_role.this.name
  policy = data.aws_iam_policy_document.s3_rw.json
}

resource "aws_iam_role_policy" "logging_and_monitoring" {
  name = "${var.role_name}-logging-monitoring"
  role = aws_iam_role.this.name
  policy = data.aws_iam_policy_document.logging_and_monitoring.json
}

resource "aws_iam_role_policy" "cloudtrail" {
  name = "${var.role_name}-cloudtrail"
  role = aws_iam_role.this.name
  policy = data.aws_iam_policy_document.cloudtrail
}

resource "aws_iam_role_policy" "secret_management" {
  name = "${var.role_name}-secret-management"
  role = aws_iam_role.this.name
  policy = data.aws_iam_policy_document.secret_management
}

resource "aws_iam_instance_profile" "this" {
  name = local.instance_profile_name
  role = aws_iam_role.this.name
  tags = var.tags
}