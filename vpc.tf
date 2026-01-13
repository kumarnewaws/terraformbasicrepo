resource "aws_vpc" "DemoBasicVPC" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  tags = {
    "Name" = var.vpc_name
  }
}

resource "aws_internet_gateway" "DemoBasicIGW" {
  vpc_id = aws_vpc.DemoBasicVPC.id
  tags = {
    "Name" = "${var.vpc_name}-IGW"
  }
}

resource "aws_subnet" "DemoSubnet-1" {
  vpc_id            = aws_vpc.DemoBasicVPC.id
  cidr_block        = var.Public_subnet_1
  availability_zone = var.az1
  tags = {
    "Name" = "${var.vpc_name}-Public_Subnet-1"
  }
}
resource "aws_subnet" "DemoSubnet-2" {
  vpc_id            = aws_vpc.DemoBasicVPC.id
  cidr_block        = var.Public_subnet_2
  availability_zone = var.az2
  tags = {
    "Name" = "${var.vpc_name}-Public_Subnet-2"
  }
}

resource "aws_subnet" "DemoSubnet-3" {
  vpc_id            = aws_vpc.DemoBasicVPC.id
  cidr_block        = var.Public_subnet_3
  availability_zone = var.az3
  tags = {
    "Name" = "${var.vpc_name}-Public_Subnet-3"
  }
}
