provider "aws" {}

variable "cidr_block"{
    description = " cidr block for vpc and subnetss"
    type = list(object({
        cidr_block = string
        name = string
    }))
}

variable "environment" {
    description =  "deployment environment"
}

variable avail_zone {}

resource "aws_vpc" "development-vpc" {
    cidr_block= var.cidr_block[0].cidr_block
    tags = {
        Name=  var.cidr_block[0].name
        vpc_env=  "dev"
    }
}

resource "aws_subnet" "dev-subnet-1" {
    vpc_id = aws_vpc.development-vpc.id
    cidr_block = var.cidr_block[1].cidr_block
    availability_zone = var.TF_VAR_avail_zone
    tags = {
        Name:  var.cidr_block[0].name
    }
}

output "dev-vpc-id" {
  value = aws_vpc.development-vpc.id
}


output "dev-subnet-id" {
  value = aws_subnet.dev-subnet-1.id
}