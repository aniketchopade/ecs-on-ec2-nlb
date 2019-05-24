### Security

resource "aws_security_group" "sample_alb_sg" {
  description = "controls access to the application ELB"

  vpc_id = var.vpc_id
  name   = "sample-ecs-lbsg"

  ingress {
    protocol    = "tcp"
    from_port   = 80
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"

    cidr_blocks = [
      "0.0.0.0/0",
    ]
  }
}

resource "aws_security_group" "sample_application_sg" {
  description = "controls direct access to application instances"
  vpc_id      = var.vpc_id
  name        = "sample-ecs-appsg"

  ingress {
    protocol  = "tcp"
    from_port = 22
    to_port   = 22

    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    protocol  = "tcp"
    from_port = 3333
    to_port   = 3333

    security_groups = [
      aws_security_group.sample_alb_sg.id,
    ]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

