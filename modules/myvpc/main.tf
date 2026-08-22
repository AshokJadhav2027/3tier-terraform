# Create VPC 
resource "aws_vpc" "myvpc" {
    cidr_block = "10.0.0.0/16"
    tags = {
      Name = "myvpc"
    } 
}

# Create Pubic-Subnet-1 in us-east-1a
resource "aws_subnet" "public-subnet-1" {
    vpc_id = aws_vpc.myvpc.id
    cidr_block = "10.0.1.0/24"
    availability_zone = "us-east-1a"
    map_public_ip_on_launch = true
    tags = {
      Name = "public-subnet-1"
      description = "for Frontent"
    }
}

# Create Public-Subnet-2 in us-east-1b
resource "aws_subnet" "public-subnet-2" {
    vpc_id = aws_vpc.myvpc.id
    cidr_block = "10.0.2.0/24"
    availability_zone = "us-east-1b"
    map_public_ip_on_launch = true
    tags = {
      Name = "public-subnet-2"
      description = "for Frontend"
    }
}

# Create private-Subnet-1 in us-east-1a
resource "aws_subnet" "private-subnet-1" {
    vpc_id = aws_vpc.myvpc.id
    cidr_block = "10.0.3.0/24"
    availability_zone = "us-east-1a"
    tags = {
      Name = "private-subnet-1"
      description = "for Backend"
    }
}

# Create private-Subnet-2 in us-east-1b
resource "aws_subnet" "private-subnet-2" {
    vpc_id = aws_vpc.myvpc.id
    cidr_block = "10.0.4.0/24"
    availability_zone = "us-east-1b"
    tags = {
      Name = "private-subnet-1b"
      description = "for Backend"
    }
}

# Create private-Subnet-3 in us-east-1c
resource "aws_subnet" "private-subnet-3" {
    vpc_id = aws_vpc.myvpc.id
    cidr_block = "10.0.5.0/24"
    availability_zone = "us-east-1c"
    tags = {
      Name = "private-subnet-3"
      description = "for Database RDS"
    }
}

#Create Internet Getway
resource "aws_internet_gateway" "myigw" {
    vpc_id = aws_vpc.myvpc.id
    tags = {
      Name = "myigw"
    }
}

# NAT Gateway for private subnets
resource "aws_nat_gateway" "mynat" {
  
   
  
}

# Create Public-Route table
resource "aws_route_table" "public_RT" {
    vpc_id = aws_vpc.myvpc.id
    tags = {
      Name = "public_RT"
    }
}

# Create private-Route table
resource "aws_route_table" "private_RT" {
    vpc_id = aws_vpc.myvpc.id
    tags = {
      Name = "private_RT"
    }
}

# Create Route Internet Getway
resource "aws_route" "myigw-route" {
    route_table_id = aws_route_table.public_RT.id
    destination_cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.myigw.id
}

# Create Route Association for public-RT
resource "aws_route_table_association" "public-RT-Association" {
    for_each =  {
      public1 = aws_subnet.public-subnet-1.id
      public2 = aws_subnet.public-subnet-2.id
    }
    subnet_id = each.value  
    route_table_id = aws_route_table.public_RT.id
}

# Create ROute Association for private-RT
resource "aws_route_table_association" "private-RT-Association" {
    for_each = {
      private1 = aws_subnet.private-subnet-1.id
      private2 = aws_subnet.private-subnet-2.id
      private3 = aws_subnet.private-subnet-3.id
    }
    subnet_id = each.value
    route_table_id = aws_route_table.private_RT.id
}