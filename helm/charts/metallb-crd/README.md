# MetalLB Custom Resource Definition
This chart deploys the required CRDs for a barebones MetalLB installation, enabling it to expose network traffic to the local network when a Kubernetes `Ingress` resource is created.

## IP Address Pool Selection
Set IP address ranges in IPAddressPool.ranges. This variable takes a list. A range can be defined as follows:
```yaml
  - 192.168.50.20-192.168.50.50
  - 192.168.34.70-192.168.34.80
  # etc.
```

MetalLB will pick an IP from these ranges when a `LoadBalancer` Service type is deployed. Ensure that the IP ranges are available in your network and preserved for MetalLB.

## L2 Advertisement
Uses the IP pood defined in the `IPAddressPool` to tell MetalLB to broadcast `LoadBalancer` service IPs via ARP/NDP at layer 2, making them reachable on the local network. 

If `spcs.ipAddressPools` removed, IP advertisement will be randomly performed from any available pool in the namespace.
