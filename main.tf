# Day 01
# Provider block to specify the AWS provider and region
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
  # Day 05 terraform backend so you need to apply again init it does not install by default it 
  backend "s3" {
    bucket = "for-terraform-statefile-store"
    region = "us-east-1"
    key = "terraform.tfstate"
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}

# Navigate to module myvpc main.tf
module "myvpc" {
  source = "./modules/myvpc"
}

module "ec2" {
  source              = "./modules/ec2"
  vpc_id              = module.myvpc.vpc_id
  public_subnet_1_id  = module.myvpc.public_subnet_1_id
  public_subnet_2_id  = module.myvpc.public_subnet_2_id
  private_subnet_1_id = module.myvpc.private_subnet_1_id
  private_subnet_2_id = module.myvpc.private_subnet_2_id
  private_subnet_3_id = module.myvpc.private_subnet_3_id
}
module "database" {
  source = "./modules/database"
  
  vpc_id = module.myvpc.vpc_id
  my-SG-pvt-id = module.ec2.my-SG-pvt-id

  db_subnet_ids = [
    module.myvpc.private_subnet_1_id,
    module.myvpc.private_subnet_2_id,
    module.myvpc.private_subnet_3_id
  ]
}














# resource block to create an EC2 instance
/*resource "aws_instance" "tf-server-1" {
  ami = "ami-0b6d9d3d33ba97d99"
  instance_type = "t3.micro"
  #using existing secutiry group & key pair and count veriable
  vpc_security_group_ids = ["sg-006406b698447b1f9"]
  count = 3
  key_name = "virginia_key"
  tags = {
    Name = "server-${count.index}"
  }
  
}*/

/*resource "aws_instance" "tf-server-1" {
  ami = "ami-0b6d9d3d33ba97d99"
  instance_type = "t3.micro"
  #using existing secutiry group & key pair and for each new name 
  vpc_security_group_ids = ["sg-07ffa90ed4646ff6d"]
  #count = 3
  #for_each = toset(["app-1", "web-1", "db-1"])
  for_each = tomap({  
     app = "app-1"
     web = "web-1"
     db = "db-1"
 }

  )
  key_name = "terraform-key"
  tags = {
    Name = each.value
  }
  
}*/

/*resource "aws_s3_bucket" "terraform" {
  bucket = "terraformbucket2003"
  tags = {
    Name = "dev"
  }

  
}*/
/*
#Day 02 and 03
resource "aws_instance" "tf-server-2" {
  ami = "ami-0b6d9d3d33ba97d99"
  instance_type = "t3.micro"
  key_name = "terraform-key"
  #Use security group created by terraform 
  #Reffered here in bracket by [resource_name.logical_name.attribute]
  vpc_security_group_ids = [aws_security_group.tf-SG.id]
  tags = {
    Name = "server-2"
  }
  lifecycle {
    create_before_destroy = true
  }
}
# Resource -> Create security group
resource "aws_security_group" "tf-SG" {
  name = "tf-SG"
  vpc_id = "vpc-08639154edf63e527"
  description = "security group for terraform allowing 80, 22 and 443"
  lifecycle {
    create_before_destroy = true
  }
  #define inbound rule
  ingress  {
    description = "allowing ssh"
    to_port = 22
    from_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress  {
    description = "allow http"
    to_port = 80
    from_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress  {
    description = "allow https"
    to_port = 443
    from_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }
  ingress {
    description = "allow mysql"
    to_port = 3306
    from_port = 3306
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress  {
    description = "allow all traffic"
    to_port = 0
    from_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  #lifecycle {
  #  create_before_destroy = true
  #}

}
*/


/*
 #practice
 resource "aws_vpc" "myvpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "myvpc"
    description = "1-vpc, 2-subnet, 1-igw, 2-route_table"
  }  
 }

resource "aws_subnet" "public_subnet" {
  vpc_id = aws_vpc.myvpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = "public_subnet"
  }
}
resource "aws_subnet" "private_subnet" {
  vpc_id = aws_vpc.myvpc.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "us-east-1b"
  tags = {
    Name = "private_subnet"
  }
}

resource "aws_internet_gateway" "myigw" {
  vpc_id = aws_vpc.myvpc.id
  tags = {
    Name = "myigw"
  }  
}  

resource "aws_route_table" "public_RT" {
  vpc_id = aws_vpc.myvpc.id
  tags = {
    Name = "public_RT"
  }
}

resource "aws_route_table" "private_RT" {
  vpc_id = aws_vpc.myvpc.id
  tags = {
    Name = "private_RT"
  }
  
}

resource "aws_route" "igw" {
  route_table_id = aws_route_table.public_RT.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.myigw.id
  
}

resource "aws_route_table_association" "public_RT_subnet" {
  subnet_id = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_RT.id
}

resource "aws_route_table_association" "private_RT_subnet" {
  subnet_id = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.private_RT.id

  
}

resource "aws_instance" "public_server_1" {
  ami = "ami-0b6d9d3d33ba97d99"
  instance_type = "t3.micro"
  key_name = "terraform-key"
  availability_zone = "us-east-1a"
  subnet_id = aws_subnet.public_subnet.id
  vpc_security_group_ids = [aws_security_group.myvpc-SG.id]
  tags = {
    Name = "public_server_1"
  }
}

resource "aws_instance" "priver_server_1" {
  ami = "ami-0b6d9d3d33ba97d99"
  instance_type = "t3.micro"
  availability_zone = "us-east-1b"
  subnet_id = aws_subnet.private_subnet.id
  key_name = "terraform-key"
  vpc_security_group_ids = [aws_security_group.myvpc-SG.id]
  tags = {
    Name = "private_server_1"
  }
}

resource "aws_security_group" "myvpc-SG" {
  name = "myvpc-SG"
  vpc_id = aws_vpc.myvpc.id
  description = "allows 22, 80 and 443"

  ingress {
    description = "allow ssh"
    to_port = 22
    from_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "allow http"
    to_port = 80
    from_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "allow https"
    to_port = 443
    from_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "allow all"
    to_port = 0
    from_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
}*/



# Day 03 Variable in terraform 
/*
resource "aws_instance" "tf-server-3" {
  ami = var.ami
  instance_type = var.instance_type 
  vpc_security_group_ids = ["sg-07ffa90ed4646ff6d"]
  key_name = var.key
  tags = {
    Name = "tf-server-3"
  }
  
}
*/

# Day 04

/*resource "aws_instance" "tf-web-4" {
  ami = var.ami
  instance_type = var.instance_type
  key_name = var.key
  availability_zone = var.availability_zone
  /* user_data = << -EOF
  #!/bin/bash
  apt update -y
  apt upgrade -y
  apt install nginx -y
  apt systemctl enable --now nginx
  apt systemctl status
  EOF 
  tags = {
    Name = "tf-wev-4"
  }
}
*/
/*
# Day 05

resource "aws_instance" "tf-web-5" {
  ami = "ami-0b6d9d3d33ba97d99"
  key_name = "terraform-key"
  instance_type = "t3.micro"
  tags = {
    Name = "tf-web-5"
  }
  
}
*/
/*
resource "aws_s3_bucket" "" {
  
}*/