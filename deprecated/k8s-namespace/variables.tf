/**
* Name of the namespace to create.
*/
variable "name" {
  type        = string
  description = "The name of the namespace"
}

/**
* Labels to apply to the namespace.
*/
variable "labels" {
  type        = map(string)
  description = "Map of labels to apply to the namespace"
  default     = {}
}

/**
* Annotations to apply to the namespace.
*/
variable "annotations" {
  type        = map(string)
  description = "Map of annotations to apply to the namespace"
  default     = {}
}
