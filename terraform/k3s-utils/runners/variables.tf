variable "kube_config_path" {
    default = "~/.kube/config"
    type = string
    description = "Path to kubeconfig file relative to where this script will run"
}

variable "gha_runner_name" {
  default = "tf-runners-k3s"
  type = string
  description = "Name of the GHA runners"
}

variable "runner_type" {
  default = "deployRunnerDeployment"
  type = string
  description = "GHA runner type. See chart's notes for more info"
}

variable "runner_name" {
  default = "tf-managed"
  type = string
  description = "GHA runner name"
}

variable "kube_namespace" {
  default = "actions"
  type = string
  description = "Namespace where the runners will be deployed"
}
