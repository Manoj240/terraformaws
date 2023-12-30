#s3 bucket has to be created first, In my scenario i created bucket first then added this backend provider
terraform {
  backend "s3" {
    bucket         = "manojs3tfbucket" # change this
    key            = "mklearning/terraform.tfstate" #if we want store in some folder structure
    region         = "us-east-1"
    #encrypt        = true
    #dynamodb_table = "terraform-lock"
  }
}