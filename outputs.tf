output "context" {
  value       = base64encode(jsonencode(local.output.context))
  description = "Label context"
}

# output "context_debug" {
#   value       = local.output.context
#   description = "label context decoded"
# }

# output "context_input_debug" {
#   value       = local.context
#   description = "label context decoded"
# }

output "id" {
  value       = (local.output.stage == local.output.environment) ? replace(local.output.id, join(local.output.delimiter, [local.output.environment, local.output.stage]), local.output.environment) : local.output.id
  description = "ID string"
}

output "organisation" {
  value       = local.output.organisation
  description = "Organisation"
}

output "location" {
  value       = local.output.location
  description = "Location"
}

output "tenant" {
  value       = local.output.tenant
  description = "Tenant"
}

output "cloud" {
  value       = local.output.cloud
  description = "Cloud"
}

output "environment" {
  value       = local.output.environment
  description = "Environment"
}

output "name" {
  value       = local.output.name
  description = "Name"
}

output "stage" {
  value       = local.output.stage
  description = "Stage"
}

output "delimiter" {
  value       = local.output.delimiter
  description = "Delimiter between `namespace`, `tenant`, `environment`, `stage`, `name` and `attributes`"
}

output "attributes" {
  value       = local.output.attributes
  description = "List of attributes"
}

output "tags" {
  value       = local.output_tags
  description = "Tag map"
}

output "label_order" {
  value       = local.output.label_order
  description = "The naming order actually used to create the ID"
}
