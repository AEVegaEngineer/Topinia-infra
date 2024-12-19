variable "DOMAIN_NAME" {}

resource "aws_acm_certificate" "ssl_certificate" {
  domain_name       = var.DOMAIN_NAME
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}

output "certificate_arn" {
  value = aws_acm_certificate.ssl_certificate.arn
}

output "domain_validation_options" {
  value = aws_acm_certificate.ssl_certificate.domain_validation_options
}
