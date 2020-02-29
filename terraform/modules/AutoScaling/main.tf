data "aws_ami" "amazon_linux2" {
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["amazon"]
}

resource "aws_launch_configuration" "wp-bastion-lc" {
  name_prefix     = "wp-bastion-lc"
  image_id        = data.aws_ami.amazon_linux2.id
  instance_type   = "t2.micro"
  security_groups = [var.wp-bastion-sg]
  key_name        = var.key_name
  
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "wp-bastion-ag" {
  name                 = "wp-bastion-ag"
  launch_configuration = aws_launch_configuration.wp-bastion-lc.id
  min_size             = 1
  max_size             = 1
  target_group_arns    = [var.wp-bastion-tg]
  vpc_zone_identifier  = [var.wp-private-a, var.wp-private-b]
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_launch_configuration" "wp-site-lc" {
  name_prefix     = "wp-site-lc"
  image_id        = data.aws_ami.amazon_linux2.id
  instance_type   = "t2.micro"
  security_groups = [var.wp-site-sg]
  key_name        = var.key_name
  user_data       = data.template_file.wp-config.rendered

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "wp-site-ag" {
  name                 = "wp-site-ag"
  launch_configuration = aws_launch_configuration.wp-site-lc.id
  min_size             = 2
  max_size             = 2
  health_check_type    = "EC2"
  target_group_arns    = [var.wp-site-tg]
  vpc_zone_identifier  = [var.wp-private-a, var.wp-private-b]
  lifecycle {
    create_before_destroy = true
  }
}

data "template_file" "wp-config" {
  template = file("modules/AutoScaling/user_data.sh.tpl")
  vars = {
    username = var.username
    password = var.password
    db-endpoint = var.db-endpoint
    name_db_instance = var.name_db_instance
    alb-endpoint = var.alb-endpoint
  }
}