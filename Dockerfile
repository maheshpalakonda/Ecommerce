# ---------- Stage 1: Build ----------
FROM node:18-alpine AS builder

# Set working directory
WORKDIR /usr/src/app

# Copy only package files first (better caching)
COPY package*.json ./

# Install only production dependencies
RUN npm ci --omit=dev

# Copy the rest of the application
COPY . .

# ---------- Stage 2: Runtime ----------
FROM node:18-alpine

# Set working directory
WORKDIR /usr/src/app

# Copy only needed files from builder
COPY --from=builder /usr/src/app ./

# Expose application port
EXPOSE 3000

# Start the app
CMD ["node", "server.js"]
