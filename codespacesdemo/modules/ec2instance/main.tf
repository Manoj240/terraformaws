provider "aws" {
    region = "us-east-1"
}

variable "ami" {
    description = "This is AMI for the instance"
}

variable "instance_type" {
    description = "This is type for the instance"
}

resource "aws_instance" "example1" {
    ami           =  var.ami # Specify an appropriate AMI ID
    instance_type = var.instance_type
}