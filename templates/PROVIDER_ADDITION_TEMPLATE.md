# VCS Provider Addition Template

This template provides step-by-step instructions for adding support for a new Version Control System (VCS) provider to the terraform-module-tags module.

## Overview

Currently supported providers:
- GitHub (default)
- GitLab

This guide will help you add support for additional providers like:
- Bitbucket
- Azure DevOps
- Gitea
- And others...

## Prerequisites

Before adding a new provider, ensure you have:
- [ ] Read the [CONTRIBUTING.md](../CONTRIBUTING.md) guide
- [ ] Familiarity with Terraform module development
- [ ] Understanding of the new provider's CI/CD environment variables
- [ ] Tested the changes locally

## Step-by-Step Guide

### Step 1: Update `variables.tf`

Add a new variable for provider-specific identifiers (if needed).

**Example for Bitbucket:**

```hcl
variable "bitbucket_repository_uuid" {
  default     = null
  description = "Bitbucket repository UUID"
  type        = string
}
```

**Example for Azure DevOps:**

```hcl
variable "azure_devops_project_id" {
  default     = null
  description = "Azure DevOps project ID"
  type        = string
}
```

### Step 2: Update VCS Provider Validation

Update the `vcs_provider` variable validation to include the new provider:

**Current validation:**
```hcl
variable "vcs_provider" {
  description = "VCS provider"
  type        = string
  default     = "github"
  validation {
    condition     = var.vcs_provider == "github" || var.vcs_provider == "gitlab"
    error_message = "VCS provider must be github or gitlab. Default is github."
  }
}
```

**Updated validation (example for Bitbucket):**
```hcl
variable "vcs_provider" {
  description = "VCS provider"
  type        = string
  default     = "github"
  validation {
    condition     = var.vcs_provider == "github" || var.vcs_provider == "gitlab" || var.vcs_provider == "bitbucket"
    error_message = "VCS provider must be github, gitlab, or bitbucket. Default is github."
  }
}
```

### Step 3: Update `main.tf` Locals Block

Add the new provider's tags to the `git_tags` local using a conditional expression.

**Current `git_tags` block:**
```hcl
locals {
  git_tags = merge(
    {
      "Origin${var.delimiter}GitProjectUrl" = var.git_project_url
    },
    var.vcs_provider == "gitlab" ? {
      "Origin${var.delimiter}GitLabProjectId" = var.gitlab_project_id
    } : {}
  )
}
```

**Updated `git_tags` block (example for Bitbucket):**
```hcl
locals {
  git_tags = merge(
    {
      "Origin${var.delimiter}GitProjectUrl" = var.git_project_url
    },
    var.vcs_provider == "gitlab" ? {
      "Origin${var.delimiter}GitLabProjectId" = var.gitlab_project_id
    } : {},
    var.vcs_provider == "bitbucket" ? {
      "Origin${var.delimiter}BitbucketRepositoryUuid" = var.bitbucket_repository_uuid
    } : {}
  )
}
```

### Step 4: Update `outputs.tf`

Add outputs for the new provider-specific variables (if needed).

**Example for Bitbucket:**
```hcl
output "bitbucket_repository_uuid" {
  description = "Bitbucket Repository UUID"
  value       = var.bitbucket_repository_uuid
}
```

### Step 5: Update README.md Documentation

Add usage examples for the new provider.

**Example for Bitbucket:**

```markdown
### Bitbucket

#### Terraform files

`main.tf`

```hcl
module "tags" {
  source  = "CloudAtScale/tags/null"
  version = "x.x.x"

  vcs_provider = "bitbucket"

  git_project_url          = var.git_project_url
  bitbucket_repository_uuid = var.bitbucket_repository_uuid
  team                     = "MyAwesomeTeam"
  environment              = "MyAwesomeEnvironment"
  project_name             = "MyAwesomeProject"

  extra_tags = {
      "extra_tag_1" = "extra_tag_1_value"
      "extra_tag_2" = "extra_tag_2_value"
  }
}
```

`variables.tf`

```hcl
variable "git_project_url" {
  type        = string
  description = "The URL of the git project"
}

variable "bitbucket_repository_uuid" {
  type        = string
  description = "The UUID of the bitbucket repository"
}
```

For Bitbucket Pipelines, use:

```yaml
    definitions:
      steps:
        - step: &build
            name: 'Build'
            script:
              - echo "Building..."
    - step: *build
    script:
      - export TF_VAR_git_project_url=$BITBUCKET_GIT_HTTP_ORIGIN
      - export TF_VAR_bitbucket_repository_uuid=$BITBUCKET_REPO_UUID
      - terraform apply
```

#### Terraform Docs

Update the inputs table:

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| ... | ... | ... | ... | ... |
| <a name="input_bitbucket_repository_uuid"></a> [bitbucket\_repository\_uuid](#input\_bitbucket\_repository\_uuid) | Bitbucket repository UUID | `string` | `null` | no |

Update the outputs table:

| Name | Description |
|------|-------------|
| ... | ... |
| <a name="output_bitbucket_repository_uuid"></a> [bitbucket\_repository\_uuid](#output\_bitbucket\_repository\_uuid) | Bitbucket Repository UUID |
```

## Complete Example: Adding Bitbucket Support

Here's a complete example of all changes needed to add Bitbucket support:

### 1. `variables.tf` Changes

```hcl
# Add new variable
variable "bitbucket_repository_uuid" {
  default     = null
  description = "Bitbucket repository UUID"
  type        = string
}

# Update validation
variable "vcs_provider" {
  description = "VCS provider"
  type        = string
  default     = "github"
  validation {
    condition     = var.vcs_provider == "github" || var.vcs_provider == "gitlab" || var.vcs_provider == "bitbucket"
    error_message = "VCS provider must be github, gitlab, or bitbucket. Default is github."
  }
}
```

### 2. `main.tf` Changes

```hcl
locals {
  git_tags = merge(
    {
      "Origin${var.delimiter}GitProjectUrl" = var.git_project_url
    },
    var.vcs_provider == "gitlab" ? {
      "Origin${var.delimiter}GitLabProjectId" = var.gitlab_project_id
    } : {},
    var.vcs_provider == "bitbucket" ? {
      "Origin${var.delimiter}BitbucketRepositoryUuid" = var.bitbucket_repository_uuid
    } : {}
  )

  # Rest of the file remains unchanged...
}
```

### 3. `outputs.tf` Changes

```hcl
output "bitbucket_repository_uuid" {
  description = "Bitbucket Repository UUID"
  value       = var.bitbucket_repository_uuid
}
```

## Testing Your Changes

### 1. Local Testing

Create a test Terraform configuration:

```hcl
module "tags" {
  source = "../."

  vcs_provider = "bitbucket"
  git_project_url = "https://bitbucket.org/myorg/myrepo"
  bitbucket_repository_uuid = "{repository-uuid}"
  team = "MyTeam"
  environment = "dev"
  project_name = "MyProject"
}
```

Run the following commands:

```bash
terraform init
terraform validate
terraform plan
terraform apply
```

### 2. Verify Outputs

```bash
terraform output -json
```

Expected output should include:

```json
{
  "all_tags": {
    "Environment": "dev",
    "Onwer:Team": "MyTeam",
    "Origin:BitbucketRepositoryUuid": "{repository-uuid}",
    "Origin:GitProjectUrl": "https://bitbucket.org/myorg/myrepo",
    "ProjectName": "MyProject",
    "Compliance:TaggingSchemaVersion": "1.0.0"
  },
  "bitbucket_repository_uuid": "{repository-uuid}",
  ...
}
```

### 3. Automated Testing

Update or create tests in the `tests/` directory:

**`tests/main.tf`**
```hcl
module "tags" {
  source = "../."

  vcs_provider = "bitbucket"
  git_project_url = "https://bitbucket.org/test/repo"
  bitbucket_repository_uuid = "{test-uuid}"
  team = "TestTeam"
  environment = "test"
  project_name = "TestProject"
}
```

Run tests:
```bash
cd tests
terraform init
terraform validate
terraform plan
```

## CI/CD Integration Examples

### GitHub Actions

Already supported - see README.md

### GitLab CI

Already supported - see README.md

### Bitbucket Pipelines

```yaml
pipelines:
  default:
    - step:
        name: 'Terraform Apply'
        script:
          - export TF_VAR_git_project_url=$BITBUCKET_GIT_HTTP_ORIGIN
          - export TF_VAR_bitbucket_repository_uuid=$BITBUCKET_REPO_UUID
          - terraform init
          - terraform apply -auto-approve
```

### Azure DevOps

```yaml
variables:
  TF_VAR_git_project_url: $(Build.Repository.Uri)
  TF_VAR_azure_devops_project_id: $(System.TeamProjectId)

steps:
- script: |
    terraform init
    terraform apply -auto-approve
```

## Common CI/CD Environment Variables

| Provider | Project URL Variable | Project ID Variable | Repository UUID Variable |
|----------|---------------------|---------------------|-------------------------|
| GitHub | `{{ github.repository }}` | N/A | N/A |
| GitLab | `$CI_PROJECT_URL` | `$CI_PROJECT_ID` | N/A |
| Bitbucket | `$BITBUCKET_GIT_HTTP_ORIGIN` | N/A | `$BITBUCKET_REPO_UUID` |
| Azure DevOps | `$(Build.Repository.Uri)` | `$(System.TeamProjectId)` | N/A |
| Gitea | `$GITEA_REPO_URL` | `$GITEA_REPO_ID` | N/A |

## Checklist Before Submitting

- [ ] Added provider-specific variable(s) to `variables.tf`
- [ ] Updated `vcs_provider` validation in `variables.tf`
- [ ] Added provider-specific tags to `git_tags` local in `main.tf`
- [ ] Added provider-specific output(s) to `outputs.tf` (if applicable)
- [ ] Added usage example to README.md
- [ ] Updated Terraform Docs tables in README.md
- [ ] Tested locally with `terraform validate`
- [ ] Created test case in `tests/` directory
- [ ] Added CI/CD integration example
- [ ] Updated this template with any new patterns (if applicable)

## Pull Request Guidelines

When submitting your PR:

1. **Title:** `feat: Add support for [Provider Name]`
2. **Description:** Include:
   - Link to provider's documentation
   - List of CI/CD environment variables used
   - Testing performed
   - Screenshots of example usage (if applicable)
3. **Labels:** `enhancement`, `provider`
4. **Related Issues:** Reference any related issues

## Questions?

- Open an issue using the "Provider Request" template
- Start a discussion for questions
- Check existing issues for similar provider requests

## Additional Resources

- [Terraform Module Documentation](https://www.terraform.io/docs/language/modules/develop/index.html)
- [Provider CI/CD Documentation](https://docs.github.com/en/actions/learn-github-actions/variables)
- [CONTRIBUTING.md](../CONTRIBUTING.md)
