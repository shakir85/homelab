unit "cluster" {
  source = "${get_repo_root()}/terraform/catalog/modules/proxmox/cluster"

#   after_hook "ansible_install_collections" {
#     commands    = ["apply"]
#     working_dir = "${get_repo_root()}/ansible"
#     execute = [
#       "ansible-galaxy",
#       "collection",
#       "install",
#       "-r",
#       "requirements.yml"
#     ]
#     run_on_error = false
#   }

#   after_hook "ansible_run_playbook" {
#     commands    = ["apply"]
#     working_dir = "${get_repo_root()}/ansible"
#     execute = [
#       "ansible-playbook",
#       "-i", "inventory/dev/k3s.yml",
#       "k3s_site.playbook.yml"
#     ]
#     run_on_error = false
#   }
}

