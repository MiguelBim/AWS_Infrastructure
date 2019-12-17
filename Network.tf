resource "aws_vpc" "environment-test" {
  cidr_block = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support = true
  tags = {
      Name = "terraform-aws-vpc-test"
  }
}

#Adding a new subnet to the VPC created above which is specific to a data-center:
  # Advantages: 
      # Know the name of the subnet
      # Add a specific CIDR Block that is controlled vs one that is atumatically created
      # Add specific security groups
resource "aws_subnet" "subnet1" {
  # https://www.terraform.io/docs/providers/aws/r/vpc.html
  cidr_block = "${cidrsubnet(aws_vpc.environment-test.cidr_block, 3, 1)}"
    # (Required) The CIDR block for the VPC.
  vpc_id = "${aws_vpc.environment-test.id}"
  availability_zone = "us-east-1a"
}

resource "aws_subnet" "subnet2" {
  cidr_block = "${cidrsubnet(aws_vpc.environment-test.cidr_block, 2, 2)}"
  vpc_id = "${aws_vpc.environment-test.id}"
  availability_zone = "us-east-1b"
}

resource "aws_security_group" "subnetsecurity" {
  vpc_id = "${aws_vpc.environment-test.id}"
  ingress{
    cidr_blocks = [
      "${aws_vpc.environment-test.cidr_block}"
    ]
    from_port = 80
    to_port = 80
    protocol = "tcp"
  }
}


