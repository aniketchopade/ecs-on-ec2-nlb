## ECS

resource "aws_ecs_cluster" "main" {
  name = "sample-ecs-cluster"
}

data "template_file" "task_definition" {
  template = file("${path.module}/task-definition.json")

  vars = {
    image_url        = var.image_url
    container_name   = "sample-dc"
    log_group_region = var.aws_region
    log_group_name   = aws_cloudwatch_log_group.app.name
  }
}

resource "aws_ecs_task_definition" "sample_task" {
  family                = "sample-task"
  container_definitions = data.template_file.task_definition.rendered
}

resource "aws_ecs_service" "sample_service" {
  name            = "sample-service"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.sample_task.arn
  desired_count   = 4
  iam_role        = aws_iam_role.ecs_service.arn

  load_balancer {
    target_group_arn = aws_alb_target_group.sample_target_group.id
    container_name   = "sample-dc"
    container_port   = "3333"
  }

  depends_on = [aws_alb_listener.front_end]
}

