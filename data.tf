locals {
  script_tags = {
    terraform-plan = {
      script = "git-repo.sh"
      key    = "repo"
    }
    terraform-version = {}
  }

  script_tags_result = {
    for k, v in {
      for tk, tv in data.external.tags : tk => try(tv.result[try(local.script_tags[tk].key, tk)], null)
    } : k => v if v != null
  }
}

data "external" "tags" {
  for_each = var.use_tag_scripts ? local.script_tags : {}

  program = [
    format(
      "%s/scripts/%s",
      path.module,
      try(each.value.script, format("%s.sh", each.key))
    )
  ]
}
