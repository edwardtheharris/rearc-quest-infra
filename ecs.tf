resource "aws_ecs_cluster" "default" {
  depends_on = [
    aws_instance.ecs-2a,
    aws_instance.ecs-2b,
    aws_instance.ecs-2c,
    aws_instance.ecs-2d
  ]
  name = "default"
}
