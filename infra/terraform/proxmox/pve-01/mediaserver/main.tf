module "mediaserver" {
  source              = "../../modules/vm"
  pvt_key_path        = "/home/shakir/.ssh/id_rsa"
  default_user        = "shakir"
  inventory_path      = "../../../../ansible/playbooks/inventory.ini"
  hostname            = "mediaserver"
  target_node         = "pve"
  ip_address          = "10.10.50.31/24"
  default_gateway     = "10.10.50.10"
  cpu_cores           = 2
  cpu_sockets         = 2
  memory              = "16384"
  hdd_size            = "128G"
  storage_pool        = "ssd-r10"
  cloud_init_template = "debian11-cloud"
  vm_description      = "Media server"
  tags                = "media-server prod debian11"
  ansible_command     = "../../../../ansible/playbooks/mediaserver.playbook.yml"
  ip_without_cidr     = "10.10.50.31"
  backup_enabled      = 1
}
