#Compute

data "template_file" "userdata" {
  template = file("${path.module}/userdata.tpl")
  vars = {
    ecs_cluster_name = aws_ecs_cluster.main.name
  }
}

#Launches EC2 autoscale grooup for DC
resource "aws_autoscaling_group" "sample_app_dc" {
  name                 = "sample-autoscale-group-dc"
  vpc_zone_identifier  = [var.subnet_2, var.subnet_1]
  min_size             = var.asg_min
  max_size             = var.asg_max
  desired_capacity     = var.asg_desired
  launch_configuration = aws_launch_configuration.sample_app_dc.name
}

resource "aws_launch_configuration" "sample_app_dc" {
  security_groups = [var.security_group_2, var.security_group_1]

  key_name                    = var.key_name
  image_id                    = var.ami
  instance_type               = var.instance_type
  iam_instance_profile        = aws_iam_instance_profile.app.id
  user_data                   = data.template_file.userdata.rendered
  associate_public_ip_address = true

  lifecycle {
    create_before_destroy = true
  }
}

