output "bastion_dns" {
  value = module.LoadBalancers.bastion_dns
}
output "wordpress_dns" {
  value = module.LoadBalancers.wordpress_dns
}