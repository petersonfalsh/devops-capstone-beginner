

provider "aws" {
  region = "us-west-2" # Change to your preferred region
}

resource "aws_security_group" "instance" {
  name_prefix = "terraform-instance-"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "Project_2_Peter" {
  ami           = "ami-0cf2b4e024cdb6960" # Update this with the valid AMI ID
  instance_type = "t2.micro"    # Change to your preferred instance type
  key_name      = "p2_key(Kodehauz project)"  # Name of the key pair

  user_data = <<-EOF
                #!/bin/bash
                sudo apt-get update -y
                sudo apt-get install -y docker.io
                sudo systemctl start docker
                sudo usermod -aG docker ubuntu
                sudo systemctl enable docker
                sudo docker pull petersonfalsh/kodehauz-capstone-docker-project:latest
                sudo docker run -d -p 80:3000 petersonfalsh/kodehauz-capstone-docker-project:latest
              EOF

  tags = {
    Name = "Project_2_Instance"
  }

  vpc_security_group_ids = [aws_security_group.instance.id]
}



