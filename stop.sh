#!/bin/bash

# Stop script for Smart Health Monitor Container
# Demonstrates container lifecycle management

set -e

echo "=========================================="
echo "Smart Health Monitor - Stop Container"
echo "=========================================="
echo ""

CONTAINER_NAME="health-monitor-app"

# Check if container exists
if podman ps -a --format "{{.Names}}" | grep -q "^${CONTAINER_NAME}$"; then
    echo "Stopping container: ${CONTAINER_NAME}"
    podman stop ${CONTAINER_NAME}
    
    echo "Removing container: ${CONTAINER_NAME}"
    podman rm ${CONTAINER_NAME}
    
    echo ""
    echo "✅ Container stopped and removed successfully!"
    echo ""
    echo "Note: Your data is preserved in the 'health-data' volume"
    echo "To start again, run: ./run.sh"
else
    echo "⚠️  Container '${CONTAINER_NAME}' is not running"
fi

echo "=========================================="

