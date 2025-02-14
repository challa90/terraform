terraform {
  required_version = ">=1.10.5"
  required_providers {
    aws = {
        version = "=4.0"
        source = "hashicorp/aws"
    }
  }
}

resource "aws_vpc" "myvpc" {
  cidr_block = "10.0.0.0/16"
  instance_tenancy = "default"
  tags = {
    name = "test"
  }
}
resource "aws_subnet" "mysubnet" {
  vpc_id = aws_vpc.myvpc.id
  cidr_block = "10.0.1.0/24"
  tags = {
    name = "test"
  }
}
resource "aws_internet_gateway" "myigw" {
  vpc_id = aws_vpc.myvpc.id
  tags = {
    name = "myigw"
  }
}


resource "aws_route_table" "myroute" {
  vpc_id = aws_vpc.myvpc.id
  route {
    cidr_block = "0.0.0.0/0" 
    gateway_id = aws_internet_gateway.myigw.id
  }
}

resource "aws_route_table_association" "subnetassociate" {
  subnet_id = aws_subnet.mysubnet.id
  route_table_id = aws_route_table.myroute.id
}
