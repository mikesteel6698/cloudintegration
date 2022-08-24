variable "vpc_cidr" {
  type    = string
}

variable "availability_zone" {
  type    = string
}

variable "ami_id" {
  type    = string
}

variable "instance_type" {
  type    = string
}

variable "key" {
  type = string
}

variable "root_volume_size" {
  type    = number
}
