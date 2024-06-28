
# Use the nodejs environment but with alpine to make it light-weight
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