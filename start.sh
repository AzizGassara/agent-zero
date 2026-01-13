#!/bin/bash

# Start nginx in the background
nginx -g 'daemon off;' &

# Set environment variables for the application
export OPERATING_MODE=local
export ALLOWED_ORIGINS=*
export FLASK_SECRET_KEY=$(openssl rand -hex 32)

# Run the Python application
python run_ui.py --host 127.0.0.1 --port 5000
