## CloudWatch Logs

resource "aws_cloudwatch_log_group" "ecs" {
  name = "sample-ecs-group/ecs-agent"
}

## CloudWatch Logs for DC app

resource "aws_cloudwatch_log_group" "app" {
  name = "sample-ecs-group/app"
}
