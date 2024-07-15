
locals {
  default_tags = merge({
    "Environment"                         = var.environment
    "Origin${var.delimiter}GitProjectUrl" = var.git_project_url
    "ProjectName"                         = var.project_name
    "Onwer${var.delimiter}Team"           = var.team

    "Compliance${var.delimiter}TaggingSchemaVersion" = yamldecode(file("${path.module}/version.yaml"))["ModuleVersion"],
    },
    var.extra_tags
  )


  # Clean up tags by removing empty keys and values
  tags = { for k, v in local.default_tags : k => v if length(k) > 0 && length(v) > 0 }
}
