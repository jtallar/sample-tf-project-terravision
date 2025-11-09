output "message_queue_arn" {
  description = "Arn of the messages queue"
  value       = module.scheduled_messages.message_queue_arn
}
