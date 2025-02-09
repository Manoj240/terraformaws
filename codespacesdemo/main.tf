provider "aws" {
    region = "us-east-1"
}

variable "ami" {
  description = "value"
}

variable "instance_type" {
  description = "value"
  type = map(string)

  default = {
    "dev" = "t2.micro"
    "stage" = "t2.medium"
    "prod" = "t2.xlarge"
  }
}

module "ec2instance" {
    source = "./modules/ec2instance"
    ami = var.ami # replace this
    #if terraform.workspace value doesn't match with default keys 
    # in instance_type var, then it will take t2.micro as default value
    instance_type = lookup(var.instance_type, terraform.workspace, "t2.micro") 
}