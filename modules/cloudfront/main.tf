variable "DOMAIN_NAME" {}
variable "S3_WEBSITE_ENDPOINT" {}
variable "CERTIFICATE_ARN" {}

resource "aws_cloudfront_distribution" "s3_distribution" {
  origin {
    domain_name = var.S3_WEBSITE_ENDPOINT
    origin_id   = "S3-${var.DOMAIN_NAME}"

    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "http-only"
      origin_ssl_protocols   = ["TLSv1.2"]
    }
  }

  enabled             = true
  is_ipv6_enabled     = true
  default_root_object = "index.html"

  aliases = [var.DOMAIN_NAME, "www.${var.DOMAIN_NAME}"]

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "S3-${var.DOMAIN_NAME}"

    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }

  price_class = "PriceClass_100"

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn = var.CERTIFICATE_ARN
    ssl_support_method  = "sni-only"
  }
}

output "cloudfront_domain_name" {
  value = aws_cloudfront_distribution.s3_distribution.domain_name
}
