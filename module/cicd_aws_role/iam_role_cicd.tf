data "aws_caller_identity" "current" {}


resource "aws_iam_role" "web_identity_role" {
  name = "web-identity-role"

  assume_role_policy = jsonencode({
    Version : "2012-10-17",
    Statement : [
      {
        Effect : "Allow",
        Principal : {
          Federated : "arn:aws:iam::${data.aws_caller_identity.current.account_id}:oidc-provider/${var.oidc_provider_url}"
        },
        Action : "sts:AssumeRoleWithWebIdentity",
        Condition : {
          StringEquals : {
            "${var.oidc_provider_url}:sub" : "YOUR_OIDC_SUBJECT"
          }
        }
      }
    ]
  })
}


resource "aws_iam_policy" "web_identity_policy" {
  name        = "web-identity-policy"
  description = "Policy for web identity role to access S3, ECS, and ECR with push permissions and more ECS flexibility"

  policy = jsonencode({
    Version : "2012-10-17",
    Statement : [
      # S3 Permissions
      {
        Effect : "Allow",
        Action : [
          "s3:ListBucket",
          "s3:GetObject",
          "s3:PutObject"
        ],
        Resource : "*"
      },
      # ECS Permissions (Flexible for Managing Tasks and Services)
      {
        Effect : "Allow",
        Action : [
          "ecs:RunTask",
          "ecs:StopTask",
          "ecs:StartTask",
          "ecs:UpdateService",
          "ecs:DescribeTasks",
          "ecs:DescribeTaskDefinition",
          "ecs:DescribeClusters",
          "ecs:ListClusters",
          "ecs:ListTasks",
          "ecs:ListServices",
          "ecs:DeregisterContainerInstance",
          "ecs:ListContainerInstances"
        ],
        Resource : "*"
      },
      # ECR Permissions (Pushing and Pulling Images)
      {
        Effect : "Allow",
        Action : [
          "ecr:GetAuthorizationToken",
          "ecr:BatchCheckLayerAvailability",
          "ecr:GetDownloadUrlForLayer",
          "ecr:BatchGetImage",
          "ecr:PutImage",
          "ecr:InitiateLayerUpload",
          "ecr:UploadLayerPart",
          "ecr:CompleteLayerUpload"
        ],
        Resource : "*"
      },
      # CloudWatch Logs for ECS Task Logging
      {
        Effect : "Allow",
        Action : [
          "logs:CreateLogStream",
          "logs:CreateLogGroup",
          "logs:PutLogEvents"
        ],
        Resource : "*"
      }
    ]
  })
}



resource "aws_iam_role_policy_attachment" "attach_policy" {
  role       = aws_iam_role.web_identity_role.name
  policy_arn = aws_iam_policy.web_identity_policy.arn
}


resource "aws_iam_openid_connect_provider" "oidc_provider" {
  url                   = var.oidc_provider_url
  client_id_list        = ["sts.amazonaws.com"]
  thumbprint_list       = ["d89e3bd43d5d909b47a18977aa9d5ce36cee184c"]
}
