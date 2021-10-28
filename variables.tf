variable "project" {
  description = "Google Cloud project"
  type        = string
}

variable "push_entry_point" {
  description = "Entry point to deliver payload to"
  type        = string
}

variable "labels" {
  description = "Labels to attach to objects"
  default     = {}
  type        = map(string)
}

variable "name" {
  description = "Name of the MAIN topic to send payload to"
  type        = string
}

variable "dlq_topic_name" {
  description = "Full name of an EXISTING DLQ topic"
  type        = string
}

variable "pubsub_service_account" {
  description = "e-mail of PubSub SA (should look like 'service-<project_id>@gcp-sa-pubsub.iam.gserviceaccount.com')"
  type        = string
  validation {
    condition = (
      length(var.pubsub_service_account) > 0
    )
    error_message = "PubSub SA must be set!"
  }
}

variable "publisher_service_account" {
  description = "e-mail of Publisher. For k8s services it can be workloads SA (may look like <project_id>-compute@developer.gserviceaccount.com)"
  type        = string
  validation {
    condition = (
      length(var.publisher_service_account) > 0
    )
    error_message = "Publisher SA must be set!"
  }
}

variable "retry_policy" {
  type = object({
    minimum_backoff = string
    maximum_backoff = string
  })
  default = {
    minimum_backoff = "5s"
    maximum_backoff = "60s"
  }
}

variable "max_delivery_attempts" {
  default = 5
  type    = number
}

variable "ack_deadline_seconds" {
  default = 10
  type    = number
}

variable "message_retention_duration" {
  default = "604800s"
  type    = string
}

variable "schema_definition_string" {
  description = "If set, must contain JSON AVRO validation schema for message payload."
  default = ""
  type    = string
}
