resource "aws_eks_cluster" "test-eks-cluster" {
  name            = "${var.role}-${var.project}-${var.environment}"
  role_arn        = aws_iam_role.test-cluster.arn

  vpc_config {
    security_group_ids = [aws_security_group.test-cluster.id]
    subnet_ids         = local.public_route_table_id
  }

  depends_on = [
    "aws_iam_role_policy_attachment.attach-AmazonEKSClusterPolicy",
    "aws_iam_role_policy_attachment.attach-AmazonEKSServicePolicy",
  ]
}