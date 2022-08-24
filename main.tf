resource "aws_vpc" "pro_vpc" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "pro_vpc"
  }
}

resource "aws_subnet" "subnet1" {
  vpc_id            = aws_vpc.pro_vpc.id
  cidr_block        = cidrsubnet("${var.vpc_cidr}", 8, 1)
  availability_zone = var.availability_zone

  tags = {
    Name = "pro_sub1"
  }
}

resource "aws_internet_gateway" "pro_igw" {
  vpc_id = aws_vpc.pro_vpc.id

  tags = {
    Name = "pro_igw"
  }
}

resource "aws_route_table" "pro_rt" {
  vpc_id = aws_vpc.pro_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.pro_igw.id
  }

  tags = {
    Name = "pro_rt"
  }

}

resource "aws_route_table_association" "pro_rtass1" {
  subnet_id      = aws_subnet.subnet1.id
  route_table_id = aws_route_table.pro_rt.id
}

resource "aws_security_group" "pro_sg" {
  name   = "pro_sg1"
  vpc_id = aws_vpc.pro_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "pro_1" {
  ami               = var.ami_id
  instance_type     = var.instance_type
  availability_zone = var.availability_zone
  key_name          = var.key
  root_block_device {
    volume_size = var.root_volume_size
  }
  subnet_id                   = aws_subnet.subnet1.id
  vpc_security_group_ids      = [aws_security_group.pro_sg.id]
  associate_public_ip_address = true
  tags = {
    name = "ansible"
  }
}