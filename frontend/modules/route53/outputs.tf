output "zone_id" {
  value = aws_route53_zone.topinia-web-zone.zone_id
}
output "nameservers" {
  value = aws_route53_zone.topinia-web-zone.name_servers
}
