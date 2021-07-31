resource "aws_route53_zone" "hamdance" {
  name = "hamdance.net"
}

resource "aws_route53_record" "hamdance" {
  zone_id = aws_route53_zone.hamdance.zone_id
  name    = "hamdance.net"
  type    = "A"
  depends_on = [
    aws_route53_zone.hamdance
  ]

  alias {
    name                   = aws_lb.rearc.dns_name
    zone_id                = aws_lb.rearc.zone_id
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "hamdance-validation" {
  zone_id = aws_route53_zone.hamdance.zone_id
  name = "_c2a6a2e30813cb62ea0625f1c81fa02f.hamdance.net."
  type = "CNAME"
  ttl = 5
  records = ["_af09e6bbccc609411baa8b7b897a7c63.qqqfmgwtgn.acm-validations.aws."]
  depends_on = [
    aws_acm_certificate.hamdance
  ]
}

resource "aws_acm_certificate" "hamdance" {
  domain_name       = "hamdance.net"
  validation_method = "DNS"

  tags = {
    Environment = "rearc"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route53_zone" "hamdance-com" {
  name = "hamdance.com"
}

resource "aws_route53_record" "hamdance-com" {
  zone_id = aws_route53_zone.hamdance.zone_id
  name    = "hamdance.com"
  type    = "A"
  depends_on = [
    aws_route53_zone.hamdance
  ]

  alias {
    name                   = aws_lb.rearc.dns_name
    zone_id                = aws_lb.rearc.zone_id
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "hamdance-validation-com" {
  zone_id = aws_route53_zone.hamdance.zone_id
  name = "_c2a6a2e30813cb62ea0625f1c81fa02f.hamdance.com."
  type = "CNAME"
  ttl = 5
  records = ["_af09e6bbccc609411baa8b7b897a7c63.qqqfmgwtgn.acm-validations.aws."]
  depends_on = [
    aws_acm_certificate.hamdance
  ]
}

resource "aws_acm_certificate" "hamdance-com" {
  domain_name       = "hamdance.com"
  validation_method = "DNS"

  tags = {
    Environment = "rearc"
  }

  lifecycle {
    create_before_destroy = true
  }
}



