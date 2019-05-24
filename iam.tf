## IAM

resource "aws_iam_role" "ecs_service" {
  name = "sample-ecs-role"

  assume_role_policy = <<EOF
{
  "Version": "2008-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "ecs.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF

}

resource "aws_iam_role_policy" "ecs_service" {
  name = "sample-ecs-policy"
  role = aws_iam_role.ecs_service.id

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "ec2:Describe*",
        "elasticloadbalancing:DeregisterInstancesFromLoadBalancer",
        "elasticloadbalancing:DeregisterTargets",
        "elasticloadbalancing:Describe*",
        "elasticloadbalancing:RegisterInstancesWithLoadBalancer",
        "elasticloadbalancing:RegisterTargets"
      ],
      "Resource": "*"
    }
  ]
}
EOF

}

resource "aws_iam_instance_profile" "app" {
name = "sample-instance-profile"
role = aws_iam_role.app_instance.name
}

resource "aws_iam_role" "app_instance" {
name               = "sample-instance-role"
assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF

}

data "template_file" "instance_profile" {
template = file("${path.module}/instance-profile-policy.json")

vars = {
app_log_group_arn = aws_cloudwatch_log_group.app.arn
ecs_log_group_arn = aws_cloudwatch_log_group.ecs.arn
}
}

resource "aws_iam_role_policy" "instance" {
name = "RateshopEcsInstanceRole"
role = aws_iam_role.app_instance.id
policy = data.template_file.instance_profile.rendered
}

