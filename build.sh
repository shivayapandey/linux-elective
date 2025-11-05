#!/bin/bash

# Build script for Smart Health Monitor Container
# Demonstrates container image creation using Podman

set -e

echo "=========================================="
echo "Smart Health Monitor - Container Build"
echo "=========================================="
echo ""

# Configuration
IMAGE_NAME="smart-health-monitor"
IMAGE_TAG="v1.0"
FULL_IMAGE_NAME="${IMAGE_NAME}:${IMAGE_TAG}"

echo "Building container image: ${FULL_IMAGE_NAME}"
echo ""

# Build the container image using Podman
podman build -t ${FULL_IMAGE_NAME} -f Containerfile .

echo ""
echo "✅ Container image built successfully!"
echo ""

# Display image information
echo "Image Details:"
podman images ${IMAGE_NAME}

echo ""
echo "To run the container, execute: ./run.sh"
echo "=========================================="

