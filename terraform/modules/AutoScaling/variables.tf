variable "wp-bastion-tg" {
  description = "Target group for bastion server"
}
variable "wp-site-tg" {
  description = "Target group for wordpress server"
}
variable "wp-private-a" {
  description = "Private subnet in A-az"
}
variable "wp-private-b" {
  description = "Private subnet in B-az"
}
variable "wp-site-sg" {
  description = "Security group for wordpress server"
}
variable "wp-bastion-sg" {
  description = "Security group for bastion server "
}
variable "key_name" {
  description = "SSH key name"
  default = "virginia"
}