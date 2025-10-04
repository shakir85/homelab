# `terraform/live`

Houses live resources provisioned by Terragrunt following the environments as Terragrunt stacks pattern. Each stack contains multiple related units defined as follows:

| Units    | Functionality |
|----------|---------------|
| compute  | Hosts Proxmox VMs, the foundational compute resources for the environment. |
| infra    | Deploys core infrastructure components like GitHub Actions runners and other prerequisites for platform services. |
| platform | Provides middleware and services required for applications, such as Nginx ingress and MetalLB CRDs. |

Resource dependencies are defined inside each unit. Units dependency order is: compute → infra → platform. The entire environment can be brought up by running `terragrunt apply --all` from within the environment's (stack) directory.
