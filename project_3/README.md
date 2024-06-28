### Project 3: Automated Deployment Pipeline with GitHub Actions

## README.md

```markdown
# Project 3: Automated Deployment Pipeline with GitHub Actions

## Overview
This project involves setting up a comprehensive CI/CD pipeline using GitHub Actions to automate the deployment of infrastructure to AWS using Terraform. This ensures a consistent, reproducible, and automated deployment process.

## Prerequisites
- GitHub account
- AWS account and IAM user with appropriate permissions
- Terraform installed on your local machine
- A GitHub repository for your project

## Setup Instructions

### Step 1: Create a Repository on GitHub
1. Go to [GitHub](https://github.com/) and log in to your account.
2. Click on the "+" icon at the top right and select "New repository".
3. Enter a name for your repository, make it public or private, and click "Create repository".

### Step 2: Add Terraform Configuration Files

1. Clone your repository to your local machine:
   ```bash
   git clone https://github.com/your-username/your-repository.git
   cd your-repository
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

5. Apply the Terraform configuration locally (optional for testing):
   ```bash
   terraform apply
   ```

### Step 3: Create a GitHub Actions Workflow File

1. Create a directory for your GitHub Actions workflows:
   ```bash
   mkdir -p .github/workflows
   ```

2. Create a workflow file in `.github/workflows/terraform-pipeline.yml`:
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

3. Commit and push your changes to GitHub:
   ```bash
   git add .
   git commit -m "Add Terraform configuration and GitHub Actions workflow"
   git push origin main
   ```

### Step 4: Configure GitHub Secrets

1. Go to your repository on GitHub.
2. Click on "Settings" > "Secrets" > "Actions" > "New repository secret".
3. Add the following secrets:
   - `AWS_ACCESS_KEY_ID`
   - `AWS_SECRET_ACCESS_KEY`

### Step 5: Verify the Automated Pipeline

1. Make a change to your repository (e.g., update `main.tf`) and push the changes.
2. Go to the "Actions" tab in your GitHub repository.
3. Observe the workflow execution and verify that the infrastructure is deployed successfully.

## Dependencies

- Terraform
- AWS CLI (optional for local testing)
- GitHub Actions

### Installation Instructions for Dependencies

**Terraform:**

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

- Regularly update Terraform and GitHub Actions to the latest versions.
- Monitor the deployed infrastructure for performance and security.

### Extension

- Add more Terraform configuration files to manage additional resources like S3, RDS, etc.
- Integrate with other CI/CD tools and workflows.
- Enhance the GitHub Actions workflow with additional checks and notifications.

## Diagrams and Screenshots

### Diagram

![GitHub Actions Workflow](path/to/diagram.png)

### Screenshots

**GitHub Actions Workflow:**

![GitHub Actions Workflow](path/to/screenshot1.png)

**EC2 Instance in AWS Console:**

![EC2 Instance](path/to/screenshot2.png)
```

Would you like to proceed with the next project?

