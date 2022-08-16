terraform {
  cloud {
    organization = "jamcswain"

    workspaces {
      name = "KandJ-wedding"
    }
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.26.0"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "3.21.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

provider "cloudflare" {
  api_token = var.cloudflare_api_token
}

data "cloudflare_zone" "site-zone" {
  name = var.site-name
}

resource "aws_s3_bucket" "site-bucket" {
  bucket = var.site-name

  tags = {
    Name = var.site-name
  }
}

resource "aws_s3_bucket_acl" "public-bucket" {
  bucket = aws_s3_bucket.site-bucket.id
  acl    = "private"
}

resource "aws_s3_bucket_policy" "allow-public" {
  bucket = aws_s3_bucket.site-bucket.id
  policy = data.aws_iam_policy_document.allow-public.json
}

resource "aws_cloudfront_origin_access_identity" "cloudfront" {}

data "aws_iam_policy_document" "allow-public" {
  statement {
    sid     = "1"
    actions = ["s3:GetObject"]
    principals {
      type        = "*"
      identifiers = [aws_cloudfront_origin_access_identity.cloudfront.iam_arn]
    }

    resources = [
      "arn:aws:s3:::${var.site-name}/*",
    ]
  }
}

resource "aws_s3_object" "dist-js" {
  for_each = fileset("${path.module}/../dist", "*.js")

  bucket       = aws_s3_bucket.site-bucket.id
  key          = each.value
  source       = "${path.module}/../dist/${each.value}"
  etag         = filemd5("${path.module}/../dist/${each.value}")
  content_type = "text/javascript"
}

resource "aws_s3_object" "dist-png" {
  for_each = fileset("${path.module}/../dist", "*.png")

  bucket       = aws_s3_bucket.site-bucket.id
  key          = each.value
  source       = "${path.module}/../dist/${each.value}"
  etag         = filemd5("${path.module}/../dist/${each.value}")
  content_type = "image/png"
}

resource "aws_s3_object" "dist-img" {
  for_each = fileset("${path.module}/../dist/img", "*.png")

  bucket       = aws_s3_bucket.site-bucket.id
  key          = "img/${each.value}"
  source       = "${path.module}/../dist/img/${each.value}"
  etag         = filemd5("${path.module}/../dist/img/${each.value}")
  content_type = "image/png"
}

resource "aws_s3_object" "dist-css" {
  for_each = fileset("${path.module}/../dist", "*.css")

  bucket       = aws_s3_bucket.site-bucket.id
  key          = each.value
  source       = "${path.module}/../dist/${each.value}"
  etag         = filemd5("${path.module}/../dist/${each.value}")
  content_type = "text/css"
}

resource "aws_s3_object" "dist-xml" {
  for_each = fileset("${path.module}/../dist", "*.xml")

  bucket       = aws_s3_bucket.site-bucket.id
  key          = each.value
  source       = "${path.module}/../dist/${each.value}"
  etag         = filemd5("${path.module}/../dist/${each.value}")
  content_type = "application/xml"
}

resource "aws_s3_object" "dist-ico" {
  for_each = fileset("${path.module}/../dist", "*.ico")

  bucket       = aws_s3_bucket.site-bucket.id
  key          = each.value
  source       = "${path.module}/../dist/${each.value}"
  etag         = filemd5("${path.module}/../dist/${each.value}")
  content_type = "image/x-icon"
}

resource "aws_s3_object" "dist-txt" {
  for_each = fileset("${path.module}/../dist", "*.txt")

  bucket       = aws_s3_bucket.site-bucket.id
  key          = each.value
  source       = "${path.module}/../dist/${each.value}"
  etag         = filemd5("${path.module}/../dist/${each.value}")
  content_type = "text/plain"
}

resource "aws_s3_object" "dist-html" {
  for_each = fileset("${path.module}/../dist", "*.html")

  bucket       = aws_s3_bucket.site-bucket.id
  key          = each.value
  source       = "${path.module}/../dist/${each.value}"
  etag         = filemd5("${path.module}/../dist/${each.value}")
  content_type = "text/html"
}

resource "aws_s3_object" "dist-svg" {
  for_each = fileset("${path.module}/../dist", "*.svg")

  bucket       = aws_s3_bucket.site-bucket.id
  key          = each.value
  source       = "${path.module}/../dist/${each.value}"
  etag         = filemd5("${path.module}/../dist/${each.value}")
  content_type = "image/svg+xml"
}

resource "aws_s3_object" "dist-webmanifest" {
  for_each = fileset("${path.module}/../dist", "*.webmanifest")

  bucket       = aws_s3_bucket.site-bucket.id
  key          = each.value
  source       = "${path.module}/../dist/${each.value}"
  etag         = filemd5("${path.module}/../dist/${each.value}")
  content_type = "application/manifest+json"
}

resource "aws_acm_certificate" "site" {
  domain_name               = var.site-name
  subject_alternative_names = ["www.${var.site-name}"]
  validation_method         = "DNS"
}

resource "aws_cloudfront_distribution" "s3_distribution" {
  origin {
    domain_name = aws_s3_bucket.site-bucket.bucket_regional_domain_name
    origin_id   = var.site-name

    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.cloudfront.cloudfront_access_identity_path
    }
  }

  enabled             = true
  is_ipv6_enabled     = true
  default_root_object = "index.html"

  aliases = ["kandj.wedding", "www.kandj.wedding"]

  custom_error_response {
    error_code         = 403
    response_code      = 200
    response_page_path = "/index.html"
  }

  custom_error_response {
    error_code         = 404
    response_code      = 200
    response_page_path = "/index.html"
  }

  default_cache_behavior {
    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = var.site-name

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "allow-all"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }

  price_class = "PriceClass_100"

  restrictions {
    geo_restriction {
      restriction_type = "whitelist"
      locations        = ["US", "MX"]
    }
  }

  viewer_certificate {
    acm_certificate_arn = aws_acm_certificate_validation.validation.certificate_arn
    ssl_support_method  = "sni-only"
  }
}

resource "aws_acm_certificate_validation" "validation" {
  certificate_arn         = aws_acm_certificate.site.arn
  validation_record_fqdns = [for record in cloudflare_record.validation : record.hostname]
}

resource "cloudflare_record" "validation" {
  for_each = {
    for dvo in aws_acm_certificate.site.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  zone_id = data.cloudflare_zone.site-zone.id
  name    = each.value.name
  value   = each.value.record
  type    = each.value.type
  proxied = false
}

resource "cloudflare_record" "root" {
  zone_id = data.cloudflare_zone.site-zone.id
  name    = "@"
  value   = aws_cloudfront_distribution.s3_distribution.domain_name
  type    = "CNAME"
  proxied = true
}

resource "cloudflare_record" "www" {
  zone_id = data.cloudflare_zone.site-zone.id
  name    = "www"
  value   = var.site-name
  type    = "CNAME"
  proxied = true
}

resource "cloudflare_record" "caa" {
  zone_id = data.cloudflare_zone.site-zone.id
  name    = "@"
  data {
    flags = "0"
    tag   = "issue"
    value = "amazonaws.com"
  }
  type    = "CAA"
  proxied = false
}

resource "cloudflare_record" "caa-wild" {
  zone_id = data.cloudflare_zone.site-zone.id
  name    = "@"
  data {
    flags = "0"
    tag   = "issuewild"
    value = "amazonaws.com"
  }
  type    = "CAA"
  proxied = false
}
