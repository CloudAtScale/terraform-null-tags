# Documentation Contribution Template

Thank you for your interest in improving the documentation for the terraform-module-tags project! This template will guide you through the process of contributing high-quality documentation.

## Types of Documentation Contributions

We welcome several types of documentation improvements:

### 1. README.md Updates

The README is the primary source of information for users. Common improvements include:
- Adding new usage examples
- Clarifying existing descriptions
- Adding diagrams or visual aids
- Updating version information
- Improving the structure and flow

**Style Guidelines:**
- Use clear, concise language
- Include working code examples (HCL for Terraform, YAML for CI/CD)
- Group related information under descriptive headings
- Use proper Markdown formatting (headers, code blocks, lists, links)
- Maintain the existing section structure when possible

**Example Format:**

```markdown
## New Feature Section

Brief description of the feature or concept.

### Usage Example

`main.tf`

\`\`\`hcl
module "example" {
  source = "CloudAtScale/tags/null"
  # Add your configuration here
}
\`\`\`

**Note:** Any important caveats or limitations go here.
```

### 2. CHANGELOG.md Entries

When contributing code changes that affect functionality, update the CHANGELOG following our format:

**Entry Format:**

```markdown
## [X.Y.Z](https://github.com/CloudAtScale/terraform-null-tags/compare/X.Y.Z-1...X.Y.Z) (YYYY-MM-DD)

### :rocket: Features

* **scope:** brief description ([#issue_number](https://github.com/CloudAtScale/terraform-null-tags/issues/issue_number)) ([commit_hash](https://github.com/CloudAtScale/terraform-null-tags/commit/commit_hash))

### :bug: Bug Fixes

* **scope:** brief description ([#issue_number](https://github.com/CloudAtScale/terraform-null-tags/issues/issue_number)) ([commit_hash](https://github.com/CloudAtScale/terraform-null-tags/commit/commit_hash))

### :books: Documentation

* Brief description of documentation change ([commit_hash](https://github.com/CloudAtScale/terraform-null-tags/commit/commit_hash))

### :robot: Continuous Integration

* **scope:** brief description ([commit_hash](https://github.com/CloudAtScale/terraform-null-tags/commit/commit_hash))
```

**Categories:**
- `:rocket:` - New features
- `:bug:` - Bug fixes
- `:books:` - Documentation changes
- `:robot:` - CI/CD improvements
- `:package:` - Miscellaneous chores (dependencies, etc.)

### 3. Inline Code Documentation

When adding or modifying Terraform code:

**Variables:**

```hcl
variable "example_var" {
  type        = string
  description = "Clear, concise description of what this variable does"
  default     = "default_value"
}
```

**Outputs:**

```hcl
output "example_output" {
  description = "Clear description of what this output returns"
  value       = module.example.output_value
}
```

**Comments in Code:**
```hcl
# Brief comment explaining complex logic
resource "aws_example" "main" {
  # Configuration here
}
```

### 4. Terraform Documentation (Auto-generated)

This project uses terraform-docs to generate the "Terraform Docs" section in the README. The format is automatically generated from the code, but ensure your variable and output descriptions are clear and follow this style:

```hcl
variable "team" {
  type        = string
  description = "Team name"
  required    = true
}

variable "extra_tags" {
  type        = map(string)
  description = "Extra tags to add to the resource"
  default     = {}
}
```

## Documentation Quality Checklist

Before submitting your documentation contribution, ensure:

- [ ] **Clarity**: Is the language clear and easy to understand?
- [ ] **Accuracy**: Is all technical information correct?
- [ ] **Completeness**: Are all necessary details included?
- [ ] **Examples**: Do code examples work and demonstrate the concept?
- [ ] **Consistency**: Does it match the existing documentation style?
- [ ] **Formatting**: Is Markdown properly formatted?
- [ ] **Links**: Are all links valid and relevant?
- [ ] **Spelling**: Is everything free of typos?
- [ ] **Structure**: Is information organized logically?

## How to Contribute Documentation

1. **Identify the improvement**: What documentation needs to be added or updated?
2. **Review existing documentation**: Understand the current style and structure
3. **Create your contribution**: Follow the templates above
4. **Test your examples**: Verify all code examples work correctly
5. **Submit a pull request**: Include a clear description of your changes
6. **Respond to feedback**: Address any review comments promptly

## Example Documentation Improvements

### Before (Unclear):
```markdown
## Tags

This makes tags for resources. You can use it with AWS.
```

### After (Clear and Complete):
```markdown
## How to use this module

This module is used to create tags for different resources that are supported by tags.

### On AWS provider

\`\`\`hcl
provider "aws" {
  region = "us-west-2"
  default_tags {
    tags = module.tags.all_tags
  }
}
\`\`\`

**Note:** Most AWS resources support 50 tags per resource but some resources support only 10 tags per resource like AWS S3 Object. Please refer to the [AWS documentation](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/Using_Tags.html) for more information.
```

## Need Help?

If you have questions about contributing documentation:
- Open an issue with the `documentation` label
- Check existing pull requests for examples
- Review the project's README and CHANGELOG for style reference

---

Thank you for helping improve our documentation! :books:
