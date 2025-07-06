variable "vpc_cidr_block" {
    description = "value"
    default = "172.20.0.0/16"
    type = string
}

variable "subnet_a_cidr_block" {
    default = "172.20.1.0/24"
  
}

variable "subnet_b_cidr_block" {
    default = "172.20.2.0/24"
  
}