# Create IAM role for EKS Node Group
resource "aws_iam_role" "nodes_general" {
# Name of the role   
  name = "eks-node-group-general"

# The policy that grants an entity permission to assume the role.
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

# Resource: aws_iam_role_policy_attachment
resource "aws_iam_role_policy_attachment" "amazon_eks_worker_node_policy_general" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.nodes_general.name
}

resource "aws_iam_role_policy_attachment" "amazon_eks_cni_policy_general" {
    policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
    role       = aws_iam_role.nodes_general.name

}

resource "aws_iam_role_policy_attachment" "amazon_ec2_container_registry_read_only" {
    policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadonly"
    role       = aws_iam_role.nodes_general.name

}

#Resource: aws_eks_node_group
resource "aws_eks_node_group" "nodes_general" {
# Name of EKS Cluster.  
  cluster_name    = aws_eks_cluster.eks.name
# Name of EKS Node Group.  
  node_group_name = "nodes-general"
# ARN of the IAM Role that provides permissions for the EKS Node  
  node_role_arn   = aws_iam_role.nodes_general.arn

# Identifiers of EC2 Subnets to associate with the EKS Node Group.
# These Subnets must have the following reource tag: kubernetes.io/cluster/CLUSTER_NAME
# (where CLUSTER_NAME is replaced with the name of the EKS Cluster).  
  subnet_ids      = [
    aws_subnet.private_1.id,
    aws_subnet.private_2.id
  ]

# Configuration block with scaling settings
  scaling_config {
# Desired number of worker nodes.      
    desired_size = 1       ##### Get inputs from Tushar
# Maximum number of worker nodes.    
    max_size     = 1
# Minimum number of worker nodes.    
    min_size     = 1
  }

# Type of AMI associated with EKS Node Group.
# Valid values: AL2_x86_64, AL2_x86_64_GPU, AL2_ARM_64
  ami_type = "AL2_X86_64"
# Type of capacity associated with the EKS Node Group.
# Valid values: ON_DEMAND, SPOT 
  capacity_type = "ON_DEMAND"
#Disk size in GiB for worker nodes
  disk_size = 8

# force version update if existing pods are unable to be drained due to a pod disruption budget issue. 
  force_update_version = false
# List of instance types associated with EKS Node Group
  instance_types = ["t2.micro"]    ##### Get inputs

  labels = {
    "role" = "nodes-general"
  }
# Kuberetes version 
  version = "1.18"

# Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
# Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
  depends_on = [
    aws_iam_role_policy_attachment.amazon_eks_worker_node_policy_general,
    aws_iam_role_policy_attachment.amazon_eks_cni_policy_general,
    aws_iam_role_policy_attachment.amazon_ec2_container_registry_read_only,
  ]
}