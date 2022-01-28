variable "server" {
  type = string
  default = "appserver"
}
variable "env" {
  type = string
  default = "dev"
}
variable "public_subnet_cidr_blocks" {
  description = "Available cidr blocks for public subnets."
  type        = list(string)
  default     = [
    "10.0.1.0/24",
    "10.0.2.0/24",
    "10.0.3.0/24",
  ]
}

