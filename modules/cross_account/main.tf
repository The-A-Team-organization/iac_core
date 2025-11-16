data "aws_iam_policy_document" "trust_jenkins" {
  statement {
    effect = "Allow"

    principals {
      type = "AWS"
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
  role       = "jenkins_role_stage" # example "jenkins_role_stage" !!!
  policy_arn = aws_iam_policy.jenkins_assume_terraform.arn
}
