output "wp-bastion-tg" {
  value = aws_lb_target_group.wp-bastion-tg.id
}
output "wp-site-tg" {
  value = aws_lb_target_group.wp-site-tg.id
}
output "bastion_dns" {
  value = aws_lb.wp-bastion-elb.dns_name
}
output "wordpress_dns" {
  value = aws_lb.wp-site-alb.dns_name
}
