resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"         ###########set the IP range as per norms######
  instance_tenancy = "default"
  
  # Required for EKS. Enable/disable DNS support in the VPC.
  enable_dns_support = true

  # Required for EKS. Enable/disable DNS hostnames in the VPC.
  enable_dns_hostnames = true

  # Enable/disable classicLink for VPC.
  enable_classiclink = false

  # Enable/disable classicLink DNS support for VPC.
  enable_classiclink_dns_support = false
  
  # Request an Amazon-provided IPv6 CIDR block with a /56 prefix
  enable_generated_ipv6_cidr_block = false

  # A map of tags to assign to the resource.
  tags = {
    Name = "main"
  }
}

output "vpc_id" {
  value       = aws_vpc.main.id
  description = "VPC id."
  # Setting an output value as sensitive prevents Terraform from showing its value in plan and apply
  sensitive = false    
}

