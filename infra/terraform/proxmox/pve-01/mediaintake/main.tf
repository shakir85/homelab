module "mediaintake" {
  source              = "../../modules/vm"
  pvt_key_path        = "/home/shakir/.ssh/id_rsa"
  default_user        = "shakir"
  inventory_path      = "../../../../ansible/playbooks/inventory.ini"
  hostname            = "mediaintake"
  target_node         = "pve"
  ip_address          = "10.10.50.32/24"
  default_gateway     = "10.10.50.10"
  cpu_cores           = 2
  cpu_sockets         = 1
  memory              = "16384"
  hdd_size            = "128G"
  storage_pool        = "ssd-r10"
  cloud_init_template = "debian11-cloud"
  vm_description      = "Media ingestion from various sources"
  tags                = "media-intake prod debian11"
  ansible_command     = "../../../../ansible/playbooks/mediaintake.playbook.yml"
  ip_without_cidr     = "10.10.50.32"
  backup_enabled      = 1
}
