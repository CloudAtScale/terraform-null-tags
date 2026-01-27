# Module Extension Template

This template provides step-by-step instructions for extending the terraform-module-tags module with new tags, features, or functionality.

## Overview

The terraform-module-tags module is built with extensibility in mind. The current structure uses:
- **Local blocks** for organizing and merging tags
- **Conditional expressions** for provider-specific logic
- **Tag cleanup** to remove empty keys and values
- **Validations** for input validation

This guide will help you add:
- New standard tags
- Conditional tags based on variables
- Provider-specific tags
- New features and functionality

## Prerequisites

Before extending the module, ensure you have:
- [ ] Read the [CONTRIBUTING.md](../CONTRIBUTING.md) guide
- [ ] Familiarity with Terraform module development
- [ ] Understanding of Terraform locals, variables, and validation
- [ ] Tested the changes locally
- [ ] Reviewed existing patterns in `main.tf` and `variables.tf`

## Current Module Structure

### Understanding the `locals` Block

The module uses three main local blocks in `main.tf`:

```hcl
locals {
  # Standard required tags
  default_tags = merge({
    "Environment"                                    = var.environment
    "ProjectName"                                    = var.project_name
    "Onwer${var.delimiter}Team"                      = var.team
    "Compliance${var.delimiter}TaggingSchemaVersion" = yamldecode(file("${path.module}/version.yaml"))["ModuleVersion"],
    },
    var.extra_tags
  )

  # Provider-specific tags (conditional)
  git_tags = merge(
    {
      "Origin${var.delimiter}GitProjectUrl" = var.git_project_url
    },
    var.vcs_provider == "gitlab" ? {
      "Origin${var.delimiter}GitLabProjectId" = var.gitlab_project_id
    } : {}
  )

  # Final cleanup - removes empty keys and values
  tags = {
    for k, v in merge(local.default_tags, local.git_tags) : k => v if length(k) > 0 && length(v) > 0
  }
}
```

### Key Patterns to Follow

1. **Tag Naming Convention:** Use the format `"Prefix${var.delimiter}KeyName"` for namespaced tags
2. **Tag Organization:** Group related tags in separate local blocks
3. **Conditional Tags:** Use ternary operators (`condition ? {value} : {}`) for optional tags
4. **Tag Cleanup:** Always use the final cleanup pattern to remove empty values
5. **Variable Validation:** Add validation blocks to ensure data quality

## Step-by-Step Guide

### Step 1: Plan Your Extension

Before coding, determine:
- What tags/features you want to add
- Whether they are required or optional
- If they need validation
- Whether they should be conditional (based on other variables)

**Questions to Ask:**
- Is this a standard tag (always required) or optional?
- Should this tag be conditional based on a variable value?
- Does this tag need input validation?
- Should this tag be merged with `extra_tags` or separate?

### Step 2: Add Variables (if needed)

If your extension requires new input variables, add them to `variables.tf`.

**Example: Adding a Cost Center Tag**

```hcl
variable "cost_center" {
  description = "Cost center code for chargeback"
  type        = string
  default     = null

  validation {
    condition     = var.cost_center == null || can(regex("^[A-Z]{2}-[0-9]{4}$", var.cost_center))
    error_message = "Cost center must be in format XX-0000 (e.g., US-1234)."
  }
}
```

**Example: Adding a Conditional Feature Flag**

```hcl
variable "enable_compliance_tags" {
  description = "Enable enhanced compliance tags"
  type        = bool
  default     = false
}
```

### Step 3: Extend the `locals` Block

Update the appropriate local block in `main.tf` based on your extension type.

#### Option A: Adding Standard Required Tags

Add to the `default_tags` block:

```hcl
locals {
  default_tags = merge({
    "Environment"                                    = var.environment
    "ProjectName"                                    = var.project_name
    "Onwer${var.delimiter}Team"                      = var.team
    "Compliance${var.delimiter}TaggingSchemaVersion" = yamldecode(file("${path.module}/version.yaml"))["ModuleVersion"],

    # New standard tag
    "CostCenter"                                     = var.cost_center
    },
    var.extra_tags
  )
}
```

#### Option B: Adding Conditional Tags

Create a new local block or extend an existing one:

```hcl
locals {
  # Existing default_tags...

  # New compliance tags (conditional)
  compliance_tags = var.enable_compliance_tags ? {
    "Compliance${var.delimiter}DataClassification" = var.data_classification
    "Compliance${var.delimiter}PII"                = var.contains_pii ? "Yes" : "No"
  } : {}
}
```

#### Option C: Adding Provider-Specific Tags

Extend the `git_tags` block or create a new provider-specific block:

```hcl
locals {
  # Existing git_tags...

  # New provider-specific tags
  aws_tags = var.cloud_provider == "aws" ? {
    "Cloud${var.delimiter}Provider"          = "AWS"
    "Cloud${var.delimiter}Region"            = var.aws_region
    "Cloud${var.delimiter}AccountId"         = var.aws_account_id
  } : {}
}
```

#### Option D: Update the Final Merge

Update the final `tags` local to include your new block:

```hcl
locals {
  tags = {
    for k, v in merge(
      local.default_tags,
      local.git_tags,
      local.compliance_tags,  # Add your new block here
      local.aws_tags          # And here
    ) : k => v if length(k) > 0 && length(v) > 0
  }
}
```

### Step 4: Add Outputs (if applicable)

If you want to expose your new variables or computed values as outputs, add them to `outputs.tf`:

```hcl
output "cost_center" {
  description = "Cost center code"
  value       = var.cost_center
}

output "compliance_tags_enabled" {
  description = "Whether compliance tags are enabled"
  value       = var.enable_compliance_tags
}
```

### Step 5: Update Documentation

Update the README.md with:
1. New variable descriptions in the inputs table
2. New output descriptions in the outputs table
3. Usage examples showing the new feature

**Example Usage Section:**

```markdown
### Cost Center Tagging

You can add cost center information to your resources:

\`\`\`hcl
module "tags" {
  source  = "CloudAtScale/tags/null"
  version = "x.x.x"

  cost_center = "US-1234"
  team        = "MyAwesomeTeam"
  environment = "production"
  project_name = "MyAwesomeProject"
}
\`\`\`

### Enhanced Compliance Tags

Enable enhanced compliance tagging:

\`\`\`hcl
module "tags" {
  source  = "CloudAtScale/tags/null"
  version = "x.x.x"

  enable_compliance_tags = true
  data_classification    = "Confidential"
  contains_pii           = true

  team        = "MyAwesomeTeam"
  environment = "production"
  project_name = "MyAwesomeProject"
}
\`\`\`
```

## Complete Extension Examples

### Example 1: Adding Business Unit Tags

#### 1. Add Variables (`variables.tf`)

```hcl
variable "business_unit" {
  description = "Business unit owning the resource"
  type        = string
  default     = null

  validation {
    condition     = var.business_unit == null || length(var.business_unit) > 0
    error_message = "Business unit must not be empty if provided."
  }
}

variable "department" {
  description = "Department within the business unit"
  type        = string
  default     = null
}
```

#### 2. Extend `main.tf`

```hcl
locals {
  default_tags = merge({
    "Environment"                                    = var.environment
    "ProjectName"                                    = var.project_name
    "Onwer${var.delimiter}Team"                      = var.team
    "Compliance${var.delimiter}TaggingSchemaVersion" = yamldecode(file("${path.module}/version.yaml"))["ModuleVersion"],
    },
    var.extra_tags
  )

  # New business unit tags
  business_tags = merge(
    var.business_unit != null ? {
      "Business${var.delimiter}Unit" = var.business_unit
    } : {},
    var.department != null ? {
      "Business${var.delimiter}Department" = var.department
    } : {}
  )

  # Existing git_tags...

  # Updated final merge
  tags = {
    for k, v in merge(
      local.default_tags,
      local.git_tags,
      local.business_tags
    ) : k => v if length(k) > 0 && length(v) > 0
  }
}
```

#### 3. Add Outputs (`outputs.tf`)

```hcl
output "business_unit" {
  description = "Business unit"
  value       = var.business_unit
}

output "department" {
  description = "Department"
  value       = var.department
}
```

### Example 2: Adding Environment-Specific Tags

#### 1. Add Variables (`variables.tf`)

```hcl
variable "auto_environment" {
  description = "Automatically detect environment from known patterns"
  type        = bool
  default     = false
}

variable "environment_patterns" {
  description = "Map of patterns to environment names"
  type        = map(string)
  default     = {
    "dev"  = "development"
    "prod" = "production"
    "stg"  = "staging"
  }
}
```

#### 2. Extend `main.tf`

```hcl
locals {
  # Detect environment from project name if auto_environment is enabled
  detected_environment = var.auto_environment ? (
    contains(keys(var.environment_patterns), var.environment) ?
      var.environment_patterns[var.environment] :
      var.environment
  ) : var.environment

  default_tags = merge({
    "Environment"                                    = local.detected_environment
    "ProjectName"                                    = var.project_name
    "Onwer${var.delimiter}Team"                      = var.team
    "Compliance${var.delimiter}TaggingSchemaVersion" = yamldecode(file("${path.module}/version.yaml"))["ModuleVersion"],
    },
    var.extra_tags
  )

  # Rest of the file...
}
```

### Example 3: Adding Multi-Cloud Support

#### 1. Add Variables (`variables.tf`)

```hcl
variable "cloud_provider" {
  description = "Cloud provider"
  type        = string
  default     = "aws"

  validation {
    condition     = var.cloud_provider == "aws" || var.cloud_provider == "azure" || var.cloud_provider == "gcp"
    error_message = "Cloud provider must be aws, azure, or gcp."
  }
}

variable "cloud_region" {
  description = "Cloud region"
  type        = string
  default     = null
}

variable "cloud_account_id" {
  description = "Cloud account ID or subscription ID"
  type        = string
  default     = null
}
```

#### 2. Extend `main.tf`

```hcl
locals {
  # Existing default_tags and git_tags...

  # Cloud provider tags
  cloud_tags = merge(
    {
      "Cloud${var.delimiter}Provider" = upper(var.cloud_provider)
    },
    var.cloud_region != null ? {
      "Cloud${var.delimiter}Region" = var.cloud_region
    } : {},
    var.cloud_account_id != null ? {
      "Cloud${var.delimiter}AccountId" = var.cloud_account_id
    } : {}
  )

  # Updated final merge
  tags = {
    for k, v in merge(
      local.default_tags,
      local.git_tags,
      local.cloud_tags
    ) : k => v if length(k) > 0 && length(v) > 0
  }
}
```

## Testing Your Extension

### 1. Create a Test Configuration

Create a test file to validate your changes:

**`test-extension.tf`**

```hcl
module "tags_test" {
  source = "../."

  # Your new variables
  cost_center           = "US-1234"
  business_unit         = "Engineering"
  enable_compliance_tags = true

  # Standard required variables
  team          = "TestTeam"
  environment   = "test"
  project_name  = "TestProject"
  git_project_url = "https://github.com/test/repo"
}
```

### 2. Run Validation

```bash
terraform init
terraform validate
terraform fmt -check
```

### 3. Test Plan

```bash
terraform plan -out=tfplan
terraform show -json tfplan > tfplan.json
cat tfplan.json | jq '.values.root_module.resources[0].values.all_tags'
```

Expected output should include your new tags:

```json
{
  "Business:Unit": "Engineering",
  "CostCenter": "US-1234",
  "Environment": "test",
  "ProjectName": "TestProject",
  ...
}
```

### 4. Test Edge Cases

Test with various input combinations:

```bash
# Test with null values
terraform plan -var='cost_center=null'

# Test with validation failures (should fail)
terraform plan -var='cost_center=invalid-format'

# Test with conditional enabled
terraform plan -var='enable_compliance_tags=true'

# Test with conditional disabled
terraform plan -var='enable_compliance_tags=false'
```

### 5. Update Module Tests

Add test cases to `tests/main.tf`:

```hcl
# Test case 1: With new tags
module "test_with_extension" {
  source = "../."

  cost_center   = "US-1234"
  business_unit = "Engineering"

  team          = "TestTeam"
  environment   = "test"
  project_name  = "TestProject"
  git_project_url = "https://github.com/test/repo"
}

# Test case 2: Without new tags (optional)
module "test_without_extension" {
  source = "../."

  team          = "TestTeam"
  environment   = "test"
  project_name  = "TestProject"
  git_project_url = "https://github.com/test/repo"
}
```

## Best Practices

### DO ✓

- **Follow existing patterns** for naming and structure
- **Add validations** for variables that have format requirements
- **Use conditional expressions** for optional features
- **Document your changes** in README.md
- **Write tests** for new functionality
- **Use descriptive names** for variables and tags
- **Consider backward compatibility** - make new features optional
- **Clean up tags** to remove empty values in the final merge

### DON'T ✗

- **Don't break existing functionality** - ensure backward compatibility
- **Don't add required variables** without default values (unless necessary)
- **Don't skip validation** for user inputs
- **Don't hardcode values** that should be variables
- **Don't forget to update documentation**
- **Don't use unclear tag names** - follow the prefix/delimiter pattern
- **Don't merge all tags into one block** - keep them organized

## Common Extension Patterns

### Pattern 1: Optional String Tag

```hcl
variable "custom_tag" {
  description = "Custom tag value"
  type        = string
  default     = null
}

# In main.tf
local.custom_tags = var.custom_tag != null ? {
  "Custom${var.delimiter}Tag" = var.custom_tag
} : {}
```

### Pattern 2: Conditional Feature with Multiple Tags

```hcl
variable "enable_feature" {
  description = "Enable feature"
  type        = bool
  default     = false
}

variable "feature_config" {
  description = "Feature configuration"
  type        = map(string)
  default     = {}
}

# In main.tf
local.feature_tags = var.enable_feature ? {
  for k, v in var.feature_config : "Feature${var.delimiter}${k}" => v
} : {}
```

### Pattern 3: Validated Enum Tag

```hcl
variable "data_classification" {
  description = "Data classification level"
  type        = string
  default     = null

  validation {
    condition     = var.data_classification == null || contains(["Public", "Internal", "Confidential", "Restricted"], var.data_classification)
    error_message = "Data classification must be one of: Public, Internal, Confidential, Restricted."
  }
}

# In main.tf
local.compliance_tags = var.data_classification != null ? {
  "Compliance${var.delimiter}DataClassification" = var.data_classification
} : {}
```

### Pattern 4: Computed/Transformed Tag

```hcl
variable "project_code" {
  description = "Short project code (e.g., PRJ001)"
  type        = string
}

# In main.tf
local.derived_tags = {
  "Project${var.delimiter}Code"     = upper(var.project_code)
  "Project${var.delimiter}FullName" = "${var.project_name} (${var.project_code})"
}
```

## Checklist Before Submitting

- [ ] Added new variables to `variables.tf` with proper types and descriptions
- [ ] Added validation blocks for variables with format requirements
- [ ] Extended `main.tf` locals block following existing patterns
- [ ] Added new local blocks are merged in the final `tags` local
- [ ] Tag cleanup logic removes empty keys and values
- [ ] Added outputs for new variables (if applicable)
- [ ] Updated README.md with new inputs in the inputs table
- [ ] Updated README.md with new outputs in the outputs table
- [ ] Added usage examples to README.md
- [ ] Tested locally with `terraform validate`
- [ ] Tested with various input combinations
- [ ] Created test cases in `tests/` directory
- [ ] Verified backward compatibility (existing usage still works)
- [ ] Ran `terraform fmt` to ensure consistent formatting
- [ ] Updated CHANGELOG.md (if applicable)

## Pull Request Guidelines

When submitting your extension:

1. **Title:** Use semantic commit format:
   - `feat: Add [feature name] tags`
   - `feat: Add support for [feature]`

2. **Description:** Include:
   - What tags/features you're adding
   - Why they're needed
   - Use cases for the extension
   - Breaking changes (if any)
   - Testing performed

3. **Code Review Checklist:**
   - Follows existing code patterns
   - Properly documented
   - Backward compatible
   - Tests included
   - Validation logic sound

4. **Labels:**
   - `enhancement` - for new features
   - `tags` - for tag additions
   - `breaking` - if breaking changes

5. **Related Issues:** Reference any related issues or feature requests

## Questions?

- Open an issue using the "Feature Request" template
- Start a discussion for questions
- Check existing issues for similar extension requests

## Additional Resources

- [Terraform Module Documentation](https://www.terraform.io/docs/language/modules/develop/index.html)
- [Terraform Configuration Language](https://www.terraform.io/docs/language/index.html)
- [Terraform Validation Functions](https://www.terraform.io/docs/language/functions/validation.html)
- [CONTRIBUTING.md](../CONTRIBUTING.md)
- [PROVIDER_ADDITION_TEMPLATE.md](./PROVIDER_ADDITION_TEMPLATE.md)
