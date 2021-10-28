resource "google_pubsub_topic" "main" {
  name = var.name

  depends_on = [google_pubsub_schema.schema[0]]
  dynamic "schema_settings" {
    for_each = google_pubsub_schema.schema
    content {
      schema   = "projects/${var.project}/schemas/${google_pubsub_schema.schema[0].name}"
      encoding = "JSON"
    }
  }
}

# DLQs (@see https://cloud.google.com/pubsub/docs/handling-failures#setting-a-dead-letter-topic)
data "google_pubsub_topic" "dlq" {
  name = var.dlq_topic_name
}
