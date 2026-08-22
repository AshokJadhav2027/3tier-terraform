variable "ami" {
  default     = "ami-0b6d9d3d33ba97d99"
  description = "ami id of public server"
}

variable "key_name" {
  default     = "terraform-key"
  description = "private key for public server"
}

variable "us-east-1a" {
  default     = "us-east-1a"
  description = "az for 1a"
}

variable "us-east-1b" {
  default     = "us-east-1b"
  description = "az for 1b"
}

variable "us-east-1c" {
  default     = "us-east-1c"
  description = "az for 1c"
}

variable "instance_type" {
  default     = "t3.micro"
  description = "instance type"
}

variable "vpc_id" {
  type = string
}

variable "public_subnet_1_id" {
  type = string
}

variable "public_subnet_2_id" {
  type = string
}

variable "private_subnet_1_id" {
  type = string
}

variable "private_subnet_2_id" {
  type = string
}
variable "private_subnet_3_id" {
  type = string
}