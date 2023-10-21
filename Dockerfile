# Stage 1: Build the React application
FROM node:16-alpine AS builder

# Set the working directory
WORKDIR /app

# Copy package.json and package-lock.json to the container
COPY package.json package-lock.json ./

# Install dependencies
RUN npm install

# Copy the application code to the container
COPY . .

# Build the production-ready code
RUN npm run build

# Stage 2: Create a lightweight image to serve the application
FROM nginx:alpine

# Copy the build artifacts from the builder stage to the Nginx web server directory
COPY --from=builder /app/build /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]
