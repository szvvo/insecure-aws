data "aws_ami" "ubuntu" {
    most_recent = true

    # get latest ubuntu 24.04LTs
    
    filter {
      name = "name"
      values = ["ubuntu/images/hvm-ssd/ubuntu-24.04-amd64-server-*"]
    }

    filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = [ "amazon" ]

}

