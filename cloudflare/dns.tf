#Cloudflare provider configuration
terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 4.0"
    }
  }
}

#Cloudflare authentication
provider "cloudflare" {
  api_token = "" #enter api token generated from cloudflare here https://developers.cloudflare.com/fundamentals/api/get-started/create-token/ 
}

#Cname record for "www.DOMAIN.com"
resource "cloudflare_record" "example" {
  allow_overwrite = "true"
  zone_id = "" #enter zone id from cloudflare here https://developers.cloudflare.com/fundamentals/setup/find-account-and-zone-ids/
  name    = "www"
  value   = "www.DOMAIN.com.s3-website.REGION.amazonaws.com" #replace DOMAIN with actual domain eg. example.com and REGION with bucket region eg eu.west-1
  type    = "CNAME"
  ttl     = "1" 
  proxied = "true" #allows you to route your website's traffic through Cloudflare's global network, providing various benefits such as improved performance, security, and reliability.
}

#Cname record for root "DOMAIN.com"
resource "cloudflare_record" "example1" {
  allow_overwrite = "true"
  zone_id = "" #enter zone id from cloudflare here https://developers.cloudflare.com/fundamentals/setup/find-account-and-zone-ids/
  name    = "@"
  value   = "DOMAIN.com.s3-website.REGION.amazonaws.com" #replace DOMAIN with actual domain eg. example.com and REGION with bucket region eg eu.west-1
  type    = "CNAME"
  ttl     = "1" 
  proxied = "true" #allows you to route your website's traffic through Cloudflare's global network, providing various benefits such as improved performance, security, and reliability.
}

#Cloudflare page rule which enforces the use of HTTPS for domain
resource "cloudflare_page_rule" "example3" {
  zone_id = "" #enter zone id from cloudflare here https://developers.cloudflare.com/fundamentals/setup/find-account-and-zone-ids/
  target  = "DOMAIN.com/*" #replace DOMAIN with actual domain eg "example.com/*"

  actions {
    always_use_https = true
  }
}

