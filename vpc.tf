resource "aws_vpc" "DemoBasicVPC" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  tags = {
    "Name" = var.vpc_name
  }
}
data "aws_vpc" "DemoManualVPC" {
  id = "vpc-04b2b9dcf94deaa46"
}

resource "aws_internet_gateway" "DemoBasicIGW" {
  vpc_id = aws_vpc.DemoBasicVPC.id
  tags = {
    "Name" = "${var.vpc_name}-IGW"
  }
  depends_on = [aws_vpc.DemoBasicVPC]
}

resource "aws_subnet" "DemoSubnet-1" {
  vpc_id            = aws_vpc.DemoBasicVPC.id
  cidr_block        = var.Public_subnet_1
  availability_zone = var.az1
  tags = {
    "Name" = "${var.vpc_name}-Public_Subnet-1"
  }
  depends_on = [aws_internet_gateway.DemoBasicIGW]
}
resource "aws_subnet" "DemoSubnet-2" {
  vpc_id            = aws_vpc.DemoBasicVPC.id
  cidr_block        = var.Public_subnet_2
  availability_zone = var.az2
  tags = {
    "Name" = "${var.vpc_name}-Public_Subnet-2"
  }
  depends_on = [aws_subnet.DemoSubnet-1]
}

resource "aws_subnet" "DemoSubnet-3" {
  vpc_id            = aws_vpc.DemoBasicVPC.id
  cidr_block        = var.Public_subnet_3
  availability_zone = var.az3
  tags = {
    "Name" = "${var.vpc_name}-Public_Subnet-3"
  }
  depends_on = [aws_subnet.DemoSubnet-2]
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_subnet" "DemoManualSubnet" {
  vpc_id                  = data.aws_vpc.DemoManualVPC.id
  availability_zone       = "ap-south-1c"
  cidr_block              = "10.200.30.0/24"
  map_public_ip_on_launch = true
  tags = {
    "Name" = "MGMTSubnet3"
  }
}