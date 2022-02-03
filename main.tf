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


resource "aws_s3_bucket" "bucket" {
  bucket = "bik-tf-test-bucket"
  acl    = "private"

  tags = {
    Name        = "my bucket"
    Environment =  "${var.env}"
  }
}
resource "aws_s3_bucket_object" "folder1" {
    bucket = "${aws_s3_bucket.bucket.id}"
    acl    = "private"
    key    = "Folder1/"
    source = "/dev/null"
}
resource "aws_s3_bucket_object" "folder2" {
    bucket = "${aws_s3_bucket.bucket.id}"
    acl    = "private"
    key    = "Folder2/"
    source = "/dev/null"
}

output "bucket_folder1"{
  value       =  "https://${aws_s3_bucket.bucket.bucket_domain_name}/Folder1/"
  description = "FQDN of bucket Folder"
}
output "bucket_folder2"{
  value       =  "https://${aws_s3_bucket.bucket.bucket_domain_name}/Folder2/"
  description = "FQDN of bucket Folder"
}
resource "aws_s3_bucket_object" "object" {
  bucket = "${aws_s3_bucket.bucket.id}"
  acl    = "private"
  key    = "/Folder2/README.md"
  source = "/root/tf/README.md"
}
