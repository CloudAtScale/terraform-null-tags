# terraform-module-tags

This module is used to create tags for different resources that are supported by tags.

## Goals

- Create a well-versioned tagging schema
- Create tags for different resources that are supported by tags
- Define a tagging schema that is easy to understand and maintain
- Create a tagging schema that is easy to implement in different cloud providers
- Ability to understand resources created with their origin.

## Usage

```hcl
module "tags" {
    source = ""

    git_project_url = ""
    team            = "MyAwesomeTeam"
    environment     = "MyAwesomeEnvironment"
    project_name    = "MyAwesomeProject"
    extra_tags      = {
        "extra_tag_1" = "extra_tag_1_value"
        "extra_tag_2" = "extra_tag_2_value"
    }
}
```

## How to use this module

This module is used to create tags for different resources that are supported by tags.

### On AWS provider

```hcl
provider "aws" {
  region = "us-west-2"
  default_tags {
    tags = module.tags.all_tags
  }
}
```

**Note:** Most AWS resources support 50 tags per resource but some resources support only 10 tags per resource like AWS S3 Object. Please refer to the [AWS documentation](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/Using_Tags.html) for more information.

## Outputs

All tags are returned in a map:

```json
{
    "ProjectName": "MyAwesomeProject",
    "Onwer:Team": "MyAwesomeTeam",
    "Environment": "MyAwesomeEnvironment",
    "extra_tag_1": "extra_tag_1_value",
    "extra_tag_2": "extra_tag_2_value",
    "Compliance:TaggingSchemaVersion": "1.0.0"
}
```

## Terraform Docs

### Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.12.0 |

### Providers

No providers.

### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_environment"></a> [environment](#input\_environment) | Environment name | `string` | n/a | yes |
| <a name="input_git_project_url"></a> [git\_project\_url](#input\_git\_project\_url) | Git project url | `string` | n/a | yes |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | Project name | `string` | n/a | yes |
| <a name="input_team"></a> [team](#input\_team) | Team name | `string` | n/a | yes |
| <a name="input_delimiter"></a> [delimiter](#input\_delimiter) | Delimiter to be used between Prefix and key. | `string` | `":"` | no |
| <a name="input_extra_tags"></a> [extra\_tags](#input\_extra\_tags) | Extra tags | `map(string)` | `{}` | no |

### Outputs

| Name | Description |
|------|-------------|
| <a name="output_all_tags"></a> [all\_tags](#output\_all\_tags) | Tags |
| <a name="output_environment"></a> [environment](#output\_environment) | Environment |
| <a name="output_extra_tags"></a> [extra\_tags](#output\_extra\_tags) | Extra Tags |
| <a name="output_git_project_url"></a> [git\_project\_url](#output\_git\_project\_url) | Git Project URL |
| <a name="output_project_name"></a> [project\_name](#output\_project\_name) | Project Name |
| <a name="output_team"></a> [team](#output\_team) | Team |

## Disclaimer

This module is most for example to show how to create tags for different resources that are supported by tags with a well-versioned tagging schema.
