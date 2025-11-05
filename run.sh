#!/bin/bash

# Run script for Smart Health Monitor Container
# Demonstrates container lifecycle operations using Podman

set -e

echo "=========================================="
echo "Smart Health Monitor - Container Run"
echo "=========================================="
echo ""

# Configuration
IMAGE_NAME="smart-health-monitor"
IMAGE_TAG="v1.0"
CONTAINER_NAME="health-monitor-app"
HOST_PORT="5000"
CONTAINER_PORT="5000"
VOLUME_NAME="health-data"

# Check if container is already running
if podman ps -a --format "{{.Names}}" | grep -q "^${CONTAINER_NAME}$"; then
    echo "⚠️  Container '${CONTAINER_NAME}' already exists."
    echo "Stopping and removing existing container..."
    podman stop ${CONTAINER_NAME} 2>/dev/null || true
    podman rm ${CONTAINER_NAME} 2>/dev/null || true
    echo ""
fi

# Create volume for persistent data storage if it doesn't exist
if ! podman volume ls --format "{{.Name}}" | grep -q "^${VOLUME_NAME}$"; then
    echo "Creating persistent volume: ${VOLUME_NAME}"
    podman volume create ${VOLUME_NAME}
    echo "✅ Volume created"
else
    echo "✅ Using existing volume: ${VOLUME_NAME}"
fi

echo ""
echo "Starting container..."
echo "  - Image: ${IMAGE_NAME}:${IMAGE_TAG}"
echo "  - Container Name: ${CONTAINER_NAME}"
echo "  - Port Mapping: ${HOST_PORT}:${CONTAINER_PORT}"
echo "  - Volume: ${VOLUME_NAME} -> /data"
echo ""

# Run the container with volume mount
podman run -d \
    --name ${CONTAINER_NAME} \
    -p ${HOST_PORT}:${CONTAINER_PORT} \
    -v ${VOLUME_NAME}:/data \
    ${IMAGE_NAME}:${IMAGE_TAG}

echo "✅ Container started successfully!"
echo ""

# Wait a moment for the container to start
sleep 2

# Display container status
echo "Container Status:"
podman ps --filter "name=${CONTAINER_NAME}"

echo ""
echo "=========================================="
echo "🎉 Application is running!"
echo "=========================================="
echo ""
echo "Access the application at: http://localhost:${HOST_PORT}"
echo ""
echo "Useful commands:"
echo "  - View logs:        podman logs ${CONTAINER_NAME}"
echo "  - Follow logs:      podman logs -f ${CONTAINER_NAME}"
echo "  - Stop container:   podman stop ${CONTAINER_NAME}"
echo "  - Inspect:          podman inspect ${CONTAINER_NAME}"
echo "  - Container stats:  podman stats ${CONTAINER_NAME}"
echo ""
echo "To stop the application, run: ./stop.sh"
echo "=========================================="

