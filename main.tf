provider "aws" {}

variable "cidr_block" {
description = "subnet cidr block"
default = "10.0.20.0/24"
type = list(object({
  cidr-block = string
  name = string
}))
}

resource "aws_vpc" "dev-test" {
  cidr_block = var.cidr_block[1].cidr-block
  tags = {
    Name: var.cidr_block[1].name
    }
}

resource "aws_subnet" "dev-subnet" {
  vpc_id     = aws_vpc.dev-test.id
 cidr_block = var.cidr_block[0].cidr-block
  tags = {
    Name: var.cidr_block[0].name
    }
}


data "aws_vpc" "selected" {
  default = true
}
resource "aws_subnet" "dev-test2" {
  vpc_id = data.aws_vpc.selected.id
  cidr_block = "172.31.48.0/20"
}
output "vpc-id" {
  value = aws_vpc.dev-test.id
}
output "subnet-devtest2-id" {
  value = aws_subnet.dev-test2.id
}