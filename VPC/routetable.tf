#Creating a new Route Table
resource "aws_route_table" "PublicRouteTable" {
  vpc_id = "${aws_vpc.mainvpc.id}"
  route {
      cidr_block = "0.0.0.0/0"
      gateway_id = "${aws_internet_gateway.IGW_TF.id}"
  }
  tags = {
      Name = "PublicRouteTable"
  }
#route table depends on VPC and IGW
  depends_on = ["aws_vpc.mainvpc","aws_internet_gateway.IGW_TF"]
}


resource "aws_route_table_association" "publicroutetableassociation" {
  subnet_id      = "${aws_subnet.PublicSubnet_A.id}"
  route_table_id = "${aws_route_table.PublicRouteTable.id}"
  depends_on     = ["aws_subnet.PublicSubnet_A","aws_route_table.PublicRouteTable"]
}
#creating a Private Route table and it is associated with NAT gateway and a Private Subnet
resource "aws_route_table" "PrivateRouteTable" {
  vpc_id     = "${aws_vpc.mainvpc.id}"
  route {
      cidr_block = "0.0.0.0/0"
      gateway_id = "${aws_nat_gateway.NATGW.id}"
  }
  tags = {
    Name = "PrivateRouteTable"
  }
  depends_on = ["aws_vpc.mainvpc","aws_nat_gateway.NATGW"]
}

resource "aws_route_table_association" "privateroutetableassociation" {
  subnet_id      = "${aws_subnet.PrivateSubnet_A.id}"
  route_table_id = "${aws_route_table.PrivateRouteTable.id}"
  depends_on = ["aws_subnet.PrivateSubnet_A","aws_route_table.PrivateRouteTable"]
}

