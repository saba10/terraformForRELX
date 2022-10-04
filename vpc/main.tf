terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>4.0"
    }
  }
  #using below config for storing state file requires a pre-exiting s3 bucket with versioning enabled and a dynamoDB table with 'LockID' as the primary key
  backend "s3" {
    bucket         = "saba-tf-test"
    key            = "remote/vpc/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "saba-tf-test"
  }
}

provider "aws" {
  region = var.aws_region
}

data "aws_availability_zones" "available" {
  state = "available"
}

##################################################################################
##MODULE
##################################################################################
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~>3.16.0"

  name = "my-vpc"
  cidr = var.aws_cidr[0]

  azs             = slice(data.aws_availability_zones.available.names, 0, var.subnet_count)
  private_subnets = [for i in range(var.subnet_count) : cidrsubnet(var.aws_cidr[0], 8, i + 10)]
  public_subnets  = [for i in range(var.subnet_count) : cidrsubnet(var.aws_cidr[0], 8, i)]

  enable_nat_gateway = false
  enable_vpn_gateway = false

  tags = local.common_tags

}