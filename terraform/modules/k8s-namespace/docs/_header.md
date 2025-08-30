## Usage

This is an example of how to use this module to provision a namespace with optional labels and annotations.

```hcl
module "example_namespace" {
  source = "path/to/this/module"
  # Required
  name = "example"
  # Optional
  labels = {
    "env" = "dev"
  }
  annotations = {
    "owner" = "dev-team"
  }
}
```
