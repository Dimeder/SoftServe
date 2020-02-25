output "wp-bastion-tg" {
  value = aws_lb_target_group.wp-bastion-tg.id
}
output "wp-site-tg" {
  value = aws_lb_target_group.wp-site-tg.id
}