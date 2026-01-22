variable "env" {
  type = string
}

variable "route53_domain" {
  type = string
}

variable "route53_records" {
  type = set(string)
}

variable "default_cache_behavior" {
  type = object({
    allowed_methods  = optional(list(string), ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"])
    cached_methods   = optional(list(string), ["GET", "HEAD"])
    target_origin_id = string
    forwarded_values = object({
      query_string = bool
      headers      = list(string)
      cookies = object({
        forward = string
      })
    })
    viewer_protocol_policy = optional(string, "redirect-to-https")
    min_ttl                = optional(number, 0)
    default_ttl            = optional(number, 3600)
    max_ttl                = optional(number, 3600)
  })
}

variable "origins" {
  type = set(object({
    origin_id = string
  }))
}
