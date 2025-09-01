## MetalLB Helm Deployment
 
This module installs the official [MetalLB Helm chart](https://metallb.universe.tf/installation/#installation-with-helm)
 
## Usage
 
```hcl
  module "metallb" {
    source  = "path/to/this/module"
  }
```
 
This will:
- Install the MetalLB Helm chart version specified in `var.metallb_version` in the `metallb-system` namespace
 
>[!Note]
> If you plan to install MetalLB Custom Resource Definition (CRDs) for IP advertisement, they must be created after the Helm chart installation.
