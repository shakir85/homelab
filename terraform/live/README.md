# `terraform/live`

Houses live resources provisioned by Terragrunt following the environments → stacks pattern. Resource dependencies are defined inside each stack.

The entire environment can be brought up by running `terragrunt run-all apply` from within the environment's directory.

Stacks dependency order: compute → infra → platform.

| Stack    | Functionality |
|----------|---------------|
| compute  | Hosts Proxmox VMs, the foundational compute resources for the environment. |
| infra    | Deploys core infrastructure components like GitHub Actions runners and other prerequisites for platform services. |
| platform | Provides middleware and services required for applications, such as Nginx ingress and MetalLB CRDs. |
