
locals {
  default_tags = merge({
    "Environment"                                    = var.environment
    "ProjectName"                                    = var.project_name
    "Onwer${var.delimiter}Team"                      = var.team
    "Compliance${var.delimiter}TaggingSchemaVersion" = yamldecode(file("${path.module}/version.yaml"))["ModuleVersion"],
    },
    var.extra_tags
  )

  git_tags = merge(
    {
      "Origin${var.delimiter}GitProjectUrl" = var.git_project_url
    },
    var.vcs_provider == "gitlab" ? {
      "Origin${var.delimiter}GitLabProjectId" = var.gitlab_project_id
    } : {}
  )

  # Clean up tags by removing empty keys and values
  tags = {
    for k, v in merge(local.default_tags, local.git_tags) : k => v if length(k) > 0 && length(v) > 0
  }
}
