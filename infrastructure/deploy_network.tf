
resource "aws_subnet" "public-subnet" {
vpc_id = "${aws_vpc.app_vpc.id}"
cidr_block = "10.0.1.0/24"
availability_zone = "${var.region}a"

tags {
Name = "Web Public Subnet"
}
}
resource "aws_subnet" "public-subnet2" {
  vpc_id = "${aws_vpc.app_vpc.id}"
  cidr_block = "10.0.1.0/24"
  availability_zone = "${var.region}b"

  tags {
    Name = "Web Public Subnet"
  }
}

# Define the private subnet

resource "aws_vpc" "app_vpc" {
cidr_block = "10.0.0.0/16"
enable_dns_hostnames = true

tags {
Name = "${var.git_project}-vpc"
}
}


resource "aws_internet_gateway" "gw" {
  vpc_id = "${aws_vpc.app_vpc.id}"

  tags {
    Name = "VPC IGW"
  }
}

resource "aws_security_group" "sgweb" {
name = "vpc-sec-${var.git_project}"
description = "Allow incoming HTTP connections & SSH access"

ingress {
from_port = 80
to_port = 80
protocol = "tcp"
cidr_blocks = ["0.0.0.0/0"]
}


  ingress {
    from_port = 3000
    to_port = 3000
    protocol = "tcp"
    cidr_blocks =  ["0.0.0.0/0"]
  }


ingress {
from_port = 22
to_port = 22
protocol = "tcp"
cidr_blocks =  ["0.0.0.0/0"]
}

vpc_id="${aws_vpc.app_vpc.id}"

tags {
Name = "Web Server SG"
}
}