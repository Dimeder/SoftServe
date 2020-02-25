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

module "LoadBalancers" {
  source      = "./modules/LoadBalancers"
  wp-public-a = module.VPC.wp-public-a
  wp-public-b = module.VPC.wp-public-b
  wp-site-sg  = module.VPC.wp-site-sg
  vps_id      = module.VPC.vps_id
}

 module "AutoScaling" {
   source = "./modules/AutoScaling"
   wp-bastion-tg = module.LoadBalancers.wp-bastion-tg
   wp-site-tg = module.LoadBalancers.wp-site-tg
   wp-private-a = module.VPC.wp-private-a
   wp-private-b = module.VPC.wp-private-b
   wp-site-sg  = module.VPC.wp-site-sg
   wp-bastion-sg = module.VPC.wp-bastion-sg
 }



