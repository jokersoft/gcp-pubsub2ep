resource "google_pubsub_topic" "main" {
  name = var.name
}

# DLQs (@see https://cloud.google.com/pubsub/docs/handling-failures#setting-a-dead-letter-topic)
data "google_pubsub_topic" "dlq" {
  name = var.dlq_topic_name
}
