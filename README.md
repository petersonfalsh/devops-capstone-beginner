

# This is a documentation of my capstone project as a beginner in DevOps courtesy of Kodehauz.


# Project 1: Containerizing Applications with Docker

## Overview
This project demonstrates how to create, manage, and deploy Docker containers for consistent and efficient application environments. The example application is a simple Node.js web server.

## Prerequisites
- Docker installed on your local machine or server
- Node.js installed on your local machine for development

## Setup Instructions

### Step 1: Install Docker

**For Ubuntu:**
```bash
sudo apt update
sudo apt install apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt update
sudo apt install docker-ce
sudo systemctl status docker
```

### Step 2: Write Dockerfiles

1. **Create a directory for your application:**
```bash
mkdir mynodeapp
cd mynodeapp
```

2. **Create a simple Node.js application:**

**app.js:**
```javascript

const express = require("express");
const app = express();
const port = 3000;

app.get("/", (req, res) => {
    res.send('Hello, world... This is my simple web application for  my capstone project!')
})

app.listen(port, () => {
    console.log("Listening for request at port " + port)
})


```

**package.json:**
```json
{
  "name": "mynodeapp",
  "version": "1.0.0",
  "description": "",
  "main": "app.js",
  "scripts": {
    "test": "echo \"Error: no test specified\" && exit 1",
    "start": "node app.js"
  },
  "keywords": [],
  "author": "",
  "license": "ISC",
  "dependencies": {
    "express": "^4.19.2"
  }
}
```

3. **Create a Dockerfile:**

**Dockerfile:**
```Dockerfile
## Use the nodejs environment but with alpine to make it light-weight
FROM node:alpine

# Create and set the working directory in the container that will be created
# and change to the working directory.  you can use just /app but /usr/src/app
# because it's a common convention from the Linux/unix days as where code s served from.
# NOTE - when you use the WORKDIR directory, you have switched o the directory.
WORKDIR /usr/src/app

# copy the package.json and package-lock.json file in my local machine to the current working
# directory which is /usr/src/app
COPY package*.json ./

# Install the dependencies in the current working directory in the container
RUN npm install

#  copy the rest of the application code from my local machine to the container's CWD
COPY . .

# Expose the application port
EXPOSE 3000

#Specify the command to run the application
CMD ["npm", "start"]
```

### Step 3: Build Docker images from the Dockerfiles

```bash
docker build -t mynodeapp .
```

### Step 4: Push the Docker images to a container registry

1. **Log in to Docker Hub:**
```bash
docker login
```

2. **Tag the Docker image:**
```bash
docker tag mynodeapp your-dockerhub-username/mynodeapp
```

3. **Push the Docker image:**
```bash
docker push your-dockerhub-username/mynodeapp
```

## Running the Application

1. **Run the Docker container:**
```bash
docker run -p 3000:3000 your-dockerhub-username/mynodeapp
```

2. **Open your browser and navigate to:**
```
http://localhost:3000
```
You should see "Hello, world... This is my simple web application for my capstone project!" displayed.

## Dependencies

- Docker
- Node.js

## Maintenance and Extension Instructions

### Maintenance
- Regularly update the Node.js version in the Dockerfile to the latest stable version.
- Update the dependencies in `package.json` periodically.

### Extension
- Add more functionality to the Node.js application.
- Use a multi-stage Docker build for optimized image sizes.
- Integrate with a CI/CD pipeline for automated builds and deployments when you learn about it.




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





# Project 3: Automated Deployment Pipeline with GitHub Actions

## Overview
This project sets up a comprehensive CI/CD pipeline using GitHub Actions to automate our infrastructure deployment to AWS.

## Prerequisites
- A GitHub account
- AWS account with access keys
- Terraform configuration files for the infrastructure

## Setup Instructions

### Step 1: Create a GitHub Repository

1. Go to GitHub and create a new repository (e.g., `terraform-deployment`).

### Step 2: Create a GitHub Actions Workflow File

1. In your local project directory, create the necessary folders and workflow file:
```bash
mkdir -p .github/workflows
touch .github/workflows/terraform-pipeline.yml
```

2. Populate the `terraform-pipeline.yml` file with the following content:

```yaml
name: Terraform Deployment

on:
  push:
    branches:
      - main
  pull_request:
    branches:
      - main

jobs:
  terraform:
    name: 'Terraform'
    runs-on: ubuntu-latest

    env:
      TF_VERSION: '1.0.0'
      TF_WORKING_DIR: './'
      AWS_ACCESS_KEY_ID: ${{ secrets.AWS_ACCESS_KEY_ID }}
      AWS_SECRET_ACCESS_KEY: ${{ secrets.AWS_SECRET_ACCESS_KEY }}

    steps:
    - name: 'Checkout GitHub Action'
      uses: actions/checkout@v2

    - name: 'Setup Terraform'
      uses: hashicorp/setup-terraform@v1
      with:
        terraform_version: ${{ env.TF_VERSION }}

    - name: 'Terraform Init'
      run: terraform init
      working-directory: ${{ env.TF_WORKING_DIR }}

    - name: 'Terraform Plan'
      run: terraform plan -out=tfplan
      working-directory: ${{ env.TF_WORKING_DIR }}

    - name: 'Terraform Apply'
      if: github.ref == 'refs/heads/main'
      run: terraform apply -input=false tfplan
      working-directory: ${{ env.TF_WORKING_DIR }}
```

### Step 3: Configure the Workflow

- The workflow triggers on `push` and `pull_request` events on the `main` branch.

### Step 4: Add Steps to the Workflow

- Steps include checking out the code, setting up Terraform, and initializing it.

### Step 5: Add Build Steps

- The build steps include `terraform init`, `terraform plan`, and `terraform apply`.

### Step 6: Add Build Parameters

- The `terraform apply` step runs only when the event is a push to the `main` branch.

### Step 7: Validate the Workflow

- Commit and push your changes to the `main` branch.
- Observe the workflow execution in the Actions tab of your GitHub repository.

## Dependencies

- Terraform
- AWS CLI

## Maintenance and Extension Instructions

### Maintenance
- Regularly update the Terraform version in the workflow file.
- Update the AWS access keys in the GitHub repository secrets as needed.

### Extension
- Add more steps to the workflow, such as running tests or sending notifications as your project later demands.
- Integrate with other CI/CD tools and services for enhanced functionality.




# Project 4: Ansible Task to Deploy Nginx

## Overview
This project introduces the basics of Ansible by deploying the Nginx web server to an Ubuntu server.

## Prerequisites
- Ansible installed on the control node (usually your laptop)
- Ubuntu server(s) to act as target nodes
- SSH access to the target nodes

## Setup Instructions

### Step 1: Set Up an Inventory File

1. Create an inventory file (`hosts.ini`) to define the target server(s):

   ```ini
   [webservers]
   server1 ansible_host=your_server_ip
   server2 ansible_host=your_other_server_ip
   ```

### Step 2: Write an Ansible Playbook

1. Create an Ansible playbook file (`nginx-playbook.yml`) with the following content:

   ```yaml
   ---
   - name: Deploy Nginx web server
     hosts: webservers
     become: yes
     tasks:
       - name: Update apt cache
         apt:
           update_cache: yes

       - name: Install Nginx
         apt:
           name: nginx
           state: present

       - name: Ensure Nginx is running
         service:
           name: nginx
           state: started
           enabled: yes
   ```

### Step 3: Run the Playbook

1. Execute the playbook using the following command:

   ```bash
   ansible-playbook -i hosts.ini nginx-playbook.yml
   ```

### Verification

1. Verify that Nginx is installed and running by visiting the IP address of your server in a web browser (e.g., `http://your_server_ip`).

## Dependencies

- Ansible
- Ubuntu server(s) for deployment

### Installation Instructions for Dependencies

**Install Ansible on Control Node:**

```bash
sudo apt update
sudo apt install ansible 
```

**Set Up SSH Access to Target Nodes:**

1. Generate SSH keys on the control node:
   ```bash
   ssh-keygen
   ```

2. Copy the public key to each target node:
   ```bash
   ssh-copy-id user@your_server_ip
   ```

## Maintenance and Extension Instructions

### Maintenance

- Regularly update Ansible and the target servers.
- Monitor the status of the Nginx service and ensure it is running.

### Extension

- Add more tasks to the playbook, such as configuring Nginx with custom settings.
- Use roles and templates to organize the playbook for more complex deployments.







