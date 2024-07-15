module "tags" {
  source = "../."

  team            = "MyTeam"
  environment     = "MyEnvironment"
  project_name    = var.project_name
  git_project_url = var.git_project_url
}
