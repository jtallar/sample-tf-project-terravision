# This module is used to create an new SQS queue that
# receives messages from an EventBridge Scheduler group

# Create DLQ for SQS queue
resource "aws_sqs_queue" "messages_sqs_dlq" {
  name = "${var.sqs_queue_name}-dlq"
}

# Create SQS queue where scheduled messages will be sent to
resource "aws_sqs_queue" "messages_sqs" {
  name = var.sqs_queue_name

  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.messages_sqs_dlq.arn
    maxReceiveCount     = 4
  })
}

# Create Scheduler group to group any event bridge schedulers for Rocket
resource "aws_scheduler_schedule_group" "messages_schedule_group" {
  name = var.sqs_queue_name
}

# Attach a policy to SQS that allows the scheduler group to send messages to this queue
resource "aws_sqs_queue_policy" "messages_sqs" {
  queue_url = aws_sqs_queue.messages_sqs.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "Allow-EventBridge-Scheduler-SendMessage"
        Effect = "Allow"
        Principal = {
          Service = "scheduler.amazonaws.com"
        }
        Action   = "SQS:SendMessage"
        Resource = aws_sqs_queue.messages_sqs.arn
        Condition = {
          ArnLike = {
            "aws:SourceArn" = "${aws_scheduler_schedule_group.messages_schedule_group.arn}/*"
          }
        }
      }
    ]
  })
}

# Create an IAM role that will be assumed by the scheduler when executing a schedule
resource "aws_iam_role" "eventbridge_scheduler_execution_role" {
  name = "EventBridgeSchedulerExecutionRole-${aws_scheduler_schedule_group.messages_schedule_group.name}"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "scheduler.amazonaws.com"
        }
      }
    ]
  })
}

# Assign a policy to the IAM role that allows the scheduler to send messages to SQS
resource "aws_iam_role_policy" "eventbridge_scheduler_sqs_policy" {
  name = "EventBridgeSchedulerSQSPolicy"
  role = aws_iam_role.eventbridge_scheduler_execution_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "sqs:SendMessage"
        ]
        Resource = aws_sqs_queue.messages_sqs.arn
      }
    ]
  })
}
