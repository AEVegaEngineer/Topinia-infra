resource "aws_route53_zone" "topinia-web-zone" {
  name = var.domain_name
}

resource "aws_route53_record" "www-record" {
  zone_id = aws_route53_zone.topinia-web-zone.zone_id
  name    = var.domain_name
  type    = "A"

  alias {
    name                   = var.s3_website_endpoint
    zone_id                = var.s3_hosted_zone_id
    evaluate_target_health = false
  }
}
