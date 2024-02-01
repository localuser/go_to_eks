# Define the AWS provider and specify the region
provider "aws" {
 region = "us-west-2" # Change this to your preferred AWS region
}

# Define the VPC and subnets
module "vpc" {
 source = "terraform-aws-modules/vpc/aws"
 version = "5.5.1"

 name = "my-vpc"
 cidr = "10.0.0.0/16"

 azs = ["us-west-2a", "us-west-2b", "us-west-2c"]
 private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
 public_subnets = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]

 enable_nat_gateway = true
 single_nat_gateway = true

 tags = {
    Name = "my-vpc"
 }
}

# Generate a private key
resource "tls_private_key" "my-private-key" {
 algorithm = "RSA"
 rsa_bits = 4096
}

# Create a key pair in AWS using the generated private key
resource "aws_key_pair" "generated_key" {
 key_name   = "my-key"
 public_key = tls_private_key.my-private-key.public_key_openssh

 provisioner "local-exec" {
    command = "echo '${tls_private_key.my-private-key.private_key_pem}' > ./my-key.pem"
 }
}

# Create an EKS cluster
module "eks" {
 source          = "terraform-aws-modules/eks/aws"
 cluster_name    = "my-cluster"
 #cluster_version = "1.20"
 subnet_ids         = module.vpc.private_subnets
 vpc_id          = module.vpc.vpc_id

 eks_managed_node_groups = {
    eks_nodes = {
      desired_capacity = 3
      max_capacity     = 5
      min_capacity     = 1

      instance_type = "t3.micro"
      key_name      = aws_key_pair.generated_key.key_name
    }
 }
}

