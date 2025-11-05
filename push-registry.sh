#!/bin/bash

# Registry push script for Smart Health Monitor
# Demonstrates container registry operations (push to Quay.io or Docker Hub)

set -e

echo "=========================================="
echo "Smart Health Monitor - Push to Registry"
echo "=========================================="
echo ""

IMAGE_NAME="smart-health-monitor"
IMAGE_TAG="v1.0"
LOCAL_IMAGE="${IMAGE_NAME}:${IMAGE_TAG}"

echo "Select registry:"
echo "1) Quay.io"
echo "2) Docker Hub"
echo "3) Custom registry"
read -p "Enter choice (1-3): " choice

case $choice in
    1)
        read -p "Enter your Quay.io username: " username
        REGISTRY="quay.io"
        REMOTE_IMAGE="${REGISTRY}/${username}/${IMAGE_NAME}:${IMAGE_TAG}"
        ;;
    2)
        read -p "Enter your Docker Hub username: " username
        REGISTRY="docker.io"
        REMOTE_IMAGE="${username}/${IMAGE_NAME}:${IMAGE_TAG}"
        ;;
    3)
        read -p "Enter registry URL (e.g., registry.example.com): " REGISTRY
        read -p "Enter username/namespace: " username
        REMOTE_IMAGE="${REGISTRY}/${username}/${IMAGE_NAME}:${IMAGE_TAG}"
        ;;
    *)
        echo "Invalid choice"
        exit 1
        ;;
esac

echo ""
echo "Logging in to ${REGISTRY}..."
podman login ${REGISTRY}

echo ""
echo "Tagging image..."
podman tag ${LOCAL_IMAGE} ${REMOTE_IMAGE}

echo ""
echo "Pushing image to registry..."
podman push ${REMOTE_IMAGE}

echo ""
echo "✅ Image pushed successfully!"
echo ""
echo "Image location: ${REMOTE_IMAGE}"
echo ""
echo "To pull this image on another system:"
echo "  podman pull ${REMOTE_IMAGE}"
echo ""
echo "=========================================="

