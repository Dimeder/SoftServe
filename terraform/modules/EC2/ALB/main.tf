
resource "aws_lb" "test" {
  name               = "test-lb-tf"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [module.VPC.aws_security_group.wp-site-sg.id]
  subnets            = [module.VPC.aws_subnet.wp-private-a.id]

  enable_deletion_protection = true


  tags = {
    type = "demo"
  }
}
