resource "aws_vpc" "eks" {
    enable_dns_hostnames = true
    enable_dns_support = true
    cidr_block = "10.0.0.0/16"
    tags = {
      name = "eks"
    }
  
}

resource "aws_subnet" "public" {
    vpc_id = aws_vpc.eks.id
    cidr_block = "10.0.1.0/24"
    map_public_ip_on_launch = true
    availability_zone = "ap-south-1a"

  
}

resource "aws_subnet" "private" {
    vpc_id = aws_vpc.eks.id
    cidr_block = "10.0.2.0/24"
    availability_zone = "ap-south-1b"

}

resource "aws_internet_gateway" "all" {
    vpc_id = aws_vpc.eks.id
  
}

resource "aws_route_table" "internet" {
    vpc_id = aws_vpc.eks.id
    route {
          cidr_block = "0.0.0.0/0"
          gateway_id = aws_internet_gateway.all.id
    }
  
}

resource "aws_route_table_association" "connect" {
    subnet_id = aws_subnet.public.id
    route_table_id = aws_route_table.internet.id
  
}