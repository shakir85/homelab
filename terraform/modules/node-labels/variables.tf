/**
* Labels to apply to the node.
*/
variable "node_label_map" {
  description = "Map of node names to label key-values"
  type        = map(map(string))
}
