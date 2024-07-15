variable "delimiter" {
  default     = ":"
  description = "Delimiter to be used between Prefix and key."
}

variable "git_project_url" {
  description = "Git project url"
  type        = string
  validation {
    condition     = var.git_project_url != null
    error_message = "Git project url must be provided."
  }
}

variable "team" {
  description = "Team name"
  type        = string
  validation {
    condition     = var.team != null
    error_message = "Team name must be provided."
  }
}

variable "environment" {
  description = "Environment name"
  type        = string
  validation {
    condition     = var.environment != null
    error_message = "Environment name must be provided."
  }
}

variable "extra_tags" {
  description = "Extra tags"
  type        = map(string)
  default     = {}
}

variable "project_name" {
  description = "Project name"
  type        = string
  validation {
    condition     = var.project_name != null
    error_message = "Project name must be provided."
  }
}
