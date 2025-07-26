<!-- BEGIN_TF_DOCS -->
Terraform Module: nginx-ingress

Installs the NGINX Ingress Controller using the official Helm chart.

This module:
- Installs the controller as a DaemonSet.
- Removes the `controller.service.port.https` value from values.yaml. TLS is terminated outside the ingress.

Usage:

module "nginx\_ingress" {
  source  = "./nginx-ingress"
  name    = "nginx-ingress"
  namespace = "ingress-nginx"
  chart\_version = "4.10.0"
  repository    = "https://kubernetes.github.io/ingress-nginx"
}

## Requirements

The following requirements are needed by this module:

- <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) (~> 1.5.7)

- <a name="requirement_helm"></a> [helm](#requirement\_helm) (~> 2.9.0)

## Providers

The following providers are used by this module:

- <a name="provider_helm"></a> [helm](#provider\_helm) (~> 2.9.0)

## Modules

No modules.

## Resources

The following resources are used by this module:

- [helm_release.nginx_ingress](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) (resource)

## Required Inputs

The following input variables are required:

### <a name="input_namespace"></a> [namespace](#input\_namespace)

Description: The namespace where the ingress controller will be deployed

Type: `string`

### <a name="input_release_name"></a> [release\_name](#input\_release\_name)

Description: The name of the Helm release

Type: `string`

## Optional Inputs

The following input variables are optional (have default values):

### <a name="input_chart_version"></a> [chart\_version](#input\_chart\_version)

Description: The version of the ingress-nginx Helm chart to install

Type: `string`

Default: `"4.10.0"`

### <a name="input_ingress_controller_name"></a> [ingress\_controller\_name](#input\_ingress\_controller\_name)

Description: A name for the ingress controller. It sets the values of `controller.ingressClass` and `controller.ingressClassResource.name`. This is essential because the K8s ingress-resources's `ingressClassName` attribute  will use this value

Type: `string`

Default: `"nginx"`

## Outputs

No outputs.
<!-- END_TF_DOCS -->
