data "external" "git_remote_url" {
  for_each = var.inject_plan_directory_tag ? { terraform-plan = path.module } : {}

  program = [format("%s/scripts/tfrun.sh", each.value)]
}
