variable "ENV" {
}
variable "DOMAIN_NAME" {
}
variable "S3_WEBSITE_ENDPOINT" {
}
variable "S3_HOSTED_ZONE_ID" {
}
variable "PROJECT_TAGS" {
}


resource "aws_route53_zone" "topinia-web-zone" {
  name = var.DOMAIN_NAME
}

resource "aws_route53_record" "www-record" {
  zone_id = aws_route53_zone.topinia-web-zone.zone_id
  name    = var.ENV == var.PROJECT_TAGS.ProdTag ? var.DOMAIN_NAME : "${var.ENV}.${var.DOMAIN_NAME}"
  type    = "A"

  alias {
    name                   = var.S3_WEBSITE_ENDPOINT
    zone_id                = var.S3_HOSTED_ZONE_ID
    evaluate_target_health = false
  }
}
