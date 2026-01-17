resource "aws_route_table" "DemoBasicRoute" {
  vpc_id = aws_vpc.DemoBasicVPC.id
  tags = {
    "Name" = "${var.vpc_name}-Public-Route"
  }
  route {
    gateway_id = aws_internet_gateway.DemoBasicIGW.id
    cidr_block = "0.0.0.0/0"
  }
  depends_on = [aws_subnet.DemoSubnet-3]
  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

resource "aws_route_table_association" "DemoBasicRoute1Association" {
  route_table_id = aws_route_table.DemoBasicRoute.id
  subnet_id      = aws_subnet.DemoSubnet-1.id
  depends_on     = [aws_route_table.DemoBasicRoute]
}
resource "aws_route_table_association" "DemoBasicRoute2Association" {
  route_table_id = aws_route_table.DemoBasicRoute.id
  subnet_id      = aws_subnet.DemoSubnet-2.id
  depends_on     = [aws_route_table_association.DemoBasicRoute1Association]
}
