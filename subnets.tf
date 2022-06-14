resource "aws_subnet" "public_1" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"      ##### IP ranges to be discussed####
  availability_zone = "us-east-1a"

  # Required for EKS. Instances launched in to the subnet should be assigned public IPs.
  map_public_ip_on_launch = true

  # A map of tags to assign to the resource.
  tags = {
    Name                        = "public-us-east-1a"
    "kubernetes.io/cluster/eks" = "shared"
    "kubernetes.io/role/elb"    = 1  
  }
}


resource "aws_subnet" "public_2" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"      ##### IP ranges to be discussed####
  availability_zone = "us-east-1b"

  # Required for EKS. Instances launched in to the subnet should be assigned public IPs.
  map_public_ip_on_launch = true

  # A map of tags to assign to the resource.
  tags = {
    Name                        = "public-us-east-1b"
    "kubernetes.io/cluster/eks" = "shared"
    "kubernetes.io/role/elb"    = 1  
  }
}


resource "aws_subnet" "private_1" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"      ##### IP ranges to be discussed####
  availability_zone = "us-east-1a"

  
  # A map of tags to assign to the resource.
  tags = {
    Name                        = "private-us-east-1a"
    "kubernetes.io/cluster/eks" = "shared"
    "kubernetes.io/role/elb"    = 1  
  }
}


resource "aws_subnet" "private_2" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"      ##### IP ranges to be discussed####
  availability_zone = "us-east-1b"

  
  # A map of tags to assign to the resource.
  tags = {
    Name                        = "private-us-east-1b"
    "kubernetes.io/cluster/eks" = "shared"
    "kubernetes.io/role/elb"    = 1  
  }
}
