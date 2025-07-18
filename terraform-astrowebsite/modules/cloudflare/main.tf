terraform {
  required_providers {
    cloudflare = {
      source = "cloudflare/cloudflare"
      version = "5.7.1"
    }
  }
}

resource "cloudflare_dns_record" "cdn_cname" {
  name = var.cdn_hostname
  ttl = 60
  type = "CNAME"
  content = var.cdn_endpoint_uri
  zone_id = var.zone_id
  comment = "Azure CDN"
}

resource "cloudflare_dns_record" "web_app_txt" {
  name = "asuid.${var.website_hostname}"
  ttl = 60
  type = "TXT"
  content = var.web_app_domain_verification_id
  zone_id = var.zone_id
  comment = "Azure Web app verification"
}

data "dns_a_record_set" "web_app_ip_address" {
  host = var.web_app_default_domain
}

resource "cloudflare_dns_record" "web_app_a" {
  name = "${var.website_hostname}"
  ttl = 60
  type = "A"
  content = data.dns_a_record_set.web_app_ip_address.addrs[0]
  zone_id = var.zone_id
  comment = "Azure Web app IP"

  depends_on = [ data.dns_a_record_set.web_app_ip_address ]
}

resource "time_sleep" "sleep_2mins" {
  create_duration = "120s"
}
