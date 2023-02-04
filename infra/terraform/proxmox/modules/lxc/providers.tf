terraform {
  backend "s3" {
    bucket = "pxmx-hm-tf-state"
    key    = "lxcs-tf-statefile"
    region = "us-east-1"
  }

  required_providers {
    proxmox = {
      source  = "telmate/proxmox"
      version = " 2.9.11"
    }
  }
}

provider "proxmox" {
  // Export the following environment variables to authenticate with proxmox:
  # export PM_API_TOKEN_ID="<username>@pam!<tokenName>"
  # export PM_API_TOKEN_SECRET="xxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxx"

  pm_api_url      = "https://${var.proxmox_host}:8006/api2/json"
  pm_tls_insecure = true

  # Enable the following attributes for debugging:
  # pm_debug = true
  # pm_log_file = "terraform-plugin-proxmox.log"
  # pm_log_enable = true
  # pm_log_levels = {
  # _default = "debug"
  # _capturelog = ""
  # }
}
