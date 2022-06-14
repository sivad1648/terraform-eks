resource "aws_nat_gateway" "gw1" {
 # The allocation ID of Elastic IP address for the gateway.
  allocation_id = aws_eip.nat1.id
 # The subnet ID of the subnet in which to place the gateway. 
  subnet_id     = aws_subnet.public_1.id

  tags = {
    Name = "NAT 1"
  }
}

resource "aws_nat_gateway" "gw2" {
 # The allocation ID of Elastic IP address for the gateway.
  allocation_id = aws_eip.nat2.id
 # The subnet ID of the subnet in which to place the gateway. 
  subnet_id     = aws_subnet.public_2.id

  tags = {
    Name = "NAT 2"
  }
}
