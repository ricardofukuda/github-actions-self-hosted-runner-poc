module "cloudfront" {
  source          = "../../../modules/cloudfront-distribution"
  route53_domain  = var.domain
  route53_records = ["website"]
  env             = var.env

  default_cache_behavior = { # ". If you create additional cache behaviors, the default cache behavior is always the last to be processed. Other cache behaviors are processed in the order in which they're listed in the CloudFront console"
    target_origin_id = "default"

    forwarded_values = {
      query_string = true
      headers      = ["*"] # "*" implicitely it is a no-cache because forward all requests to the Origin
      cookies = {
        forward = "all"
      }
    }
  }

  origins = [{
    origin_id = "default"
  }]
}
