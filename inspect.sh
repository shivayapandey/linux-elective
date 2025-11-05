#!/bin/bash

# Inspection script for Smart Health Monitor Container
# Demonstrates container inspection and monitoring operations

echo "=========================================="
echo "Smart Health Monitor - Container Inspection"
echo "=========================================="
echo ""

CONTAINER_NAME="health-monitor-app"
IMAGE_NAME="smart-health-monitor"
VOLUME_NAME="health-data"

# Check if container is running
if podman ps --format "{{.Names}}" | grep -q "^${CONTAINER_NAME}$"; then
    echo "✅ Container is RUNNING"
    echo ""
    
    echo "📊 Container Details:"
    echo "-------------------"
    podman inspect ${CONTAINER_NAME} --format '
Container ID: {{.Id}}
Image: {{.Image}}
Created: {{.Created}}
Status: {{.State.Status}}
IP Address: {{.NetworkSettings.IPAddress}}
Ports: {{range .NetworkSettings.Ports}}{{.}}{{end}}'
    
    echo ""
    echo "📈 Resource Usage:"
    echo "-------------------"
    podman stats ${CONTAINER_NAME} --no-stream
    
    echo ""
    echo "📝 Recent Logs (last 20 lines):"
    echo "-------------------"
    podman logs --tail 20 ${CONTAINER_NAME}
    
    echo ""
    echo "🔍 Running Processes:"
    echo "-------------------"
    podman top ${CONTAINER_NAME}
    
elif podman ps -a --format "{{.Names}}" | grep -q "^${CONTAINER_NAME}$"; then
    echo "⚠️  Container exists but is NOT running"
    echo ""
    echo "Container Status:"
    podman ps -a --filter "name=${CONTAINER_NAME}"
else
    echo "❌ Container '${CONTAINER_NAME}' does not exist"
    echo ""
    echo "Available images:"
    podman images ${IMAGE_NAME}
fi

echo ""
echo "💾 Volume Information:"
echo "-------------------"
if podman volume ls --format "{{.Name}}" | grep -q "^${VOLUME_NAME}$"; then
    podman volume inspect ${VOLUME_NAME} --format '
Volume Name: {{.Name}}
Mount Point: {{.Mountpoint}}
Created: {{.CreatedAt}}'
else
    echo "Volume '${VOLUME_NAME}' does not exist"
fi

echo ""
echo "=========================================="
echo "Additional Commands:"
echo "  - Full inspect:     podman inspect ${CONTAINER_NAME}"
echo "  - Live logs:        podman logs -f ${CONTAINER_NAME}"
echo "  - Execute shell:    podman exec -it ${CONTAINER_NAME} /bin/bash"
echo "=========================================="

