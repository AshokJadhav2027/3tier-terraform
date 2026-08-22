output "vpc_id" {
  description = "vpc_id output of myvpc"
  value = module.myvpc.aws_vpc.vpc_id  
}

output "public_subnet_1_id" {
  description = "us-east-1a subnet public 1 id"
  value = aws_subnet.public-subnet-1.id
}

output "public_subnet_2_id" {
  description = "us-east-1b subnet public 2 id"
  value = aws_subnet.public-subnet-2.id
}

output "private_subnet_1_id" {
  description = "us-east-1a subnet private 1 id"
  value = aws_subnet.private-subnet-1.id
}

output "private_subnet_2_id" {
  description = "us-east-1b subnet private 2 id"
  value = aws_subnet.private-subnet-2.id
}

output "private_subnet_3_id" {
  description = "us-east-1c subnet private 3 id"
  value = aws_subnet.private-subnet-3.id
}


/*

output "public_subnet_1_id" {
  
  value = aws_subnet.public-subnet-1.id
}
output "public_subnet_2_id" {
  
  value = aws_subnet.public-subnet-2.id
}
output "private_subnet_1_id" {
  
  value = aws_subnet.private-subnet-1.id
}
output "private_subnet_2_id" {
  
  value = aws_subnet.private-subnet-2.id
}
output "private_subnet_3_id" {
  
  value = aws_subnet.private-subnet-3.id
}

*/