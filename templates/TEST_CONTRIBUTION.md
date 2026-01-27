# Test Contribution Template

Thank you for your interest in improving the test coverage for the terraform-module-tags project! This template will guide you through the process of contributing high-quality tests.

## Test Structure

Tests are located in the `tests/` directory and follow this structure:

```
tests/
├── main.tf              # Module instantiation with test configuration
├── variables.tf         # Variable declarations
├── variables.tfvars     # Variable values for testing
└── outputs.tf          # Output declarations to verify module behavior
```

## Writing Tests

### 1. main.tf - Module Configuration

This file instantiates the module with test configuration.

**Example:**

```hcl
module "tags" {
  source = "../."

  team            = "MyTeam"
  environment     = "MyEnvironment"
  project_name    = var.project_name
  git_project_url = var.git_project_url
}
```

**Guidelines:**
- Use `source = "../."` to reference the parent module
- Set descriptive test values for team and environment
- Use variables for project-specific values
- Keep configuration simple and focused on testing the module

### 2. variables.tf - Variable Declarations

Declare all variables used in your test configuration.

**Example:**

```hcl
variable "git_project_url" {
  description = "Git project url from GitHub Environment Variable"
}

variable "project_name" {
  description = "Project name from GitHub Environment Variable"
}
```

**Guidelines:**
- Include clear descriptions for each variable
- Only declare variables used in your test
- Follow Terraform naming conventions (snake_case)
- Use descriptive variable names

### 3. variables.tfvars - Test Values

Provide actual values for your test variables.

**Example:**

```hcl
git_project_url = "https://github.com/CloudAtScale/terraform-module-tags"
team            = "CloudAtScale"
environment     = "test"
project_name    = "terraform-module-tags"

# Optional: Test extra_tags functionality
# extra_tags = {
#   "test_tag_key" = "test_tag_value"
# }
```

**Guidelines:**
- Use realistic but clearly identifiable test values
- Comment out optional features to demonstrate flexibility
- Maintain proper HCL syntax
- Keep values simple and readable

### 4. outputs.tf - Verification Outputs

Define outputs to verify the module produces expected results.

**Example:**

```hcl
output "tags" {
  value = module.tags.all_tags
}
```

**Guidelines:**
- Output key module attributes to verify functionality
- Use descriptive output names
- Include outputs that help verify the module behavior

## Running Tests

### Basic Validation

Validate your Terraform configuration:

```bash
cd tests/
terraform init
terraform validate
```

**Expected Output:**
```
Success! The configuration is valid.
```

### Format Check

Ensure your code follows Terraform formatting standards:

```bash
terraform fmt -check
```

**Expected Output:**
```
(No output if files are properly formatted)
```

If files need formatting, run:
```bash
terraform fmt
```

### Documentation Check

Verify variable and output descriptions:

```bash
terraform-docs .
```

## Test Categories

### 1. Basic Functionality Tests

Verify the module works with default configuration:

```hcl
module "tags" {
  source = "../."

  team            = "TestTeam"
  environment     = "test"
  project_name    = "test-project"
  git_project_url = "https://github.com/test/repo"
}
```

### 2. Feature-Specific Tests

Test specific features like extra_tags:

```hcl
module "tags" {
  source = "../."

  team            = "TestTeam"
  environment     = "test"
  project_name    = "test-project"
  git_project_url = "https://github.com/test/repo"

  extra_tags = {
    "CustomTag"   = "CustomValue"
    "Environment" = "development"
  }
}
```

### 3. Provider-Specific Tests

Test different VCS providers:

```hcl
module "tags" {
  source = "../."

  team            = "TestTeam"
  environment     = "test"
  project_name    = "test-project"
  git_project_url = "https://gitlab.com/test/repo"
  vcs_provider    = "gitlab"

  gitlab_project_id = "12345"
}
```

### 4. Edge Case Tests

Test edge cases and error conditions:

- Empty team name
- Special characters in values
- Maximum tag limits
- Invalid provider combinations

## Test Quality Checklist

Before submitting your test contribution, ensure:

- [ ] **Validates**: Configuration passes `terraform validate`
- [ ] **Formatted**: Code passes `terraform fmt -check`
- [ ] **Documented**: All variables have descriptions
- [ ] **Realistic**: Test values represent real-world usage
- [ ] **Isolated**: Tests are independent and don't require external state
- [ ] **Clear**: Output names are descriptive and helpful
- [ ] **Consistent**: Follows existing test file structure
- [ ] **Minimal**: Tests are focused and don't include unnecessary complexity

## Common Testing Patterns

### Testing Tag Generation

```hcl
output "all_tags" {
  description = "All generated tags"
  value       = module.tags.all_tags
}

output "default_tags" {
  description = "Default tags only"
  value       = module.tags.default_tags
}

output "extra_tags" {
  description = "Extra tags only"
  value       = module.tags.extra_tags
}
```

### Testing Provider-Specific Behavior

```hcl
output "git_tags" {
  description = "Git repository tags"
  value       = module.tags.git_tags
}

output "vcs_provider" {
  description = "The VCS provider being used"
  value       = module.tags.vcs_provider
}
```

## Pre-commit Hooks

This project uses pre-commit hooks to automatically run tests:

```bash
# Install pre-commit hooks (one-time setup)
pre-commit install

# Run hooks manually
pre-commit run --all-files
```

The hooks will check:
- Terraform formatting (`terraform fmt`)
- Terraform validation (`terraform validate`)
- Terraform documentation (`terraform-docs`)
- Commit message format (commitizen)

## Debugging Failed Tests

### Validation Errors

If `terraform validate` fails:

1. Check the error message for specific issues
2. Verify all required variables are defined
3. Ensure variable types match expectations
4. Check for syntax errors in HCL code

### Formatting Issues

If `terraform fmt -check` fails:

1. Run `terraform fmt` to auto-format
2. Review the changes
3. Ensure consistent indentation (2 spaces)
4. Check for trailing whitespace

### Documentation Errors

If `terraform-docs` fails:

1. Ensure all variables have descriptions
2. Check for missing output descriptions
3. Verify proper HCL syntax

## Example Test Scenario

**Scenario:** Test the module with GitHub provider and extra tags

**main.tf:**
```hcl
module "tags" {
  source = "../."

  team            = "MyTeam"
  environment     = "production"
  project_name    = var.project_name
  git_project_url = var.git_project_url

  extra_tags = {
    "CostCenter"  = "Engineering"
    "Compliance"  = "GDPR"
    "Backup"      = "daily"
  }
}
```

**variables.tf:**
```hcl
variable "project_name" {
  description = "Project name from GitHub Environment Variable"
}

variable "git_project_url" {
  description = "Git project url from GitHub Environment Variable"
}
```

**variables.tfvars:**
```hcl
project_name    = "terraform-module-tags"
git_project_url = "https://github.com/CloudAtScale/terraform-module-tags"
```

**outputs.tf:**
```hcl
output "all_tags" {
  description = "All tags including default, git, and extra tags"
  value       = module.tags.all_tags
}

output "extra_tags_verification" {
  description = "Verify extra tags are included"
  value       = module.tags.extra_tags
}
```

## How to Contribute Tests

1. **Identify what to test**: What feature or scenario needs testing?
2. **Review existing tests**: Understand the current test structure
3. **Create your test files**: Follow the templates above
4. **Run validation**: Ensure tests pass all checks
5. **Verify manually**: Check outputs make sense
6. **Submit a pull request**: Include clear description of what's being tested
7. **Respond to feedback**: Address any review comments

## Need Help?

If you have questions about contributing tests:
- Open an issue with the `testing` label
- Check existing test files for examples
- Review the project's README for module usage
- Refer to Terraform's testing documentation

---

Thank you for helping improve our test coverage! :test_tube:
