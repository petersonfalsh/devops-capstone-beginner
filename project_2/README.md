

# Project 2: Infrastructure as Code with Terraform

## Overview
This project demonstrates how to manage infrastructure using Terraform to achieve consistent and reproducible environments. This documentation aims to develop an EC2 instance with a default VPC using Terraform and deploy the infrastructure using GitHub Actions.

## Prerequisites
- Terraform installed on your local machine
- AWS account with access keys

## Setup Instructions

### Step 1: Install Terraform

**For Ubuntu:**
```bash
sudo apt-get update && sudo apt-get install -y gnupg software-properties-common curl
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
sudo apt-get update && sudo apt-get install terraform
```

### Step 2: Create Terraform Configuration Files

1. **Create a directory for your Terraform configuration:**
```bash
mkdir myterraformproject
cd myterraformproject
```

2. **Create the main Terraform configuration file:**

**main.tf:**
```hcl
provider "aws" {
  region = "us-west-2"
}

resource "aws_instance" "example" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"

  tags = {
    Name = "example-instance"
  }
}
```

**variables.tf:**
```hcl
variable "aws_access_key" {
  description = "AWS Access Key"
}

variable "aws_secret_key" {
  description = "AWS Secret Key"
}

provider "aws" {
  region     = "us-west-2"
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

resource "aws_instance" "example" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"

  tags = {
    Name = "example-instance"
  }
}
```

### Step 3: Use Terraform Commands to Provision Infrastructure

1. **Initialize Terraform:**
```bash
terraform init
```

2. **Plan the infrastructure:**
```bash
terraform plan
```

3. **Apply the configuration to create the infrastructure:**
```bash
terraform apply
```

### Step 4: Write a Userdata Script for Docker Installation and Application Deployment

**main.tf:**
```hcl
provider "aws" {
  region = "us-west-2"
}

resource "aws_instance" "example" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"

  user_data = <<-EOF
              #!/bin/bash
              sudo apt-get update
              sudo apt-get install -y docker.io
              sudo systemctl start docker
              sudo systemctl enable docker
              sudo docker run -d -p 80:80 your-dockerhub-username/mynodeapp
              EOF

  tags = {
    Name = "example-instance"
  }
}
```

## Running the Infrastructure

1. **Run the Terraform commands to provision the infrastructure:**
```bash
terraform init
terraform plan
terraform apply
```

2. **Verify that the EC2 instance is running and Docker is installed:**
   - SSH into the EC2 instance.
   - Run `docker ps` to see if the application container is running.

## Dependencies

- Terraform
- AWS CLI

## Maintenance and Extension Instructions

### Maintenance 
- Regularly update the AMI ID in the Terraform configuration to the latest stable version.
- Update the Docker image in the userdata script as necessary.


