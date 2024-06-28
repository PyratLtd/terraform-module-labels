# data "external" "git_remote" {
#   for_each = var.inject_plan_directory_tag ? { enabled = true } : {}

#   program = [
#     "sh",
#     "-c",
#     "echo { \\\"remote\\\": \\\"$(git remote)\\\" }"
#   ]
# }

# data "external" "git_remote_url" {
#   for_each = var.inject_plan_directory_tag ? { terraform-plan = "enabled" } : {}

#   program = [
#     "sh",
#     "-c",
#     format(
#       "echo { \\\"repo\\\": \\\"$(git remote get-url %s)\\\" }",
#       data.external.git_remote[each.value].result.remote
#     )
#   ]
# }
