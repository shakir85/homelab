<!-- BEGIN_TF_DOCS -->
## Usage

This module provisions a dynamic set of K3s cluster VMs on Proxmox using the `proxmox/vm` module.
It loops over the `nodes` variable (a map of hostnames to node roles), creating a VM for each entry.

The `tags` module is used to generate consistent metadata tags, and the node role is dynamically injected into each VM.

Each VM is configured with:
- A Debian 12 cloud image
- SSH access
- Sizing based on role (control-plane vs. worker)
- Metadata such as timezone and description

Example:

```hcl
module "tags" {
  source      = "git::https://github.com/shakir85/terraform_modules.git//proxmox/tags?ref=v0.2.2"
  environment = "prod"
  os          = "debian12"
  flavor      = "k3s"
  cluster     = "k3s-main"
}

module "k3s_vms" {
  for_each            = var.nodes
  source              = "git::https://github.com/shakir85/terraform_modules.git//proxmox/vm?ref=v0.2.2"
  proxmox_node_name   = "pve1"
  disk_name           = "sdd"
  ssh_public_key_path = var.id_rsa_pub
  username            = "shakir"
  hostname            = each.key
  timezone            = "America/Los_Angeles"
  cloud_image_info    = ["sdc", "debian-12-generic-amd64.qcow2.img"]
  memory              = each.value.role == "control-plane" ? 16384 : 8192
  cores               = 2
  sockets             = 1
  disk_size           = 50
  description         = "Managed by Terraform."

  tags = [
    for key, value in module.tags.tags :
    key == "role" ? each.value.role : value
  ]
}
```

The output `k3s_vms_outputs` returns a map of all VM module outputs keyed by hostname.

## Requirements

The following requirements are needed by this module:

- <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) (>= 1.5.7)

- <a name="requirement_local"></a> [local](#requirement\_local) (>= 2.5.1)

- <a name="requirement_proxmox"></a> [proxmox](#requirement\_proxmox) (0.70.0)

## Providers

No providers.

## Modules

The following Modules are called:

### <a name="module_k3s_vms"></a> [k3s\_vms](#module\_k3s\_vms)

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
  }))
```

Default:

```json
{
  "k3s-main-ctrl": {
    "role": "control-plane"
  },
  "k3s-main-node-1": {
    "role": "worker"
  },
  "k3s-main-node-2": {
    "role": "worker"
  },
  "k3s-main-node-3": {
    "role": "worker"
  },
  "k3s-main-node-4": {
    "role": "worker"
  }
}
```

## Outputs

The following outputs are exported:

### <a name="output_k3s_vms_outputs"></a> [k3s\_vms\_outputs](#output\_k3s\_vms\_outputs)

Description: Print any output block from the main module
<!-- END_TF_DOCS -->