# Module to deliver payload to push EP with PubSub (and retries!).

![Reliably deliver message to EP with retries and DLQ](pubsub2ep.jpg)

Featuring:

- retries (circuit breaker)
- dead letter queue
- OIDC auth (secure: signed headers)

TODO:
- schema validation

## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| google | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| project | Google Cloud project | `string` | n/a | yes |
| push_entry_point | Entry point to deliver payload to | `string` | n/a | yes |
| name | Name of the MAIN topic to send payload to AND of subscription | `string` | n/a | yes |
| dlq_topic_name | Name of EXISTING DLQ topic | `string` | n/a` | yes |
| pubsub_service_account | e-mail of PubSub SA (should look like 'service-<project_id>@gcp-sa-pubsub.iam.gserviceaccount.com') | `string` | n/a | yes |
| publisher_service_account | e-mail of Publisher. For k8s services it can be workloads SA (may look like <project_id>-compute@developer.gserviceaccount.com) | `string` | n/a | yes |
| max_delivery_attempts | before sending to DLQ | `number` | 5 | no |
| ack_deadline_seconds | before marking as "unacknowledged" | `number` | 10 | no |
| message_retention_duration | message retention duration (max 604800s) | `string` | 604800s | no |
| retry_policy | @see [terraform object definition](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/pubsub_subscription#retry_policy) | `list(object)` | { minimum_backoff = "5s" maximum_backoff = "60s" } | no |
| labels | Labels to attach to all related objects | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| url | Cloud Function EP |
| version | Version of build (likely, short commit) |
