resource "aws_eks_cluster" "test-eks-cluster" {
  name            = local.cluster_name
  role_arn        = aws_iam_role.test-cluster.arn

  vpc_config {
    security_group_ids = [aws_security_group.test-cluster.id]
    subnet_ids         = local.public_subnets_id
  }

  depends_on = [
    "aws_iam_role_policy_attachment.attach-AmazonEKSClusterPolicy",
    "aws_iam_role_policy_attachment.attach-AmazonEKSServicePolicy",
  ]
}

locals {
  cluster_name = "eks-${var.project}-${var.environment}"
  config_map_aws_auth = <<EOF
apiVersion: v1
kind: ConfigMap
metadata:
  name: aws-auth
  namespace: kube-system
data:
  mapRoles: |
    - rolearn: ${aws_iam_role.test-node-role.arn}
      username: system:node:{{EC2PrivateDNSName}}
      groups:
        - system:bootstrappers
        - system:nodes
EOF
}

