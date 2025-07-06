// ------------------------------------------------------------------
// MODULES DIRECTORY: ./module_setup/main.tf
// This is the main file for our module. It defines the insecure
// storage resources
// ------------------------------------------------------------------
resource "aws_vpc" "insecure_vpc" {
  cidr_block = var.vpc_cidr_block
}

// create an internet gateway to allow communication with the internet
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.insecure_vpc.id
}

// create a public route table
// this route send all outbound traffic (0.0.0.0/0) to the internet gateway
resource "aws_route_table" "public_rt" {
  depends_on = [ aws_internet_gateway.igw ]
  vpc_id = aws_vpc.insecure_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_route_table_association" "a" {
  subnet_id = aws_subnet.public_subnet_a.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "b" {
  subnet_id = aws_subnet.public_subnet_b.id
  route_table_id = aws_route_table.public_rt.id
}

// create two public subnets
resource "aws_subnet" "public_subnet_a" {
  vpc_id = aws_vpc.insecure_vpc.id
  cidr_block = var.subnet_a_cidr_block
  availability_zone = "us-east-1a"

  // this makes the subnet to assign public IPs to instances lauched in it
  map_public_ip_on_launch = true
}

resource "aws_subnet" "public_subnet_b" {
  vpc_id = aws_vpc.insecure_vpc.id
  cidr_block = var.subnet_b_cidr_block
  availability_zone = "us-east-1b"

  // this makes the subnet to assign public IPs to instances lauched in it
  map_public_ip_on_launch = true
}

// insecure security group
// This security group allows ALL inbound traffic from ANY source on ANY port
// This is a critical vulnerability as it exposes any resource within this security groups to the entire internet

resource "aws_security_group" "wide_open_sg" {
  name = "wide-open-insecure-sg"
  description = "Allow all inbound traffic from anywhere"
  vpc_id = aws_vpc.insecure_vpc.id
  

  ingress {
    description = "Allow all inbound traffic"
    from_port = 0 # from any port
    to_port = 0  # to any port
    protocol = "-1" # Any protocol
    cidr_blocks = [ "0.0.0.0/0" ] # from any IP address 
  }

  egress {
    description = "Allows all outbound traffic"
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [ "0.0.0.0/0" ]
  }
}