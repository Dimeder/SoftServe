resource "aws_db_subnet_group" "wp-db-subnet-group" {
  name       = "wp-db-subnet-group"
  subnet_ids = [var.wp-db-private-a, var.wp-db-private-b]
  tags = {
    Name = "WP DB subnet group"
  }
}

resource "aws_db_instance" "wp-db" {
  allocated_storage      = 20
  storage_type           = "gp2"
  engine                 = "mysql"
  engine_version         = "5.7.22"
  instance_class         = "db.t2.micro"
  identifier             = "wp"
  name                   = var.name_db
  username               = var.username
  password               = var.password
  skip_final_snapshot    = true
  db_subnet_group_name   = aws_db_subnet_group.wp-db-subnet-group.id
  vpc_security_group_ids = [var.wp-db-sg]
}

