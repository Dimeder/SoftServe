output "db-endpoint" {
  value = aws_db_instance.wp-db.address
}
output "name_db_instance" {
  value = aws_db_instance.wp-db.name
}
output "db_password" {
  value = aws_db_instance.wp-db.password
}
output "db_username" {
  value = aws_db_instance.wp-db.username
}