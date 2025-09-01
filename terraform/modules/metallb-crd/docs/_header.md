 ## MetalLB Custom Resource Definitions (CRDs) Deployment

 This module installs the official MetalLB CRDs for Layer 2 advertisement with a static IP address pool using Terraform.

 ## Requirements
 Set IP address ranges for MetalLB to allocate when a LoadBalancer Service is deployed;
 ensure the range is available in your router - e.g., 192.168.50.90-192.168.50.99 may be reserved
 for static mapping.

 This will:
 - Deploy a `IPAddressPool` CRD
 - Deploy a `L2Advertisement` CRD that references the IP pool

 >[!Note] 
 >  MetalLB must be up and running*before** running this configuration.

 ## Example

 ```hcl
 module "metallb_crds" {
   source                  = "./modules/metallb-crds"
   kube_namespace          = "metallb-system"
   ipv4_address_pool_name  = "default-ip-pool"
   ipv4_address_pool       = ["192.168.50.90-192.168.50.99"]
   shared_labels           = {
     app = "metallb"
   }
 }
 ```
