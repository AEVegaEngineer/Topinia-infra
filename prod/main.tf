module "route53" {
  source              = "../modules/route53"
  ENV                 = var.project_tags.Environment
  DOMAIN_NAME         = var.domain_name
  S3_WEBSITE_ENDPOINT = var.s3_website_endpoint
  S3_HOSTED_ZONE_ID   = var.s3_hosted_zone_id
  PROJECT_TAGS        = var.project_tags
}

module "website_bucket" {
  source       = "../modules/s3"
  ENV          = var.project_tags.Environment
  DOMAIN_NAME  = var.domain_name
  PROJECT_TAGS = var.project_tags
}

# module "lambda" {
#   source = "./lambda"
# }

# Add other modules as needed
