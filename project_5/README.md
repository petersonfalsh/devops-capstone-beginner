

### Project 1: Containerizing Applications with Docker

#### Objective
Learn how to create, manage, and deploy Docker containers for consistent and efficient application environments.

#### Detailed Description

**Step 1: Install Docker on your local machine or server.**

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

**Step 2: Write Dockerfiles to containerize a simple web application and its dependencies.**

**Example: Simple Node.js Application**

1. **Create a directory for your application:**
```bash
mkdir mynodeapp
cd mynodeapp
```

2. **Create a simple Node.js application:**

**app.js:**
```javascript
const http = require('http');
const port = 3000;

const requestHandler = (request, response) => {
  response.end('Hello, World!');
};

const server = http.createServer(requestHandler);

server.listen(port, (err) => {
  if (err) {
    return console.log('something bad happened', err);
  }

  console.log(`server is listening on ${port}`);
});
```

**package.json:**
```json
{
  "name": "mynodeapp",
  "version": "1.0.0",
  "description": "A simple Node.js app",
  "main": "app.js",
  "scripts": {
    "start": "node app.js"
  },
  "dependencies": {
    "http": "^0.0.0"
  }
}
```

3. **Create a Dockerfile:**

**Dockerfile:**
```Dockerfile
# Use an official Node.js runtime as a parent image
FROM node:14

# Set the working directory
WORKDIR /usr/src/app

# Copy the package.json and package-lock.json files
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application code
COPY . .

# Expose the port the app runs on
EXPOSE 3000

# Run the application
CMD ["npm", "start"]
```

**Step 3: Build Docker images from the Dockerfiles.**

```bash
docker build -t mynodeapp .
```

**Step 4: Push the Docker images to a container registry (e.g., Docker Hub).**

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

### Create a README.md File

**README.md:**

```markdown
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
const http = require('http');
const port = 3000;

const requestHandler = (request, response) => {
  response.end('Hello, World!');
};

const server = http.createServer(requestHandler);

server.listen(port, (err) => {
  if (err) {
    return console.log('something bad happened', err);
  }

  console.log(`server is listening on ${port}`);
});
```

**package.json:**
```json
{
  "name": "mynodeapp",
  "version": "1.0.0",
  "description": "A simple Node.js app",
  "main": "app.js",
  "scripts": {
    "start": "node app.js"
  },
  "dependencies": {
    "http": "^0.0.0"
  }
}
```

3. **Create a Dockerfile:**

**Dockerfile:**
```Dockerfile
# Use an official Node.js runtime as a parent image
FROM node:14

# Set the working directory
WORKDIR /usr/src/app

# Copy the package.json and package-lock.json files
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application code
COPY . .

# Expose the port the app runs on
EXPOSE 3000

# Run the application
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
You should see "Hello, World!" displayed.

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
- Integrate with a CI/CD pipeline for automated builds and deployments.

## Diagrams and Screenshots

### Diagram
![Docker Architecture](path/to/diagram.png)

### Screenshots
**Building Docker Image:**
![Building Image](path/to/screenshot1.png)

**Running Docker Container:**
![Running Container](path/to/screenshot2.png)
```




### Project 2: Infrastructure as Code with Terraform

#### Objective
Manage infrastructure using Terraform to achieve consistent and reproducible environments. The goal is to develop an EC2 instance with a default VPC using Terraform and deploy the infrastructure using GitHub Actions.

#### Detailed Description

**Step 1: Install Terraform on your local machine**

**For Ubuntu:**
```bash
sudo apt-get update && sudo apt-get install -y gnupg software-properties-common curl
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
sudo apt-get update && sudo apt-get install terraform
```

**Step 2: Create Terraform configuration files to define infrastructure resources (e.g., EC2 instances) on a cloud provider like AWS**

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

**Step 3: Use Terraform commands (init, plan, apply) to provision the defined infrastructure**

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

**Step 4: Write a userdata/shell Script that will automatically install Docker once the application is provisioned. So every server that is spun up automatically has Docker installed. It should also pull and Run the Image created in Step 1 in the script**

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

### Create a README.md File

**README.md:**

```markdown
# Project 2: Infrastructure as Code with Terraform

## Overview
This project demonstrates how to manage infrastructure using Terraform to achieve consistent and reproducible environments. We will develop an EC2 instance with a default VPC using Terraform and deploy the infrastructure using GitHub Actions.

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

### Extension
- Add more resources to the Terraform configuration, such as security groups or additional instances.
- Integrate with a CI/CD pipeline for automated Terraform deployments.

## Diagrams and Screenshots

### Diagram
![Terraform Architecture](path/to/diagram.png)

### Screenshots
**Terraform Plan:**
![Terraform Plan](path/to/screenshot1.png)

**EC2 Instance Running:**
![EC2 Instance](path/to/screenshot2.png)
```



### Project 3: Automated Deployment Pipeline with GitHub Actions

#### Objective
Set up a comprehensive CI/CD pipeline using GitHub Actions to automate our infrastructure deployment to AWS.

#### Detailed Description

**Step 1: Create a repository on GitHub for your project**

1. Go to GitHub and create a new repository (e.g., `terraform-deployment`).

**Step 2: Create a GitHub Actions workflow file on the Terraform Code (`.github/workflows/terraform-pipeline.yml`)**

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

**Step 3: Configure the workflow to trigger events such as pushes and pull requests**

- The workflow is set to trigger on `push` and `pull_request` events on the `main` branch, as specified in the `on` section of the YAML file.

**Step 4: Add steps to the workflow to check the code, set up the required environment, and install dependencies**

- These steps are included in the YAML file under the `steps` section, where we check out the code, set up Terraform, and initialize it.

**Step 5: Add build steps to package the Infrastructure**

- The build steps, including `terraform init`, `terraform plan`, and `terraform apply`, are added to the workflow file.

**Step 6: Add build parameters to automate whether the code will apply or destroy**

- The `terraform apply` step only runs when the event is a push to the `main` branch, ensuring automated deployment.

**Step 7: Validate the workflow by pushing code changes and observing the automated pipeline execution**

- Commit and push your changes to the `main` branch. You can observe the workflow execution in the Actions tab of your GitHub repository.

### Create a README.md File

**README.md:**

```markdown
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
- Add more steps to the workflow, such as running tests or sending notifications.
- Integrate with other CI/CD tools and services for enhanced functionality.

## Diagrams and Screenshots

### Diagram
![CI/CD Pipeline](path/to/diagram.png)

### Screenshots
**GitHub Actions Workflow:**
![GitHub Actions](path/to/screenshot1.png)

**Terraform Apply:**
![Terraform Apply](path/to/screenshot2.png)
```


### Project 4: Ansible Task to Deploy Nginx

#### Objective
This Ansible task aims to introduce beginners to the basics of Ansible by deploying the Nginx web server to another Ubuntu server.

#### Detailed Description

**Step 1: Set up an Inventory File**

1. Create an inventory file (`hosts.ini`) to define the target server(s):
   ```ini
   [webservers]
   server1 ansible_host=your_server_ip
   server2 ansible_host=your_other_server_ip
   ```

**Step 2: Write an Ansible Playbook**

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

**Step 3: Run the Playbook**

1. Execute the playbook using the following command:
   ```bash
   ansible-playbook -i hosts.ini nginx-playbook.yml
   ```

### Create a README.md File

**README.md:**

```markdown
# Project 4: Ansible Task to Deploy Nginx

## Overview
This project introduces the basics of Ansible by deploying the Nginx web server to an Ubuntu server.

## Prerequisites
- Ansible installed on the control node
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

## Diagrams and Screenshots

### Diagram

![Ansible Deployment Diagram](path/to/diagram.png)

### Screenshots

**Playbook Execution:**

![Playbook Execution](path/to/screenshot1.png)

**Nginx Welcome Page:**

![Nginx Welcome Page](path/to/screenshot2.png)
```

Would you like to proceed with any specific step or need further adjustments?



