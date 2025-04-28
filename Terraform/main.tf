terraform {
    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = "~>5.0"
        }
    }
}

provider "aws" {
    region = "us-east-2"
}

resource "aws_security_group" "ab_sg" {
  name        = "allow_ssh"
  vpc_id      = "vpc-0bcedd90e4cd983c9"

  ingress {
    description      = "SSH from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    description      = "website access"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_ssh"
  }
}

resource "aws_instance" "web" {
    ami           = "ami-04f167a56786e4b09"
    instance_type = "t2.micro"
    key_name      = "sidhu"
    vpc_security_group_ids = [aws_security_group.ab_sg.id]

    tags = {
        Name = "TerraformWebServer" 
    }

    connection {
        type        = "ssh"
        user        = "ubuntu"
        private_key = file("~/sidhu.pem")
        host        = self.public_ip
    }
}

output "instance_ip" {
  value = aws_instance.web.public_ip
}

