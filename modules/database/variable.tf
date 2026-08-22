variable "vpc_id" {
  type = string
}

variable "db_subnet_ids" {
  type = list(string)
}
variable "my-SG-pvt-id" {
  type = string
}