output "service_name" {
  value = aws_ecs_service.main.name
}

output "task_definition_arn" {
  value = aws_ecs_task_definition.main.arn
}

output "cloudwatch_log_group" {
  value = aws_cloudwatch_log_group.main.name
}
