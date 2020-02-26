data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_vpc" "wp_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "wordpress-vpc"
    type = "demo"
  }
}

resource "aws_subnet" "wp-public-a" {
  vpc_id            = aws_vpc.wp_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = data.aws_availability_zones.available.names[0]
  tags = {
    Name = "wp-public-a"
    type = "demo"
  }
}

resource "aws_subnet" "wp-public-b" {
  vpc_id            = aws_vpc.wp_vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = data.aws_availability_zones.available.names[1]

  tags = {
    Name = "wp-public-b"
    type = "demo"
  }
}

resource "aws_subnet" "wp-private-a" {
  vpc_id            = aws_vpc.wp_vpc.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = data.aws_availability_zones.available.names[0]

  tags = {
    Name = "wp-private-a"
    type = "demo"
  }
}

resource "aws_subnet" "wp-private-b" {
  vpc_id            = aws_vpc.wp_vpc.id
  cidr_block        = "10.0.4.0/24"
  availability_zone = data.aws_availability_zones.available.names[1]

  tags = {
    Name = "wp-private-b"
    type = "demo"
  }
}

resource "aws_subnet" "wp-db-private-a" {
  vpc_id            = aws_vpc.wp_vpc.id
  cidr_block        = "10.0.5.0/24"
  availability_zone = data.aws_availability_zones.available.names[0]

  tags = {
    Name = "wp-db-private-a"
    type = "demo"
  }
}

resource "aws_internet_gateway" "wp-igw" {
  vpc_id = aws_vpc.wp_vpc.id
  tags = {
    Name = "wp-internet-gateway"
    type = "demo"
  }
}

resource "aws_eip" "nat_private-a" {
  vpc = true
  tags = {
    Name = "nat-a"
    type = "demo"
  }
}

resource "aws_eip" "nat_private-b" {
  vpc = true
  tags = {
    Name = "nat-b"
    type = "demo"
  }
}

resource "aws_nat_gateway" "gw-private-a" {
  subnet_id     = aws_subnet.wp-public-a.id
  allocation_id = aws_eip.nat_private-a.id
  tags = {
    Name = "wp-private-a"
    type = "demo"
  }
}

resource "aws_nat_gateway" "gw-private-b" {
  subnet_id     = aws_subnet.wp-public-b.id
  allocation_id = aws_eip.nat_private-b.id
  tags = {
    Name = "wp-private-b"
    type = "demo"
  }
}

# Resources for ip routes for public subnets

resource "aws_route_table" "public-route-a" {
  vpc_id = aws_vpc.wp_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.wp-igw.id
  }

  tags = {
    Name = "public-route-a"
    type = "demo"
  }
}

resource "aws_route_table" "public-route-b" {
  vpc_id = aws_vpc.wp_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.wp-igw.id
  }

  tags = {
    Name = "public-route-b"
    type = "demo"
  }
}

resource "aws_route_table_association" "wp-public-a" {
  subnet_id = aws_subnet.wp-public-a.id 
  route_table_id = aws_route_table.public-route-a.id
}

resource "aws_route_table_association" "wp-public-b" {
  subnet_id = aws_subnet.wp-public-b.id 
  route_table_id = aws_route_table.public-route-b.id
}

# Resources for ip routes for private subnets

resource "aws_route_table" "private-route-a" {
  vpc_id = aws_vpc.wp_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.gw-private-a.id
  }

  tags = {
    Name = "private-route-a"
    type = "demo"
    
  }
}

resource "aws_route_table" "private-route-b" {
  vpc_id = aws_vpc.wp_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id  = aws_nat_gateway.gw-private-b.id
  }

  tags = {
    Name = "private-route-b"
    type = "demo"
  }
}

resource "aws_route_table_association" "wp-private-a" {
  subnet_id = aws_subnet.wp-private-a.id  
  route_table_id = aws_route_table.private-route-a.id
}

resource "aws_route_table_association" "wp-private-b" {
  subnet_id = aws_subnet.wp-private-b.id 
  route_table_id = aws_route_table.private-route-b.id
}

resource "aws_security_group" "wp-bastion-sg" {
  name        = "wp-bastion-sg"
  vpc_id      = aws_vpc.wp_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow SSH inbound traffic"
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  tags = {
    Name = "wp-bastion-sg"
    type = "demo"
  }
}

resource "aws_security_group" "wp-site-sg" {
  name        = "wp-site-sg"
  vpc_id      = aws_vpc.wp_vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow HTTP inbound traffic"
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    security_groups = [aws_security_group.wp-bastion-sg.id]
    description = "Allow SSH inbound traffic from bastion host"
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  tags = {
    Name = "wp-site-sg"
    type = "demo"
  }
}


resource "aws_security_group" "wp-db-sg" {
  name        = "wp-db-sg"
  vpc_id      = aws_vpc.wp_vpc.id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    security_groups = [aws_security_group.wp-site-sg.id]
    description = "Allow 3306 inbound traffic"
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
  tags = {
    Name = "wp-db-sg"
    type = "demo"
  }
}
