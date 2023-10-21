# Stage 1: Build the application
FROM node:16-alpine AS builder
WORKDIR /app
COPY . .
RUN yarn install

# Stage 2: Create a smaller image
FROM node:16-alpine
WORKDIR /app
COPY --from=builder /app /app
EXPOSE 3000
CMD ["yarn", "start"]
