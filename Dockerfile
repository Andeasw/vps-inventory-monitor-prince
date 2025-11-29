# Base Image
FROM node:20-alpine

# Metadata
LABEL maintainer="Prince"
LABEL version="0.0.1"
LABEL description="Template Resource Monitor Service"

# Timezone Configuration (Force Asia/Shanghai)
RUN apk add --no-cache tzdata \
    && cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo "Asia/Shanghai" > /etc/timezone \
    && apk del tzdata

# Setup Directory
WORKDIR /app

# Install Dependencies
COPY package.json ./
RUN npm install --production --no-audit

# Copy Application Code
COPY index.js ./

# Create Storage Directories
RUN mkdir -p logs data

# Expose Health Check Port
EXPOSE 2996

# Start Command
CMD ["npm", "start"]
