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
    key            = "remote/resources/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "saba-tf-test"
  }
}

provider "aws" {
  region = var.aws_region
}

data "aws_ssm_parameter" "ami" {
  name = "/aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2"
}

##Remote state from local
# data "terraform_remote_state" "aws_vpc" {
#   backend = "local"
#   config = {
#     path = "remote/vpc/terraform.tfstate"
#   }
# }


data "terraform_remote_state" "aws_vpc" {
  backend = "s3"
  config = {
    bucket = "saba-tf-test"
    key    = "remote/vpc/terraform.tfstate"
    region = "us-east-1"
  }
}


resource "aws_instance" "instance" {
  count = var.instance_count

  ami           = nonsensitive(data.aws_ssm_parameter.ami.value)
  instance_type = var.aws_instance_type["micro"]
  subnet_id     = data.terraform_remote_state.aws_vpc.outputs.public_subnet[0]
  #   vpc_security_group_ids = [aws_security_group.nginx-sg.id]


  #   key_name = aws_key_pair.random.key_name

  tags = local.common_tags
}