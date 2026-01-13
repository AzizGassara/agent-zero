# Use a standard Python runtime
FROM python:3.12-slim

# Set the working directory in the container
WORKDIR /app

# Install nginx
RUN apt-get update && apt-get install -y nginx

# Copy the application code to the container
COPY . .

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy the nginx configuration and startup script
COPY nginx.conf /etc/nginx/nginx.conf
COPY start.sh /app/start.sh

# Make the startup script executable
RUN chmod +x /app/start.sh

# Expose the port nginx will listen on
EXPOSE 7860

# Set the entrypoint to the startup script
CMD ["/app/start.sh"]
