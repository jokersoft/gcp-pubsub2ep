# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/pubsub_subscription
resource "google_pubsub_subscription" "sub" {
  name  = var.name
  topic = var.name

  enable_message_ordering    = false
  ack_deadline_seconds       = var.ack_deadline_seconds
  message_retention_duration = var.message_retention_duration
  retain_acked_messages      = true

  retry_policy {
    minimum_backoff = var.retry_policy.minimum_backoff
    maximum_backoff = var.retry_policy.maximum_backoff
  }

  dead_letter_policy {
    dead_letter_topic     = var.dlq_topic_name
    max_delivery_attempts = var.max_delivery_attempts
  }

  push_config {
    push_endpoint = var.push_entry_point

    # https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/pubsub_subscription#oidc_token
    # https://cloud.google.com/pubsub/docs/reference/rest/v1/projects.subscriptions#oidctoken
    oidc_token {
      service_account_email = var.publisher_service_account
      audience              = var.push_entry_point
    }

    attributes = {
      x-goog-version = "v1"
    }
  }
}
