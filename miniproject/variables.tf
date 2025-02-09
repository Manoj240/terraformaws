# Define the CIDR block for the VPC
variable "cidr" {
  description = "The CIDR block for the VPC."
  default     = "10.0.0.0/16"
}

# Define the name tag for resources
variable "nametag" {
  description = "Name tag for resources"
  type        = string
  default     = "mkterra"
}
