output "vps_id" {
  value = aws_vpc.wp_vpc.id
}
output "wp-private-a" {
  value = aws_subnet.wp-private-a.id
}
output "wp-private-b" {
  value = aws_subnet.wp-private-b.id
}
output "wp-public-a" {
  value = aws_subnet.wp-public-a.id
}
output "wp-public-b" {
  value = aws_subnet.wp-public-b.id
}
output "wp-db-private-a" {
  value = aws_subnet.wp-db-private-a.id
}
output "wp-site-sg" {
  value = aws_security_group.wp-site-sg.id
}
output "wp-db-sg" {
  value = aws_security_group.wp-db-sg.id
}
output "wp-bastion-sg" {
  value = aws_security_group.wp-bastion-sg.id
}
