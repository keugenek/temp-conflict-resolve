variable "site-name" {
  type    = string
  default = "kandj.wedding"
}

variable "cloudflare_api_token" {
  type      = string
  sensitive = true
}
