output "database_endpoint" {
    description = "database endpoint"
    value = aws_db_instance.mydatabase.endpoint
}