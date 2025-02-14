terraform {
  required_version = ">=1.3.0"
  required_providers {
    aws = {
        version = "=4.0"
        source = "hashicorp/aws"
    }
  }
}

resource "aws_security_group" "allow_ssh_http_https" {
  name        = "allow_ssh_http_https"
  description = "Allow inbound SSH, HTTP, and HTTPS traffic"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow SSH from anywhere (adjust as needed)
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow HTTP from anywhere
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow HTTPS from anywhere
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"  # Allow all outbound traffic
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "my_ec2" {
  ami           = "ami-0c614dee691cbbf37"  # Replace with a valid AMI ID for your region
  instance_type = "t2.micro"  # Choose an instance type
 // key_name      = "my-key-pair"  # Replace with your SSH key pair name

  security_groups = [aws_security_group.allow_ssh_http_https.name]

  tags = {
    Name = "MyEC2Instance"
  }
}
