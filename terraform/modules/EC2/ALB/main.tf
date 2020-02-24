resource "aws_lb" "Test" {
  name               = "test-lb-tf"
  internal           = false
  load_balancer_type = "application"
  subnets = [var.wp-public-a, var.wp-public-b ]

  tags = {
    Name = "Test"
  }
}
