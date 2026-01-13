# Stage 1: Build the application
FROM python:3.12-slim as builder

# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    nginx \
    && rm -rf /var/lib/apt/lists/*

# Set the working directory
WORKDIR /app

# Copy requirements and install Python dependencies
COPY requirements.txt requirements2.txt ./
RUN pip install --no-cache-dir -r requirements.txt
RUN pip install --no-cache-dir -r requirements2.txt

# Copy the rest of the application code
COPY . .

# Stage 2: Final image
FROM python:3.12-slim

# Install Nginx
RUN apt-get update && apt-get install -y --no-install-recommends \
    nginx \
    && rm -rf /var/lib/apt/lists/*

# Copy the application from the builder stage
WORKDIR /app
COPY --from=builder /app .

# Copy Nginx configuration and startup script
COPY nginx.conf /etc/nginx/nginx.conf
COPY start.sh /start.sh
RUN chmod +x /start.sh

# Set environment variables for Hugging Face Spaces
ENV OPERATING_MODE=local
ENV ALLOWED_ORIGINS=*

# Expose the port Nginx will listen on
EXPOSE 7860

# Set the command to run the startup script
CMD ["/start.sh"]
