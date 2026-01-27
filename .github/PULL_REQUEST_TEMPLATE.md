## Pull Request Title

### Description

Please provide a brief description of the changes made in this pull request.

### Context

Please provide some context about the files being modified and the purpose of these changes.

### Checklist

- [ ] I have tested these changes locally.
- [ ] I have reviewed the code and ensured it follows the project's coding standards.
- [ ] I have updated the documentation, if necessary.
- [ ] I have run `terraform fmt` on the code.
- [ ] I have run `pre-commit run --all-files` on the code.
- [ ] I used angular commit message format.
- [ ] I have added appropriate tests, if applicable.

### Related Issues or Pull Requests [Optional]

Please list any related issues or pull requests that are addressed by this pull request.

### Additional Notes [Optional]

Add any additional notes or comments here.

---

## Review Checklist

*For maintainers reviewing this pull request*

### Code Quality
- [ ] Code follows project coding standards and patterns
- [ ] `terraform fmt` has been run and formatting is consistent
- [ ] `terraform validate` passes without errors
- [ ] `pre-commit run --all-files` passes all hooks
- [ ] No sensitive data or credentials included
- [ ] Variable and output names follow naming conventions

### Testing
- [ ] Changes have been tested locally (if applicable)
- [ ] Existing tests still pass
- [ ] New tests added for new functionality (if applicable)
- [ ] Test coverage is adequate for changes made
- [ ] Edge cases and error scenarios considered

### Documentation
- [ ] README.md updated with new features/changes (if applicable)
- [ ] CHANGELOG.md updated with entry following conventional commits format
- [ ] Inline code comments added for complex logic
- [ ] Variable descriptions are clear and complete
- [ ] Output descriptions are clear and complete
- [ ] Examples updated or added (if applicable)

### Breaking Changes
- [ ] No breaking changes introduced OR
- [ ] Breaking changes clearly documented in CHANGELOG.md
- [ ] Migration guide provided for breaking changes (if applicable)

### Backward Compatibility
- [ ] Changes are backward compatible (if applicable)
- [ ] Default values maintain previous behavior
- [ ] Variable type changes don't break existing usage

### Provider-Specific Checks (if applicable)
- [ ] Provider-specific code follows provider patterns
- [ ] Provider documentation referenced correctly
- [ ] Provider-specific tests included

### Commit Standards
- [ ] Commits follow angular commit message format
- [ ] Commit messages are clear and descriptive
- [ ] No merge commits in PR history

### Approval
- [ ] At least one maintainer has approved
- [ ] CI/CD checks have passed
- [ ] All requested changes addressed
