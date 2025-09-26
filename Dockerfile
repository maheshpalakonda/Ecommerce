# Use official Node.js image
FROM node:18

# Set working directory
WORKDIR /usr/src/app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the app
COPY . .

# Expose application port (change if your app uses different one)
EXPOSE 3000

# Start the app
CMD ["node", "server.js"]

