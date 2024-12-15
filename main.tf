provider "aws" {
  region = var.aws_region
}

module "route53" {
  source = "./route53"
}

# module "lambda" {
#   source = "./lambda"
# }

# Add other modules as needed
