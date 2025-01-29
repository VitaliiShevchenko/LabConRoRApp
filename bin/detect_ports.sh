#!/bin/bash

echo "Script is running..."

# Find the first available /dev/ttyACM* port
PORT=$(ls /dev/ttyACM* 2>/dev/null | head -n 1)

# Check if a port was found
if [ -z "$PORT" ]; then
  echo "No available /dev/ttyACM* port found."
  exit 1
else
  echo "Detected port: $PORT"
  # Export the port as an environment variable
  echo "export SERIAL_PORT=$PORT" > ~/.serial_port_env
  exit 0
fi
