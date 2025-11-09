output "message_queue_arn" {
  description = "Arn of the messages queue"
  value       = aws_sqs_queue.messages_sqs.arn
}

output "scheduler_group_params" {
  description = "Params to schedule events in created group"
  value = {
    group_name   = aws_scheduler_schedule_group.messages_schedule_group.name
    group_arn    = aws_scheduler_schedule_group.messages_schedule_group.arn
    iam_role_arn = aws_iam_role.eventbridge_scheduler_execution_role.arn
  }
}