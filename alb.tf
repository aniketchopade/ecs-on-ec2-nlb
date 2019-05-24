## ALB
resource "aws_alb_target_group" "sample_target_group" {
  name     = "sample-ecs-tg"
  port     = 3333
  protocol = "TCP"
  vpc_id   = var.vpc_id
}

resource "aws_lb" "main" {
  load_balancer_type = "network"
  name               = "sample-alb-ecs"
  subnets            = [var.public_subnet_2, var.public_subnet_1]
}

resource "aws_alb_listener" "front_end" {
  load_balancer_arn = aws_lb.main.id
  port              = "3333"
  protocol          = "TCP"

  default_action {
    target_group_arn = aws_alb_target_group.sample_target_group.id
    type             = "forward"
  }
}

