resource "aws_ecs_cluster" "default" {
  depends_on = [
    aws_instance.ecs-2a,
    aws_instance.ecs-2b,
    aws_instance.ecs-2c,
    aws_instance.ecs-2d
  ]
  name = "default"
}

resource "aws_ecs_service" "rearc" {
  name            = "rearc"
  cluster         = aws_ecs_cluster.default.id
  task_definition = aws_ecs_task_definition.quest.arn
  desired_count   = 4
  iam_role        = aws_iam_role.ecsServiceRole.arn
  depends_on      = [aws_iam_role.ecsServiceRole]
}

resource "aws_ecs_task_definition" "quest" {
  family = "quest"
  container_definitions = jsonencode([
    {
      name      = "quest"
      image     = data.aws_ecr_image.rearc-quest.id
      cpu       = 10
      memory    = 512
      essential = true
      portMappings = [
        {
          containerPort = 3000
          hostPort      = 3000
        }
      ]
    }
  ])
}