resource "aws_lb" "wp-site-alb" {
  name               = "wp-site-alb"
  internal           = false
  load_balancer_type = "application"
  subnets = [var.wp-public-a, var.wp-public-b]
  security_groups = [var.wp-site-sg]
  
  tags = {
    Name = "wp-site-alb"
    type = "demo"
  }
}

resource "aws_lb_target_group" "wp-site-tg" {
  name     = "wp-site-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vps_id
}

resource "aws_lb_listener" "wp-site-alb" {
  load_balancer_arn = aws_lb.wp-site-alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.wp-site-tg.arn
  }
}

resource "aws_lb" "wp-bastion-elb" {
  name               = "wp-bastion-elb"
  internal           = false
  load_balancer_type = "network"
  subnets            = [var.wp-public-a, var.wp-public-b]

  tags = {
     Name = "wp-bastion-elb"
     type = "demo"
  }
}

resource "aws_lb_target_group" "wp-bastion-tg" {
  name     = "wp-bastion-tg"
  port     = 22
  protocol = "TCP"
  vpc_id   = var.vps_id
}

resource "aws_lb_listener" "wp-bastion-elb" {
  load_balancer_arn = aws_lb.wp-bastion-elb.arn
  port              = "22"
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.wp-bastion-tg.arn
  }
}
