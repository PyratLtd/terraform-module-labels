# Raw labels to correctly name state container
module "labels" {
  source = "github.com/cloudposse/terraform-null-label.git?ref=0.25.0"

  environment = try(coalesce(var.environment, local.context_input.environment), local.empty_context.environment)
  stage       = try(coalesce(var.stage, local.context_input.stage), local.empty_context.stage)
  name        = try(coalesce(local.name, local.context_input.name), local.empty_context.name)
  attributes  = try(coalesce(var.attributes, local.context_input.attributes), local.empty_context.attributes)
  namespace   = try(coalesce(local.location, local.namespace), local.empty_context.namespace)
  delimiter   = try(coalesce(var.delimiter, local.context_input.delimiter), local.empty_context.delimeter)
  tenant      = try(coalesce(var.tenant, local.context_input.tenant), local.empty_context.tenant)
  context     = local.context_input
  label_order = try(coalesce(var.label_order, local.context_input.label_order), local.empty_context.label_order)
  tags        = try(coalesce(var.tags, local.context_input.tags), local.empty_context.tags)
}
