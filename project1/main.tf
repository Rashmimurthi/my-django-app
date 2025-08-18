provider "aws" {
    region = "us-east-1"  
}
# creating VPC 
resource "aws_vpc" "myvpc" {
    cidr_block = "10.0.0.0/16"
    enable_dns_hostnames = true
    enable_dns_support = true
    tags = {
      Name = "myvpc"
    }
}
#creating subnet
resource "aws_subnet" "public_subnet1" {
  vpc_id     = aws_vpc.myvpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-1a"
  tags = {
    Name = "public-subnet1"
  }
}
resource "aws_subnet" "private_subnet1" {
  vpc_id     = aws_vpc.myvpc.id
  cidr_block = "10.0.3.0/24"
  availability_zone = "us-east-1b"
  tags = {
    Name = "private-subnet1"
  }
}
#creating internetgateway
resource "aws_internet_gateway" "myigw" {
    vpc_id = aws_vpc.myvpc.id
    tags = {
    Name = "myigw"
  }
}
# Creating routables
resource "aws_route_table" "public_rtb" {
    vpc_id = aws_vpc.myvpc.id
    tags = {
    Name = "public-rtb"
  }
}
resource "aws_route_table" "private_rtb" {
    vpc_id = aws_vpc.myvpc.id
    tags = {
    Name = "private-rtb"
  }
}

#creating subnet association
resource "aws_route_table_association" "pub_rtb_association" {
  subnet_id      = aws_subnet.public_subnet1.id
  route_table_id = aws_route_table.public_rtb.id 
}
#attaching igw to public route
resource "aws_route" "pub_int_acess" {
  route_table_id = aws_route_table.public_rtb.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.myigw.id
}
resource "aws_route_table_association" "pri_rtb_association" {
  subnet_id      = aws_subnet.private_subnet1.id
  route_table_id = aws_route_table.private_rtb.id
}
