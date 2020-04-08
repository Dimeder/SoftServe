provider "aws" {
  region = var.region
}

terraform {
  backend "s3" {
    bucket = "dimeder"
    key    = "terraform/demo-3/demo-3.tfstate"
    region = "us-east-1"
  }
}

data "aws_iam_policy" "ecr_power_user" {
  arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryPowerUser"
}

resource "aws_ecr_repository" "flask" {
  name                 = "flask_application"
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = true
  }
}

resource "aws_ecr_lifecycle_policy" "flask" {
  repository = aws_ecr_repository.flask.id
  policy = file("./templates/ecr.policy.tpl")
}

resource "aws_ecr_repository_policy" "flask" {
  repository = aws_ecr_repository.flask.name
  policy = templatefile("./templates/iam.policy.tpl", { github_user_arn = aws_iam_user.github.arn })
}

resource "aws_iam_group" "github" {
  name = "github"
  path = "/"
}

resource "aws_iam_group_policy_attachment" "github" {
  group      = aws_iam_group.github.id
  policy_arn = data.aws_iam_policy.ecr_power_user.id
}

resource "aws_iam_user" "github" {
  name = "github"
  path = "/"
  force_destroy = true

  tags = {
    type = "service"
  }
}

resource "aws_iam_access_key" "github" {
  user    = aws_iam_user.github.id
}

resource "aws_iam_user_group_membership" "github" {
  user   = aws_iam_user.github.id
  groups = [aws_iam_group.github.id]
}





