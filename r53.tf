resource "aws_route53_zone" "hamdance" {
  name = "hamdance.net"
}

resource "aws_route53_record" "hamdance" {
  zone_id = aws_route53_zone.hamdance.zone_id
  name    = "hamdance.net"
  type    = "A"

  alias {
    name                   = aws_lb.rearc.dns_name
    zone_id                = aws_lb.rearc.zone_id
    evaluate_target_health = true
  }
}
