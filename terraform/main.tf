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


