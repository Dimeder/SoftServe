output "vps-id" {
  value = module.VPC.vps_id
}
output "wp-private-a" {
  value = module.VPC.wp-private-a
}
output "wp-private-b" {
  value = module.VPC.wp-private-b
}
output "wp-public-a" {
  value = module.VPC.wp-public-a
}
output "wp-public-b" {
  value = module.VPC.wp-public-b
}
output "wp-db-private-a" {
  value = module.VPC.wp-db-private-a
}
output "wp-site-sg" {
  value = module.VPC.wp-site-sg
}
output "wp-db-sg" {
  value = module.VPC.wp-db-sg
}
output "wp-bastion-sg" {
  value = module.VPC.wp-bastion-sg
}
