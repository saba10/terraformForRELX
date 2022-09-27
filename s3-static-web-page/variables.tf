#access and secret key values are defined as environment variables
variable "aws_access_key" {
  type        = string
  description = "AWS Access Key"
  sensitive   = true
}

variable "aws_secret_key" {
  type        = string
  description = "AWS Secret key"
  sensitive   = true
}

variable "aws_region" {
  type        = string
  description = " AWS Region"
  default     = "us-east-1"
}