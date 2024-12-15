output "nameservers" {
  value = aws_route53_zone.topinia-web-zone.name_servers
}
