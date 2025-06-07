
variable "ipv4_address_pool_name" {
  type        = string
  default     = "default-pool"
  description = "IP addresses pool name. This name will be used in the `L2Advertisement.spec.IPAddressPool` K8s CRD. This is important because if omitted, MetalLB will advertise from any available IP pool in the namespace."
}

variable "ipv4_address_pool" {
  type        = list(string)
  default     = ["10.10.50.95-10.10.50.99"]
  description = "To generate an address pool. An *address pool* is one or more IPv4 range. This variable is a list of strings for the IPv4 *ranges* that MetalLB will use when provisioning a Service of type LoadBalance. Example values: `['192.168.50.90-192.168.50.99', '192.168.20.45-192.168.20.60']`"
}

variable "kube_config_path" {
  default     = "~/.kube/config"
  type        = string
  description = "Path to kubeconfig file relative to where this script will run"
}

variable "kube_context" {
  description = "The name of the kubeconfig context to use"
  type        = string
  default     = "k3s-utils-ctx"
}

variable "kube_namespace" {
  type        = string
  default     = "metallb-system"
  description = "Namespace where the gha-runner service account will reside (typically 'cicd')"
}

variable "shared_labels" {
  description = "Shared labels"
  type        = map(string)
  default = {
    "app.kubernetes.io/managed-by" = "terraform"
  }
}
