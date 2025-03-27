# Step 1: Build the React app
FROM node:14 AS build

# Set the working directory
WORKDIR /app

# Copy package.json and install dependencies
COPY package.json ./
COPY package-lock.json ./
RUN npm install

# Copy the rest of the app's files
COPY . ./

# Build the app
RUN npm run build

# Step 2: Serve the app using nginx
FROM nginx:alpine

# Copy the built React app to nginx's html directory
COPY --from=build /app/build /usr/share/nginx/html

# Expose the port for the app
EXPOSE 80

# Start nginx to serve the app
CMD ["nginx", "-g", "daemon off;"]
