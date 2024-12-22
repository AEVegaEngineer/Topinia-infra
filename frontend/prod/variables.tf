variable "aws_region" {
  default = "us-east-1"
}

variable "project_tags" {
  type = map(string)
  default = {
    "Project"     = "Topinia"
    "Environment" = "prod"
    "ProdTag"     = "prod"
  }
}

variable "domain_name" {
  description = "The domain name for the Route53 zone"
  type        = string
  default     = "topinia.com"
}

variable "s3_website_endpoint" {
  description = "The S3 website endpoint for the alias record"
  type        = string
  default     = "s3-website-us-east-1.amazonaws.com"
}

variable "s3_hosted_zone_id" {
  description = "The Route53 Hosted Zone ID for the S3 website endpoint"
  type        = string
  default     = "Z3AQBSTGFYJSTF"
}

