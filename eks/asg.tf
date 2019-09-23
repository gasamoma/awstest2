data "aws_ami" "eks-worker" {
  filter {
    name   = "name"
    values = ["amazon-eks-node-${aws_eks_cluster.test-eks-cluster.version}-v*"]
  }

  most_recent = true
  owners      = ["602401143452"] # Amazon EKS AMI Account ID
}
data "aws_region" "current" {}

locals {
  demo-node-userdata = <<USERDATA
#!/bin/bash
set -o xtrace
/etc/eks/bootstrap.sh --apiserver-endpoint '${aws_eks_cluster.test-eks-cluster.endpoint}' --b64-cluster-ca '${aws_eks_cluster.test-eks-cluster.certificate_authority.0.data}' '${local.cluster_name}'
USERDATA
}

resource "aws_launch_configuration" "test-launch-config" {
  associate_public_ip_address = true
  iam_instance_profile        = aws_iam_instance_profile.test-node-profile.name
  image_id                    = data.aws_ami.eks-worker.id
  instance_type               = "m4.large"
  name_prefix                 = "terraform-eks-demo"
  security_groups             = [
    aws_security_group.test-node.id]
  user_data_base64            = base64encode(local.demo-node-userdata)

  lifecycle {
    create_before_destroy = true
  }
}
resource "aws_autoscaling_group" "test-asg" {
  desired_capacity     = var.desired_capacity
  launch_configuration = aws_launch_configuration.test-launch-config.id
  max_size             = var.max_size
  min_size             = var.min_size
  name                 = "eks-test-${var.project}-${var.environment}-asg"
  vpc_zone_identifier  = local.public_subnets_id

  tag {
    key                 = "Name"
    value               = "eks-test-${var.project}-${var.environment}-asg"
    propagate_at_launch = true
  }

  tag {
    key                 = "kubernetes.io/cluster/${local.cluster_name}"
    value               = "owned"
    propagate_at_launch = true
  }
}