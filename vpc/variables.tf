variable "aws_region" {
  type        = string
  description = " AWS Region"
  default     = "us-east-1"
}

variable "aws_cidr" {
  type        = list(string)
  description = "AWS VPC CIDR"
  default     = ["10.0.0.0/16"]
}

variable "subnet_count" {
  type        = number
  description = "number of subnets requried"
  default     = 2
}