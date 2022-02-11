variable "instance_name" {
  description = "Value of the Name tag for the EC2 Solana Instance for Development"
  type        = string
  default     = "Solana-Devel-Instance"
}

variable "owner" {
  description = "Value of the Owner"
  type        = string
  default     = "djvruio@gmail.com"
}

variable "project" {
  type    = string
  default = "solana-research"
}

variable "environment" {
  type    = string
  default = "DEVEL"
}