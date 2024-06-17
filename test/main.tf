module "top_level" {
  source       = "../."
  organisation = "pyrat"
  tenant       = "pyratpayg"
}

module "labels" {
  source       = "../."
  name         = "app"
  location     = "eu-west-2"
  organisation = "pyrat"
  environment  = "nonprod"
  stage        = "sandbox"
  cloud        = "aws"
  context      = module.top_level.context
}

module "sub_labels" {
  source     = "../."
  name       = "cache"
  attributes = ["1"]
  context    = module.labels.context
}

output "labels" {
  value = module.labels
}

output "sub_labels" {
  value = module.sub_labels
}
