# Needed to let Subscription sign push request
# @see oidc_token section in pubsub-subscriptions.tf
resource "google_project_iam_member" "pubsub_binding" {
  role   = "roles/iam.serviceAccountTokenCreator"
  member = join(":", ["serviceAccount", var.pubsub_service_account])
}

# service account from: https://cloud.google.com/pubsub/docs/handling-failures#granting_forwarding_permissions
data "google_iam_policy" "subscriber" {
  binding {
    role = "roles/pubsub.subscriber"
    members = [
      # allowing DLQ to "subscribe" to Subscription of original Topic
      join(":", ["serviceAccount", var.pubsub_service_account]),
    ]
  }
}

data "google_iam_policy" "publisher" {
  binding {
    role = "roles/pubsub.publisher"
    members = [
      # allowing Subscription to publish to DLQ
      join(":", ["serviceAccount", var.pubsub_service_account]),
      # allowing GKE service to publish to PubSub topic
      join(":", ["serviceAccount", var.publisher_service_account]),
    ]
  }
}

resource "google_pubsub_subscription_iam_policy" "subscriber" {
  subscription = google_pubsub_subscription.sub.id
  policy_data  = data.google_iam_policy.subscriber.policy_data
}

resource "google_pubsub_topic_iam_policy" "dlq_publisher" {
  topic       = var.dlq_topic_name
  policy_data = data.google_iam_policy.publisher.policy_data
}
