output "all_tags" {
  description = "Tags"
  value       = local.tags
}

output "environment" {
  description = "Environment"
  value       = var.environment
}

output "team" {
  description = "Team"
  value       = var.team
}

output "project_name" {
  description = "Project Name"
  value       = var.project_name
}

output "git_project_url" {
  description = "Git Project URL"
  value       = var.git_project_url
}

output "extra_tags" {
  description = "Extra Tags"
  value       = var.extra_tags
}

output "vcs_provider" {
  description = "VCS Provider"
  value       = var.vcs_provider
}

output "gitlab_project_id" {
  description = "Gitlab Project ID"
  value       = var.gitlab_project_id == null ? "N/A" : var.gitlab_project_id
}
