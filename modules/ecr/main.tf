resource "aws_ecr_repository" "repos" {
  for_each = toset(var.repositories)

  name                 = "${each.value}_${var.env}"
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = true
  }

  tags = merge(var.common_tags, {
    Name = "${each.value}_${var.env}_repository"
  })
}


locals {
  repo_map = { for k, r in aws_ecr_repository.repos : k => r.repository_url }
}
