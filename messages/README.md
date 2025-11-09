<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.7, < 2.0.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 5.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_role.eventbridge_scheduler_execution_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.eventbridge_scheduler_sqs_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_scheduler_schedule_group.messages_schedule_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/scheduler_schedule_group) | resource |
| [aws_sqs_queue.messages_sqs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sqs_queue) | resource |
| [aws_sqs_queue.messages_sqs_dlq](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sqs_queue) | resource |
| [aws_sqs_queue_policy.messages_sqs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sqs_queue_policy) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_sqs_queue_name"></a> [sqs\_queue\_name](#input\_sqs\_queue\_name) | Name to use for the SQS queue | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_message_queue_arn"></a> [message\_queue\_arn](#output\_message\_queue\_arn) | Arn of the messages queue |
| <a name="output_scheduler_group_params"></a> [scheduler\_group\_params](#output\_scheduler\_group\_params) | Params to schedule events in created group |
<!-- END_TF_DOCS -->