locals {
  empty_context = {
    enabled             = true
    namespace           = null
    tenant              = null
    environment         = null
    stage               = null
    name                = null
    delimiter           = null
    cloud               = null
    organisation        = null
    attributes          = []
    tags                = {}
    additional_tag_map  = {}
    regex_replace_chars = null
    label_order         = []
    id_length_limit     = null
    label_key_case      = null
    label_value_case    = null
    descriptor_formats  = {}
    labels_as_tags      = ["unset"]
  }

  context_encoded = coalesce(var.context, base64encode(jsonencode(local.empty_context)))
  context         = jsondecode(base64decode(local.context_encoded))

  # Rename the below context
  context_rename_output = {
    namespace = "location"
  }

  context_rename_input = {
    for k, v in local.context_rename_output : v => k
  }

  context_input = {
    for k, v in local.context : (try(local.context_rename_input[lower(k)], k)) => v
  }

  tags_alter_values = {
    Name         = var.name
    Organisation = local.organisation
  }

  output_tags_renamed = merge({
    for k, v in module.labels.tags : (title(try(local.context_rename_output[lower(k)], k))) => v
  }, local.tags_alter_values)

  output_fields = {
    cloud        = try(coalesce(var.cloud, local.context_input.cloud), local.empty_context.cloud)
    organisation = try(coalesce(local.organisation, local.context_input.organisation), local.empty_context.organisation)
  }

  output_tags = {
    for k, v in local.output_tags_renamed : k => v if v != null
  }

  context_output = merge(
    {
      for k, v in module.labels.context : (try(local.context_rename_output[k], k)) => v
    },
    local.output_fields
  )

  output = merge(
    {
      for k, v in module.labels : (try(local.context_rename_output[k], k)) => v
    },
    { context = local.context_output },
    local.output_fields
  )

  # tags = merge(var.tags, { for k, v in data.external.git_remote_url : k => basename(v.result.repo) })
  tags = merge(var.tags, var.inject_plan_directory_tag ? { terraform-plan = basename(abspath(path.root)) } : {})

  location_map = {
    # Azure Europe
    uksouth            = "uks"
    ukwest             = "ukw"
    northeurope        = "eun"
    westeurope         = "euw"
    austriaeast        = "ate"
    belgiumcentral     = "bec"
    denmarkeast        = "dke"
    finlandcentral     = "fic"
    francecentral      = "frc"
    germanwestcentral  = "dew"
    greececentral      = "grc"
    italynorth         = "itn"
    norwayeast         = "noe"
    polandcentral      = "plc"
    spaincentral       = "esc"
    swedencentral      = "sec"
    switzerlandcentral = "chc"

    # Azure North America
    centralus      = "usc"
    eastus         = "use"
    eastus2        = "ue2"
    eastus3        = "ue3"
    northcentralus = "unc"
    southcentralus = "usx"
    westcentralus  = "uwc"
    westus         = "usw"
    westus2        = "uw2"
    westus3        = "uw3"
    canadacentral  = "cac"
    canadaeast     = "cae"

    # AWS Europe
    eu-central-1 = "euc1"
    eu-central-2 = "euc2"
    eu-north-1   = "eun1"
    eu-west-1    = "euw1"
    eu-west-2    = "euw2"
    eu-west-3    = "euw3"
    eu-south-1   = "eus1"
    eu-south-2   = "eus2"

    # AWS North America
    us-east-1    = "use1"
    us-east-2    = "use2"
    us-west-1    = "usw1"
    us-west-2    = "usw2"
    ca-central-1 = "cac1"

    # GCP Europe
    europe-west1      = "euw1"
    europe-west2      = "euw2"
    europe-west3      = "euw3"
    europe-west4      = "euw4"
    europe-west6      = "euw6"
    europe-west8      = "euw8"
    europe-west9      = "euw9"
    europe-west12     = "euwc"
    europe-north1     = "eun1"
    europe-central2   = "euc2"
    europe-southwest1 = "esw1"

    # GCP North America
    us-west1                = "usw1"
    us-west2                = "usw2"
    us-west3                = "usw3"
    us-west4                = "usw4"
    us-central1             = "usc1"
    us-east1                = "use1"
    us-east4                = "use4"
    us-east5                = "use5"
    us-south1               = "uss1"
    northamerica-northeast1 = "can1"
    northamerica-northeast2 = "can2"
  }

  name_attributes = join(var.delimiter, [
    for k in [local.organisation, var.name] : k if k != null
  ])

  organisation = try(coalesce(var.organisation, local.context_input.organisation), null)
  name         = try(coalesce(local.name_attributes, local.context_input.name), local.empty_context.name)
  location     = try(try(local.location_map[var.location], var.location), null)
  namespace    = try(try(local.location_map[local.context_input.location], local.context_input.location), local.empty_context.namespace)
}
