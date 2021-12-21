terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  required_version = ">= 0.14.9"
}

provider "aws" {
  profile = "default"
  region  = "us-east-2"
}

variable "server" {
  type = string
  default = "appserver"
}
variable "env" {
  type = string
  default = "dev"
}

data "aws_availability_zones" "available" {
  state = "available"
}
data "aws_regions" "current" {
  all_regions = true


}
data "aws_ami_ids" "ubuntu" {
  owners = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server-*"]

  }
}
output ami {
value = "${data.aws_ami_ids.ubuntu.ids[0]}"
}

output zone {
value = "${data.aws_availability_zones.available.names.*}"
}
output region {
value = "${data.aws_regions.current.names.*}"
}
output count {
value = length("${data.aws_regions.current.names.*}")
}
resource "aws_instance" "app_server1" {
  ami           = "ami-04db49c0fb2215364"
  instance_type = "t2.micro"
  key_name = "tf"
  availability_zone = "ap-south-1b"
  tags = {
      Name = "${var.server}-${var.env}"
}  
   user_data = <<EOF
                   #!/bin/bash
                    echo "I am root" > /tmp/bikkumar
   EOF
   ebs_block_device {
     device_name           = "/dev/sdb"
     delete_on_termination = true
     volume_type           = "gp2"
     volume_size           = 1
}
}
