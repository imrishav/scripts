#!/bin/bash

# Check if a port number is provided as a command-line argument
if [ -z "$1" ]; then
  echo "Usage: $0 <port>"
  exit 1
fi

# Extract the port from the command-line argument
PORT=$1

# Find the process using the specified port
PID=$(lsof -t -i :$PORT)

if [ -z "$PID" ]; then
  echo "No process found on port $PORT."
else
  # Kill the process
  echo "Killing process with PID: $PID"
  kill $PID

  # Optionally: Wait for the process to be killed
  sleep 2

  # Check if the process is still running
  if ps -p $PID > /dev/null; then
    echo "Failed to kill the process with PID: $PID"
  else
    echo "Process killed successfully."
  fi
fi
