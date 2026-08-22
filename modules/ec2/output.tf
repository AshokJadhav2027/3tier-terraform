output "my-SG-pub-id" {
  description = "my-SG-pub-id"
  value = aws_security_group.my-SG-pub.id
}
output "my-SG-pvt-id" {
  description = "my-SG-pvt-id"
  value = aws_security_group.my-SG-pvt.id
}