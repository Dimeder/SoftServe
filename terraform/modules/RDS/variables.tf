variable "username" {
  description = "Username for db-instance"
  default     = ""
}
variable "password" {
  description = "Password for db-user"
  default     = ""
}
variable "name_db" {
  description = "db name"
  default     = ""
}
variable "wp-db-private-a" {
  description = "Private subnet in A-az"
}
variable "wp-db-private-b" {
  description = "Private subnet in B-az"
}
variable "wp-db-sg" {
  description = "Security group for database"
}