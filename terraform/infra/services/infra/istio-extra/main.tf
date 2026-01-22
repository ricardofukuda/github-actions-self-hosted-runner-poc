locals {
  public_elb_domain = data.kubernetes_service.istio_service_public.status.0.load_balancer.0.ingress.0.hostname
  public_elb_id     = regex("(.+)-(.+).us-east-1.elb.amazonaws.com", local.public_elb_domain)[0]
}

resource "aws_security_group_rule" "elb_allow_cloudfront" { # add CF prefixlist into the istio's public LB security group
  type              = "ingress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  prefix_list_ids   = [data.aws_ec2_managed_prefix_list.cloudfront.id]
  security_group_id = data.aws_elb.public.source_security_group_id
}

