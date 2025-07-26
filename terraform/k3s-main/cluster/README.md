<!-- BEGIN_TF_DOCS -->
## Usage

This configuration provisions a dynamic K3s cluster on Proxmox by grouping and filtering VMs based on their `role` and `size`.
It uses the [proxmox/vm](https://github.com/shakir85/proxmox-tf-modules) module to create each VM, and the [tags](https://github.com/shakir85/proxmox-tf-modules/tree/main/proxmox/tags) module to provide consistent tagging metadata.

The `nodes` variable defines a map of hostnames, each with a role (`control-plane` or `worker`) and optional size (`small`, `medium`, `large`).
Modules are grouped accordingly to provision appropriately sized VMs.

Each VM is configured with:
- A Debian 12 cloud image
- SSH access using a specified public key
- Sizing based on the `role` and `size`
- Metadata such as timezone and description

Example:

```hcl
variable "nodes" {
  type = map(object({
    role = string
    size = optional(string)
  }))
  default = {
    "k3s-main-ctrl"   = { role = "control-plane" }
    "k3s-main-node-1" = { role = "worker", size = "small" }
    "k3s-main-node-2" = { role = "worker", size = "medium" }
    "k3s-main-node-3" = { role = "worker", size = "medium" }
    "k3s-main-node-4" = { role = "worker", size = "large" }
  }
}

module "tags" {
  source      = "git::https://github.com/shakir85/terraform_modules.git//proxmox/tags?ref=v0.2.2"
  environment = "prod"
  os          = "debian12"
  flavor      = "k3s"
  cluster     = "k3s-main"
}

module "control_plane_vms" {
  for_each = {
    for k, v in var.nodes :
    k => v if v.role == "control-plane"
  }
  ...
}

module "nodes_group_large_vms" {
  for_each = {
    for k, v in var.nodes :
    k => v if v.role == "worker" && v.size == "large"
  }
  ...
}

module "nodes_group_medium_vms" {
  for_each = {
    for k, v in var.nodes :
    k => v if v.role == "worker" && v.size == "medium"
  }
  ...
}

module "nodes_group_small_vms" {
  for_each = {
    for k, v in var.nodes :
    k => v if v.role == "worker" && v.size == "small"
  }
  ...
}
```

Each VM receives tags including its role, and resources are scaled by their `size` classification.

## Requirements

The following requirements are needed by this module:

- <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) (~> 1.5.7)

- <a name="requirement_local"></a> [local](#requirement\_local) (~> 2.5.1)

- <a name="requirement_proxmox"></a> [proxmox](#requirement\_proxmox) (0.70.0)

## Providers

No providers.

## Modules

The following Modules are called:

### <a name="module_control_plane_vms"></a> [control\_plane\_vms](#module\_control\_plane\_vms)

Source: git::https://github.com/shakir85/terraform_modules.git//proxmox/vm

Version: v0.2.2

### <a name="module_nodes_group_large_vms"></a> [nodes\_group\_large\_vms](#module\_nodes\_group\_large\_vms)

Source: git::https://github.com/shakir85/terraform_modules.git//proxmox/vm

Version: v0.2.2

### <a name="module_nodes_group_medium_vms"></a> [nodes\_group\_medium\_vms](#module\_nodes\_group\_medium\_vms)

Source: git::https://github.com/shakir85/terraform_modules.git//proxmox/vm

Version: v0.2.2

### <a name="module_nodes_group_small_vms"></a> [nodes\_group\_small\_vms](#module\_nodes\_group\_small\_vms)

Source: git::https://github.com/shakir85/terraform_modules.git//proxmox/vm

Version: v0.2.2

### <a name="module_tags"></a> [tags](#module\_tags)

Source: git::https://github.com/shakir85/terraform_modules.git//proxmox/tags

Version: v0.2.2

## Resources

No resources.

## Required Inputs

The following input variables are required:

### <a name="input_id_rsa"></a> [id\_rsa](#input\_id\_rsa)

Description: n/a

Type: `string`

### <a name="input_id_rsa_pub"></a> [id\_rsa\_pub](#input\_id\_rsa\_pub)

Description: n/a

Type: `string`

### <a name="input_pve_pwd"></a> [pve\_pwd](#input\_pve\_pwd)

Description: n/a

Type: `string`

### <a name="input_pve_user"></a> [pve\_user](#input\_pve\_user)

Description: n/a

Type: `string`

## Optional Inputs

The following input variables are optional (have default values):

### <a name="input_nodes"></a> [nodes](#input\_nodes)

Description: n/a

Type:

```hcl
map(object({
    role = string
    size = optional(string)
  }))
```

Default:

```json
{
  "k3s-main-ctrl": {
    "role": "control-plane"
  },
  "k3s-main-node-1": {
    "role": "worker",
    "size": "small"
  },
  "k3s-main-node-2": {
    "role": "worker",
    "size": "medium"
  },
  "k3s-main-node-3": {
    "role": "worker",
    "size": "medium"
  },
  "k3s-main-node-4": {
    "role": "worker",
    "size": "large"
  }
}
```

## Outputs

No outputs.
<!-- END_TF_DOCS -->
