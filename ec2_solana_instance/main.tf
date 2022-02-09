terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.65"
    }
  }

  required_version = ">= 1.0.9"
}

provider "aws" {
  profile = "default"
  region  = "us-east-1" # virginia
}

resource "aws_instance" "solana_devel_server" {
  ami             = "ami-0a8b4cd432b1c3063"
  instance_type   = "t2.medium" #vCPU 2 - GiB 4
  key_name        = "KeyPairForEC2TestingInstancesVirginia"
  security_groups = ["${aws_security_group.solana_development_sg.name}"]

  # Copies the install-stuff.sh file to /tmp/install-stuff.sh
  provisioner "file" {
    source      = "install-stuff.sh"
    destination = "/tmp/install-stuff.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/install-stuff.sh",
      "sudo /tmp/install-stuff.sh"
    ]
  }

  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file("C:\\Users\\rafae\\.aws\\KeyPairForEC2TestingInstancesVirginia.pem")
    host        = self.public_ip
  }

  tags = {
    Name        = var.instance_name
    Owner       = var.owner
    Project     = var.project
    Environment = var.environment
  }
}

resource "aws_security_group" "solana_development_sg" {
  name = "solana-development-sg"

  ingress {
    description = "Access to SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Access to HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Access to HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow inboud RPC"
    from_port   = 8899
    to_port     = 8899
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  dynamic "ingress" {
    for_each = ["tcp", "udp"]
    content {
      description = format("Allow inbound %s on portrange 8000-8010", ingress.value)
      from_port   = 8000
      to_port     = 8010
      protocol    = ingress.value
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  # allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  #https://docs.solana.com/running-validator/validator-reqs#software
}
