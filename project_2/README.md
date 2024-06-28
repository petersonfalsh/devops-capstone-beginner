### Project 2: Infrastructure as Code with Terraform

## README.md

```markdown
# Project 2: Infrastructure as Code with Terraform

## Overview
This project demonstrates how to manage infrastructure using Terraform to achieve consistent and reproducible environments. The goal is to develop an EC2 instance with a default VPC using Terraform and deploy the infrastructure using GitHub Actions.

## Prerequisites
- Terraform installed on your local machine
- AWS account and IAM user with appropriate permissions
- GitHub account

## Setup Instructions

### Step 1: Install Terraform

**On Ubuntu:**
```bash
sudo apt-get update
sudo apt-get install -y gnupg software-properties-common curl
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
sudo apt-get update
sudo apt-get install terraform
```

**On macOS:**
```bash
brew tap hashicorp/tap
brew install hashicorp/tap/terraform
```

**On Windows:**
- Download the appropriate package from the [Terraform website](https://www.terraform.io/downloads.html) and follow the installation instructions.

### Step 2: Create Terraform Configuration Files

1. Create a directory for your project and navigate into it:
   ```bash
   mkdir my-terraform-project
   cd my-terraform-project
   ```

2. Create a `main.tf` file to define your infrastructure resources:
   ```hcl
   provider "aws" {
     region = "us-west-2"
   }

   resource "aws_instance" "example" {
     ami           = "ami-0c55b159cbfafe1f0"
     instance_type = "t2.micro"

     tags = {
       Name = "TerraformExample"
     }

     user_data = <<-EOF
                 #!/bin/bash
                 sudo apt-get update
                 sudo apt-get install -y docker.io
                 sudo systemctl start docker
                 sudo systemctl enable docker
                 docker run -d -p 80:80 nginx
                 EOF
   }
   ```

3. Initialize Terraform:
   ```bash
   terraform init
   ```

4. Create a Terraform execution plan:
   ```bash
   terraform plan
   ```

5. Apply the Terraform configuration:
   ```bash
   terraform apply
   ```

### Step 3: Deploy Infrastructure using GitHub Actions

1. Create a new repository on GitHub for your project.

2. Add your Terraform configuration files to the repository.

3. Create a GitHub Actions workflow file in `.github/workflows/terraform-pipeline.yml`:
   ```yaml
   name: 'Terraform CI/CD'

   on:
     push:
       branches:
         - main

   jobs:
     terraform:
       runs-on: ubuntu-latest

       steps:
         - name: Checkout code
           uses: actions/checkout@v2

         - name: Setup Terraform
           uses: hashicorp/setup-terraform@v1
           with:
             terraform_version: 1.0.5

         - name: Terraform Init
           run: terraform init

         - name: Terraform Plan
           run: terraform plan

         - name: Terraform Apply
           run: terraform apply -auto-approve
   ```

4. Commit and push your changes to GitHub.

### Step 4: Verify the Infrastructure Deployment

1. Check the GitHub Actions workflow runs in your repository to ensure the Terraform apply step completed successfully.

2. Log in to your AWS Management Console and navigate to the EC2 Dashboard.

3. Verify that a new EC2 instance with the specified configuration is running.

## Dependencies

- Terraform
- AWS CLI (optional for local testing)
- GitHub Actions

### Installation Instructions for Dependencies

**AWS CLI:**

**On Ubuntu:**
```bash
sudo apt-get update
sudo apt-get install awscli -y
```

**On macOS:**
```bash
brew install awscli
```

**On Windows:**
- Download and install the AWS CLI from the [official website](https://aws.amazon.com/cli/).

## Maintenance and Extension Instructions

### Maintenance

- Regularly update Terraform to the latest version.
- Monitor the deployed infrastructure for performance and security.

### Extension

- Add more Terraform configuration files to manage additional resources like S3, RDS, etc.
- Integrate with other CI/CD tools and workflows.

## Diagrams and Screenshots

### Diagram

![Terraform Infrastructure Workflow](path/to/diagram.png)

### Screenshots

**Terraform Apply:**

![Terraform Apply](path/to/screenshot1.png)

**EC2 Instance in AWS Console:**

![EC2 Instance](path/to/screenshot2.png)
```

Would you like to proceed with the next project?