provider "aws" {
  region     = var.region
}

terraform {
  backend "s3" {
    bucket = "dimeder"
    key    = "terraform/wordpress-demo/wordpress-demo.tfstate"
    region = "us-east-1"
  }
}

module "VPC" {
  source = "./modules/VPC"
}

module "ALB" {
  source = "./modules/EC2/ALB"
  wp-public-a = module.VPC.wp-public-a
  wp-public-b = module.VPC.wp-public-b 
}



