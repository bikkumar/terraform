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

resource "aws_instance" "app_server" {
  count = 2
  ami           = "ami-08ee6644906ff4d6c"
  instance_type = "t2.micro"
  availability_zone = "ap-south-1b"
  key_name = "tf"
  tags = {
      Name = "neo${count.index}"
}
#   user_data = <<EOF
#   #!/bin/bash
#   sudo echo "I am root" > /tmp/bikkumar
#   EOF

  ebs_block_device {
     device_name           = "/dev/sdb"
     delete_on_termination = true
     volume_type           = "gp2"
     volume_size           = 1
     encrypted             = true
     kms_key_id            = aws_kms_key.mykey.id
      tags = {
        Name = "AppVol${count.index}"
   }
}
  ebs_block_device {
     device_name           = "/dev/sdc"
     delete_on_termination = true
     volume_type           = "gp2"
     volume_size           = 1
     encrypted             = true
     kms_key_id            = aws_kms_key.mykey.id
      tags = {
        Name = "AppVol${count.index}"
   }
}
}

resource "aws_route53_zone" "private" {
  name = "example.com"

  vpc {
    vpc_id = "vpc-d858a4b0"
  }
}
resource "aws_route53_record" "neo0" {
  zone_id = aws_route53_zone.private.zone_id
  name    = "neo0.example.com"
  type    = "A"
  ttl     = "300"
  records = [aws_instance.app_server[0].private_ip]
}
resource "aws_route53_record" "neo1" {
  zone_id = aws_route53_zone.private.zone_id
  name    = "neo1.example.com"
  type    = "A"
  ttl     = "300"
  records = [aws_instance.app_server[1].private_ip]
}

resource "aws_kms_key" "mykey" {
  description            = "KMSkey"
  deletion_window_in_days = 7
}

output "instance_ip" {
  value = aws_instance.app_server.*.private_ip
}


