

### Project 1: Containerizing Applications with Docker

## README.md

```markdown
# Project 1: Containerizing Applications with Docker

## Overview
This project involves creating, managing, and deploying Docker containers for a Node.js web application. The goal is to ensure consistent and efficient application environments using Docker.

## Prerequisites
- Docker installed on your local machine
- Basic knowledge of Docker and Node.js

## Setup Instructions

### Step 1: Install Docker
**On Ubuntu:**
```bash
sudo apt update
sudo apt install docker.io -y
sudo systemctl start docker
sudo systemctl enable docker
```

**On macOS:**
- Download and install Docker Desktop from [Docker's official website](https://www.docker.com/products/docker-desktop).

**On Windows:**
- Download and install Docker Desktop from [Docker's official website](https://www.docker.com/products/docker-desktop).

### Step 2: Create a Dockerfile
Create a file named `Dockerfile` with the following content:
```dockerfile
# Use the nodejs environment but with alpine to make it light-weight
FROM node:alpine

# Create and set the working directory in the container
WORKDIR /usr/src/app

# Copy the package.json and package-lock.json file from the local machine to the container
COPY package*.json ./

# Install the dependencies in the container
RUN npm install

# Copy the rest of the application code from the local machine to the container
COPY . .

# Expose the application port
EXPOSE 3000

# Specify the command to run the application
CMD ["npm", "start"]
```

### Step 3: Create the Node.js Application

#### package.json
Create a file named `package.json` with the following content:
```json
{
  "name": "my_node_app",
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

#### app.js
Create a file named `app.js` with the following content:
```javascript
const express = require("express");
const app = express();
const port = 3000;

app.get("/", (req, res) => {
    res.send('Hello, world... This is my simple web application for my capstone project!')
})

app.listen(port, () => {
    console.log("Listening for request at port " + port)
})
```

### Step 4: Build the Docker Image
Build the Docker image from the Dockerfile:
```bash
docker build -t my_node_app .
```

### Step 5: Run the Docker Container
Run the Docker container from the image you built:
```bash
docker run -p 3000:3000 my_node_app
```

### Step 6: Push the Docker Image to Docker Hub
1. Log in to Docker Hub:
    ```bash
    docker login
    ```

2. Tag the Docker image:
    ```bash
    docker tag my_node_app your_dockerhub_username/my_node_app
    ```

3. Push the Docker image to Docker Hub:
    ```bash
    docker push your_dockerhub_username/my_node_app
    ```

## Verifying the Deployment
1. After running the Docker container, open a web browser and navigate to `http://localhost:3000`.
2. You should see the message: "Hello, world... This is my simple web application for my capstone project!"

## Dependencies

- Docker
- Node.js
- Express (installed via `npm`)

### Installation Instructions for Dependencies

**Node.js and npm:**

**On Ubuntu:**
```bash
sudo apt update
sudo apt install nodejs npm -y
```

**On macOS:**
- Install Homebrew if you haven't already:
    ```bash
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    ```

- Then install Node.js:
    ```bash
    brew install node
    ```

**On Windows:**
- Download and install Node.js from [Node.js official website](https://nodejs.org/).

## Maintenance and Extension Instructions

### Maintenance

- Regularly update the Dockerfile and application dependencies.
- Monitor the container performance and logs.

### Extension

- Extend the application with more routes and features.
- Add environment variables for configuration.
- Implement Docker Compose for multi-container applications.

## Diagrams and Screenshots

### Diagram

![Docker Workflow](path/to/diagram.png)

### Screenshots

**Docker Build:**

![Docker Build](path/to/screenshot1.png)

**Application Running in Docker:**

![Application Running](path/to/screenshot2.png)
```

Would you like to proceed with any further actions or modifications?
