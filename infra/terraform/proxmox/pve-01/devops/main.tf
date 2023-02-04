module "devops" {
  source              = "../../modules/vm"
  pvt_key_path        = "/home/shakir/.ssh/id_rsa"
  default_user        = "shakir"
  inventory_path      = "../../../../ansible/playbooks/inventory.ini"
  hostname            = "devops"
  target_node         = "pve"
  ip_address          = "10.10.50.33/24"
  default_gateway     = "10.10.50.10"
  cpu_cores           = 2
  cpu_sockets         = 1
  memory              = "1026"
  hdd_size            = "24G"
  storage_pool        = "ssd-r10"
  cloud_init_template = "debian11-cloud"
  vm_description      = "Testing, CI/CD, and build vm"
  tags                = "devops dev debian11"
  ansible_command     = "../../../../ansible/playbooks/devops.playbook.yml"
  ip_without_cidr     = "10.10.50.33"
  backup_enabled      = 1
}
