# Contributing to terraform-module-tags

Thank you for your interest in contributing to the terraform-module-tags module! This document provides guidelines and instructions for contributing.

## Why Contribute?

As an open-source project maintained primarily by a solo developer, community contributions are essential to:
- Add support for new VCS providers (GitLab, Bitbucket, Azure DevOps, etc.)
- Extend module functionality with new tagging features
- Improve documentation and examples
- Add tests and improve code quality
- Fix bugs and issues

Your contributions help make this module more robust and useful for the entire community.

## How to Contribute

### Getting Started

1. **Fork the repository** on GitHub
2. **Clone your fork** locally:
   ```bash
   git clone https://github.com/YOUR_USERNAME/terraform-module-tags.git
   cd terraform-module-tags
   ```
3. **Create a feature branch**:
   ```bash
   git checkout -b feature/your-feature-name
   ```

### Types of Contributions

We welcome several types of contributions:

#### 1. Adding a New VCS Provider

Add support for version control systems beyond GitHub and GitLab. Use the [VCS Provider Template](templates/PROVIDER_ADDITION_TEMPLATE.md) for guidance.

**Examples:**
- Bitbucket Cloud/Server
- Azure DevOps
- Gitea
- AWS CodeCommit

#### 2. Extending Module Functionality

Enhance the tagging module with new features or capabilities. Use the [Module Extension Template](templates/MODULE_EXTENSION_TEMPLATE.md) for guidance.

**Examples:**
- New tag prefixes or categories
- Custom validation logic
- Additional computed values
- Integration with external tagging systems

#### 3. Documentation Improvements

Help improve documentation clarity and completeness. Use the [Documentation Contribution Template](templates/DOCUMENTATION_CONTRIBUTION.md) for guidance.

**Examples:**
- Fixing typos or grammatical errors
- Adding additional usage examples
- Improving explanations
- translating documentation to other languages

#### 4. Tests and Bug Fixes

Improve code quality and fix issues. Use the [Test Contribution Template](templates/TEST_CONTRIBUTION.md) for guidance.

**Examples:**
- Adding test cases for edge cases
- Fixing bugs in existing code
- Improving test coverage
- Performance optimizations

## Development Workflow

### 1. Set Up Development Environment

```bash
# Install Terraform (>= 0.12.0)
terraform --version

# Install pre-commit hooks (if configured)
pip install pre-commit
pre-commit install
```

### 2. Make Your Changes

- Follow existing code style and conventions
- Add tests for new functionality
- Update documentation as needed
- Run pre-commit hooks:
  ```bash
  pre-commit run --all-files
  ```

### 3. Test Your Changes

```bash
# Validate Terraform configuration
terraform init
terraform validate

# Format Terraform code
terraform fmt -check

# Run tests (if test suite is configured)
go test ./...  # or appropriate test command
```

### 4. Commit Your Changes

Use clear, descriptive commit messages:

```bash
git add .
git commit -m "feat: add Bitbucket Cloud provider support

- Implement Bitbucket-specific variables
- Add documentation and examples
- Include tests for new provider"
```

**Commit message format:**
- `feat:` - New feature
- `fix:` - Bug fix
- `docs:` - Documentation changes
- `test:` - Test additions or changes
- `refactor:` - Code refactoring
- `chore:` - Maintenance tasks

### 5. Push and Create Pull Request

```bash
git push origin feature/your-feature-name
```

Then create a pull request on GitHub using our [PR template](.github/PULL_REQUEST_TEMPLATE.md).

## Code Standards

### Terraform Code Style

- Follow [Terraform best practices](https://www.terraform.io/docs/cloud/guides/recommended-practices/index.html)
- Use `terraform fmt` for consistent formatting
- Use descriptive variable and output names
- Include descriptions for all variables and outputs
- Keep functions simple and readable

### Example Variable Definition

```hcl
variable "example_variable" {
  type        = string
  description = "Clear description of what this variable does"
  default     = "default-value"
}
```

### Example Output Definition

```hcl
output "example_output" {
  description = "Clear description of what this output provides"
  value       = module.example.value
}
```

## Pull Request Process

### Before Submitting

- [ ] Ensure all tests pass
- [ ] Run `terraform fmt` on all files
- [ ] Update relevant documentation
- [ ] Add tests for new functionality
- [ ] Check that your code follows the style guide
- [ ] Review your changes one more time

### PR Review Checklist

Your PR should:
- [ ] Pass all automated checks (CI/CD)
- [ ] Include tests for new functionality
- [ ] Update documentation (README, examples, etc.)
- [ ] Follow commit message conventions
- [ ] Not break existing functionality
- [ ] Be focused on a single issue or feature
- [ ] Have a clear description of the changes

### Review Process

1. **Automated Checks**: CI will run tests and validation
2. **Code Review**: Maintainers will review your code
3. **Feedback**: Address review comments promptly
4. **Approval**: Once approved, your PR will be merged

### Timeline

We aim to review all PRs within 7 days. If you haven't received feedback after a week, feel free to ping the maintainers.

## Templates for Contributions

We provide templates to help you contribute effectively:

- [VCS Provider Addition Template](templates/PROVIDER_ADDITION_TEMPLATE.md) - Step-by-step guide for adding new VCS providers
- [Module Extension Template](templates/MODULE_EXTENSION_TEMPLATE.md) - Patterns for extending module functionality
- [Documentation Contribution Template](templates/DOCUMENTATION_CONTRIBUTION.md) - Guidelines for documentation improvements
- [Test Contribution Template](templates/TEST_CONTRIBUTION.md) - Patterns for writing tests

## Reporting Issues

### Bug Reports

Use the [Bug Report template](.github/ISSUE_TEMPLATE/bug_report.md) and include:
- Terraform version
- Provider version
- Minimal reproduction code
- Error messages and logs
- Expected vs actual behavior

### Feature Requests

Use the [Feature Request template](.github/ISSUE_TEMPLATE/feature_request.md) and describe:
- The problem you're trying to solve
- Proposed solution
- Alternative approaches considered
- Use cases and benefits

### Provider Requests

Use the [Provider Request template](.github/ISSUE_TEMPLATE/provider_request.md) to request support for a new VCS provider.

## Getting Help

### Questions?

- Check existing [GitHub Issues](../../issues) for similar questions
- Start a [Discussion](../../discussions) on GitHub
- Read the [README](README.md) for usage examples

### Need Support?

- Review the [documentation templates](templates/)
- Check the [test files](tests/) for usage examples
- Open an issue for bugs or feature requests

## Recognition

Contributors are recognized in:
- [README.md Contributors section](README.md#contributors)
- Release notes for significant contributions
- Project documentation

Thank you for contributing to terraform-module-tags! 🎉

## Code of Conduct

Be respectful, inclusive, and constructive. We're all working together to make this project better.

### Our Pledge

- Use welcoming and inclusive language
- Be respectful of differing viewpoints and experiences
- Gracefully accept constructive criticism
- Focus on what is best for the community
- Show empathy towards other community members

## License

By contributing, you agree that your contributions will be licensed under the same license as the project.
