# data "aws_iam_policy_document" "trust_jenkins" {
#   statement {
#     effect = "Allow"
#
#     principals {
#       type        = "AWS"
#       identifiers = [
#         var.jenkins_role_arn,
#         "arn:aws:iam::165015980393:user/ADMIN"
#       ]
#     }
#
#     actions = ["sts:AssumeRole"]
#   }
# }
#
# resource "aws_iam_role" "ci_deploy_role" {
#   name               = "${var.role_name}-${var.env}"
#   assume_role_policy = data.aws_iam_policy_document.trust_jenkins.json
#
#   tags = {
#     Environment = var.env
#     CreatedBy   = "Terraform"
#     Project     = "Illuminati"
#   }
# }
#
# data "aws_iam_policy_document" "default_perms" {
#   statement {
#     sid = "AllowEssentialOps"
#
#     actions = [
#       "ec2:Describe*",
#       "eks:DescribeCluster",
#       "eks:ListClusters",
#       "elasticloadbalancing:*",
#       "autoscaling:*",
#       "s3:GetObject",
#       "s3:PutObject",
#       "ssm:GetParameter",
#       "ssm:GetParameters",
#       "ecr:GetAuthorizationToken",
#       "ecr:BatchCheckLayerAvailability",
#       "ecr:GetDownloadUrlForLayer",
#       "ecr:BatchGetImage",
#       "ecr:PutImage"
#     ]
#
#     resources = ["*"]
#   }
# }
#
# resource "aws_iam_policy" "ci_deploy_policy" {
#   name   = "${var.role_name}-policy-${var.env}"
#   policy = data.aws_iam_policy_document.default_perms.json
# }
#
# resource "aws_iam_role_policy_attachment" "attach_ci_policy" {
#   role       = aws_iam_role.ci_deploy_role.name
#   policy_arn = aws_iam_policy.ci_deploy_policy.arn
# }
#
# output "ci_role_arn" {
#   value = aws_iam_role.ci_deploy_role.arn
# }
#







data "aws_iam_policy_document" "trust_jenkins" {
  statement {
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = [
        var.jenkins_role_arn
      ]
    }

    actions = ["sts:AssumeRole"]
  }
}


resource "aws_iam_role" "terraform_role_stage" {
  name               = "TerraformRoleStage"
  assume_role_policy = data.aws_iam_policy_document.trust_jenkins.json
}


resource "aws_iam_policy" "terraform_policy_stage" {
  name        = "TerraformPolicyStage"
  description = "Full access for Terraform in stage environment"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = "*"
        Resource = "*"
      }
    ]
  })
}


resource "aws_iam_role_policy_attachment" "attach_terraform_policy" {
  role       = aws_iam_role.terraform_role_stage.name
  policy_arn = aws_iam_policy.terraform_policy_stage.arn
}


resource "aws_iam_policy" "jenkins_assume_terraform" {
  name        = "JenkinsAssumeTerraform"
  description = "Allow Jenkins to assume Terraform role"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = "sts:AssumeRole"
        Resource = aws_iam_role.terraform_role_stage.arn
      }
    ]
  })
}


resource "aws_iam_role_policy_attachment" "attach_jenkins_policy" {
  role       = "jenkins_role_stage"  # example "jenkins_role_stage" !!!
  policy_arn = aws_iam_policy.jenkins_assume_terraform.arn
}
