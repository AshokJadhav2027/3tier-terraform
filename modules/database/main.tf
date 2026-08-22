resource "aws_db_subnet_group" "db_subnet_group" {
  name       = "main-db-subnet-group"
  subnet_ids = var.db_subnet_ids

  tags = {
    Name = "My DB Subnet Group"
  }
}

# Create RDS 
resource "aws_db_instance" "mydatabase" {
  availability_zone      = "us-east-1c"
  db_name                = "mydatabase"
  identifier             = "mysql-db"
  allocated_storage      = 20
  storage_type           = "gp3"
  engine                 = "mysql"
  engine_version         = "8.0"
  instance_class         = "db.t3.micro"
  username               = "admin"
  password               = "Pass1234"
  parameter_group_name   = "default.mysql8.0"
  skip_final_snapshot    = true
  db_subnet_group_name   = aws_db_subnet_group.db_subnet_group.name
  vpc_security_group_ids = [aws_security_group.my-SG-pvt.id]
}

# Create Security group for database
resource "aws_security_group" "my-SG-pvt" {
  name        = "my-SG-db"
  vpc_id      = var.vpc_id
  description = "allows 22 & 3306 for private servers"
  ingress {
    description = "allows ssh"
    to_port     = 22
    from_port   = 22
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