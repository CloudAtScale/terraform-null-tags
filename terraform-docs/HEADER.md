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
