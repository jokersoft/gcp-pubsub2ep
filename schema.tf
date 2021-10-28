resource "google_pubsub_schema" "schema" {
  count = length(var.schema_definition_string) > 0 ? 1 : 0
  name = var.name
  type = "AVRO"
  definition = var.schema_definition_string
}
