resource "aws_ecs_cluster" "default" {
  name = "default"
}

resource "aws_ecs_service" "rearc" {
  name            = "rearc"
  cluster         = aws_ecs_cluster.default.id
  task_definition = aws_ecs_task_definition.quest.arn
  desired_count   = 4
  depends_on      = [aws_iam_role.ecsServiceRole]
}

resource "aws_ecs_task_definition" "quest" {
  family = "quest"
  container_definitions = jsonencode([
    {
      name      = "quest"
      image     = "629354604262.dkr.ecr.us-west-2.amazonaws.com/rearc/quest:latest"
      cpu       = 100
      memory    = 128
      essential = true
      environment = [
        {
          name  = "SECRET_WORD"
          value = var.secret_word
        }
      ]
      portMappings = [
        {
          containerPort = 3000
          hostPort      = 3000
        }
      ]
    }
  ])
}