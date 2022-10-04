variable "aws_region" {
  type        = string
  description = " AWS Region"
  default     = "us-east-1"
}

variable "instance_count" {
  type        = number
  description = "number of subnets requried"
  default     = 1
}

variable "aws_instance_type" {
  type        = map(string)
  description = "instance type"
  default = {
    micro = "t2.micro"
    small = "t2.small"
  }
}