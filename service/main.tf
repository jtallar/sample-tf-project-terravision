module "scheduled_messages" {
  source = "../messages"

  sqs_queue_name = "scheduled-events"
}
