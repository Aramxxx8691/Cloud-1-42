provider "aws" {
  region = "eu-central-1"
}

resource "aws_eip" "my_static_ip" {
  instance = aws_instance.linux-client1.id
}

resource "aws_instance" "linux-client1" {
  ami           = "ami-03074cc1b166e8691"
  instance_type = "t2.micro"
  key_name      = "client1-frankfurt"

  tags = {
    Name = "Terraform_Linux1"
    Owner = "605134461026"
    project = "Inception"
  }
}
resource "aws_security_group" "web" {
  name        = "WebServer-SG"
  description = "Allow HTTP and HTTPS"

  dynamic "ingress" {
    for_each = ["80", "443"]
    content {
      description = "Allow HTTP/HTTPS"
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name  = "WebServer SG by Terraform_Linux1"
    Owner = "605134461026"
  }
}

