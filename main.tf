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

output zone {
value = "${data.aws_availability_zones.available.names.*}"
}


