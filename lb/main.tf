resource "aws_lb" "load-balancer" {
  name               = var.lb-name
  load_balancer_type = var.lb_type
  internal           = var.scheme
  security_groups = [var.lb_sg_id]
  subnets            = [var.subnet-1_id, var.subnet-2_id]

  enable_deletion_protection = false

  tags = {
   "Name" = var.lb-name
  }
}

resource "aws_lb_listener" "lb-listener" {
  load_balancer_arn = aws_lb.load-balancer.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.lb-target-group.arn
  }
}

resource "aws_lb_target_group" "lb-target-group" {
  name     = var.tg-name
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  tags = {
   "Name" = var.tg-name
  }
}

resource "aws_lb_target_group_attachment" "lb-tg-attachment-1" {
  target_group_arn = aws_lb_target_group.lb-target-group.arn
  target_id        = var.ec2-1_id
  port             = 80
}

resource "aws_lb_target_group_attachment" "lb-tg-attachment-2" {
  target_group_arn = aws_lb_target_group.lb-target-group.arn
  target_id        = var.ec2-2_id
  port             = 80
}