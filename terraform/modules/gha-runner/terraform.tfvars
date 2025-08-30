gha_runners = {
  homelab_repo = {
    gha_runner_release_name = "homelab-runners"
    repo_values_file        = "values-homelab.yaml"
  }

  proxmox_tf_modules_repo = {
    gha_runner_release_name = "proxmox-tf-modules-runners"
    repo_values_file        = "values-proxmox-tf-modules.yaml"
  }
}
