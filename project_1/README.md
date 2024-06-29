


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

