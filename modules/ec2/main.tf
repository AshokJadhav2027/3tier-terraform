# Create Public-Server-1 in us-east-1a
resource "aws_instance" "public-server-1" {
  ami                    = var.ami
  key_name               = var.key_name
  availability_zone      = var.us-east-1a
  instance_type          = var.instance_type
  subnet_id              = var.public_subnet_1_id
  vpc_security_group_ids = [aws_security_group.my-SG-pub.id]
  tags = {
    Name = "public-server-1"
  }
}

# Create Public-Server-2 in us-east-1b
resource "aws_instance" "public-server-2" {
  ami                    = var.ami
  instance_type          = var.instance_type
  key_name               = var.key_name
  availability_zone      = var.us-east-1b
  subnet_id              = var.public_subnet_2_id
  vpc_security_group_ids = [aws_security_group.my-SG-pub.id]
  tags = {
    Name = "public-server-2"
  }
}

# Create Private-server-1 in us-east-1a
resource "aws_instance" "private-server-1" {
  ami                    = var.ami
  instance_type          = var.instance_type
  key_name               = var.key_name
  availability_zone      = var.us-east-1a
  subnet_id              = var.private_subnet_1_id
  vpc_security_group_ids = [aws_security_group.my-SG-pvt.id]
  tags = {
    Name = "private-server-1"
  }
}

# Create private-server-2 in us-east-1b
resource "aws_instance" "private-server-2" {
  ami                    = var.ami
  instance_type          = var.instance_type
  key_name               = var.key_name
  availability_zone      = var.us-east-1b
  subnet_id              = var.private_subnet_2_id
  vpc_security_group_ids = [aws_security_group.my-SG-pvt.id]
  tags = {
    Name = "private-server-2"
  }
}

resource "aws_" "name" {
  
}

resource "aws_security_group" "my-SG-pub" {
  name        = "my-SG"
  vpc_id      = var.vpc_id
  description = "allows 22 & 80 for public-servers"
  ingress {
    description = "allows ssh"
    to_port     = 22
    from_port   = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "allows http"
    to_port     = 80
    from_port   = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    description = "allows all egress"
    to_port     = 0
    from_port   = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Create Security group for private servers
resource "aws_security_group" "my-SG-pvt" {
  name        = "my-SG-pvt"
  vpc_id      = var.vpc_id
  description = "allows 22, 80 & 3306 for private servers"
  ingress {
    description = "allows ssh"
    to_port     = 22
    from_port   = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "allows http"
    to_port     = 80
    from_port   = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "allow 3306 for RDS"
    to_port     = 3306
    from_port   = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    description = "allows all egress"
    to_port     = 0
    from_port   = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
