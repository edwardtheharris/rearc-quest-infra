resource "aws_ecr_repository" "rearc-quest" {
  depends_on = [
      aws_iam_user.xander
  ]
  name                 = "rearc/quest"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}