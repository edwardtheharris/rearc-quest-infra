# resource "aws_ecr_repository" "rearc-quest" {
#   name                 = "rearc/quest"
#   image_tag_mutability = "MUTABLE"

#   image_scanning_configuration {
#     scan_on_push = true
#   }
# }

# # data "aws_ecr_image" "rearc-quest" {
# #   repository_name = "rearc/quest"
# #   image_tag       = "latest"
# # }