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
  region  = "ap-south-1"
}


data "aws_availability_zones" "available" {
  state = "available"
}
data "aws_regions" "current" {
  all_regions = true
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
  #ami           = "ami-052cef05d01020f1d"
  #ami            = "ami-0851b76e8b1bce90b"
   ami              = "ami-0f2e255ec956ade7f"
  instance_type = "t2.micro"
  key_name = "tf"
  availability_zone = "ap-south-1b"
  tags = {
      Name = "${var.server}-${var.env}"
}  
  user_data = "${file("name.sh")}"
   
ebs_block_device {
     device_name           = "/dev/sdb"
     delete_on_termination = true
     volume_type           = "gp2"
     volume_size           = 1
}
}
