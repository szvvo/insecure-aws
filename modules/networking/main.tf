resource "aws_vpc" "main" {
  cidr_block = "172.20.0.0/16"
}

resource "aws_subnet" "main" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "172.20.1.0/24"
}

resource "aws_internet_gateway" "main" {
    vpc_id = aws_vpc.main.id
}