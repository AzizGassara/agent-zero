#!/bin/bash

# Start Nginx in the background
nginx -g "daemon off;" &

# Start the Agent Zero UI
# We use the --host argument to ensure it binds to localhost,
# so it's only accessible through the Nginx reverse proxy.
python run_ui.py --host 127.0.0.1 --port 5000
