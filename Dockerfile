# Stage 1: Build the application
FROM node:22-alpine AS build

WORKDIR /app

COPY package.json package-lock.json* ./

RUN npm ci

COPY . .

RUN npm run build

# ---

# Stage 2: Serve the application
# Use a lightweight server like Nginx or a smaller Node.js image if you need it.
# This example uses a very small Node.js image to serve the app.
FROM node:22-alpine AS final

WORKDIR /app

# Copy the built files from the 'build' stage
COPY --from=build /app/dist ./dist

# In this example, we assume your build creates files in a 'dist' directory.
# 'npm run preview' needs Node.js, so we keep using a Node.js image.
EXPOSE 4173

CMD ["npm", "run", "preview"]
