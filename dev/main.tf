module "route53" {
  source                 = "../modules/route53"
  ENV                    = var.project_tags.Environment
  DOMAIN_NAME            = var.domain_name
  S3_WEBSITE_ENDPOINT    = module.website_bucket.website_endpoint
  S3_HOSTED_ZONE_ID      = var.s3_hosted_zone_id
  PROJECT_TAGS           = var.project_tags
  CLOUDFRONT_DOMAIN_NAME = module.cloudfront.cloudfront_domain_name
}

module "website_bucket" {
  source       = "../modules/s3"
  ENV          = var.project_tags.Environment
  DOMAIN_NAME  = var.domain_name
  PROJECT_TAGS = var.project_tags
}

module "acm" {
  source      = "../modules/acm"
  DOMAIN_NAME = var.domain_name
}

module "cloudfront" {
  source              = "../modules/cloudfront"
  DOMAIN_NAME         = var.domain_name
  S3_WEBSITE_ENDPOINT = module.website_bucket.website_endpoint
  CERTIFICATE_ARN     = module.acm.certificate_arn
}

resource "aws_route53_record" "cert_validation" {
  for_each = {
    for dvo in module.acm.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = module.route53.zone_id
}

resource "aws_acm_certificate_validation" "cert_validation" {
  certificate_arn         = module.acm.certificate_arn
  validation_record_fqdns = [for record in aws_route53_record.cert_validation : record.fqdn]
}

# module "lambda" {
#   source = "./lambda"
# }

# Add other modules as needed
