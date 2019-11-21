########################
# Build phase
########################
FROM node:alpine AS builder

WORKDIR /app

# Dependencies are included here
COPY package.json .
RUN npm install

# Copying the rest of the files
# Minimise build time
COPY . .

RUN npm run build

########################
# Run phase
########################
FROM nginx:alpine
COPY --from=builder /app/build /usr/share/nginx/html
