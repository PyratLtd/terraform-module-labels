variable "context" {
  description = "base64 encoded JSON string for setting entire context at once."
  type        = string
  default     = null
}

variable "organisation" {
  description = "Organisation name ensuring unique naming of resources."
  type        = string
  default     = null
  nullable    = true
}

variable "location" {
  description = "Location name for deployed resources."
  type        = string
  default     = null
  nullable    = true
}

variable "tenant" {
  description = "Identifier for Azure tenant for Terraform state files."
  type        = string
  default     = null
}

variable "cloud" {
  description = "Which cloud is being deployed to, used for specific naming convention limitations."
  type        = string
  default     = null
}

variable "environment" {
  description = "Identifies role, eg. 'prod' or 'nonprod'."
  type        = string
  default     = null
}

variable "stage" {
  description = "Identifies stage of deployment, eg. 'prod', 'staging', 'test', 'dev', 'sandbox'"
  type        = string
  default     = null
}

variable "name" {
  description = "Name of the solution or component."
  type        = string
  default     = null
  nullable    = true
}

variable "attributes" {
  description = "ID Element, additional attributes (eg. `1`, `cluster`)"
  type        = list(string)
  default     = []
}

variable "delimiter" {
  description = "Delimiter to be used between ID elements."
  type        = string
  default     = "-"
}

variable "tags" {
  description = "Additional tags to include."
  type        = map(string)
  default     = {}
}

variable "label_order" {
  description = "The order in which the labels (ID elements) appear in the `id`."
  type        = list(string)
  default     = ["namespace", "environment", "stage", "name", "attributes"]
}

variable "use_tag_scripts" {
  description = "Inject tags generated from scripts"
  type        = bool
  default     = true
}
