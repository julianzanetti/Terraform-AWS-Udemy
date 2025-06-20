module "alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "9.17.0"

  name    = "alb-application"
  vpc_id  = module.vpc.vpc_id
  subnets = module.vpc.public_subnets

# Security Group
  security_groups = [module.loadbalancer-security-group.security_group_id]

# Listeners
  listeners = {
    my-http-listener = {
      port     = 80
      protocol = "HTTP"
      forward = {
        target_group_key = "my-tg1"
      }
    }
  }
    
# Target Groups
  target_groups = {
    my-tg1 = {
      name_prefix                       = "tg1-"
      protocol                          = "HTTP"
      port                              = 80
      target_type                       = "instance"
      deregistration_delay              = 10
      load_balancing_algorithm_type     = "weighted_random"
      load_balancing_anomaly_mitigation = "on"
      load_balancing_cross_zone_enabled = false
      protocol_version = "HTTP1"
      # VERY IMPORTANT: We will create aws_lb_target_group_attachment resource separately when we use create_attachment = false, refer above GitHub issue URL.
      # Attachments will be made externally
      # Github ISSUE: https://github.com/terraform-aws-modules/terraform-aws-alb/issues/316
      # Search for "create_attachment" to jump to that Github issue solution
      create_attachments = false

      target_group_health = {
        dns_failover = {
          minimum_healthy_targets_count = 2
        }
        unhealthy_state_routing = {
          minimum_healthy_targets_percentage = 50
        }
      }

      health_check = {
        enabled             = true
        interval            = 30
        path                = "/app1/index.html"
        port                = "traffic-port"
        healthy_threshold   = 3
        unhealthy_threshold = 3
        timeout             = 6
        protocol            = "HTTP"
        matcher             = "200-399"
      }
      tags = local.commom_tags
    }
  }
  tags = local.commom_tags
}

resource "aws_lb_target_group_attachment" "my-tg1" {
  for_each = {for ec2-instance, ec2-details in module.private_ec2_instance: ec2-instance => ec2-details}
  target_group_arn = module.alb.target_groups["my-tg1"].arn
  target_id        = each.value.id
  port             = 80
}