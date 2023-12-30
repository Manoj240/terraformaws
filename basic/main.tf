provider "aws" {
    region = "us-east-1" 
}

module "ec2_instance" {
    source = "./modules/ec2_instance"
    ami_value = "ami-079db87dc4c10ac91" # replace this
    instance_type_value = "t2.micro"
}

# resource "aws_s3_bucket" "s3_bucket" {
#   bucket = "manojs3tfbucket" # change this
# }

# resource "aws_dynamodb_table" "terraform_lock" {
#   name           = "terraform-lock"
#   billing_mode   = "PAY_PER_REQUEST"
#   hash_key       = "LockID"

#   attribute {
#     name = "LockID"
#     type = "S"
#   }
# }