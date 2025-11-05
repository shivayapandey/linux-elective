#!/bin/bash

# Demo script for Smart Health Monitor
# Use this for live demonstration during viva

set -e

echo "=========================================="
echo "🎬 Smart Health Monitor - Live Demo"
echo "=========================================="
echo ""
echo "This script will demonstrate all key features"
echo "of the containerized health monitoring system"
echo ""
read -p "Press Enter to start the demo..."

# Step 1: Show system info
echo ""
echo "📋 Step 1: System Information"
echo "----------------------------"
echo "Operating System:"
uname -a
echo ""
echo "Podman Version:"
podman --version
echo ""
read -p "Press Enter to continue..."

# Step 2: Build the image
echo ""
echo "🔨 Step 2: Building Container Image"
echo "----------------------------"
echo "Command: podman build -t smart-health-monitor:v1.0 -f Containerfile ."
echo ""
read -p "Press Enter to build..."
./build.sh
echo ""
read -p "Press Enter to continue..."

# Step 3: Show image details
echo ""
echo "🖼️  Step 3: Image Information"
echo "----------------------------"
echo "Listing container images:"
podman images smart-health-monitor
echo ""
echo "Detailed image inspection:"
podman inspect smart-health-monitor:v1.0 --format '
Image ID: {{.Id}}
Created: {{.Created}}
Size: {{.Size}} bytes
Labels: {{.Labels}}'
echo ""
read -p "Press Enter to continue..."

# Step 4: Create and inspect volume
echo ""
echo "💾 Step 4: Volume Management"
echo "----------------------------"
if ! podman volume ls --format "{{.Name}}" | grep -q "^health-data$"; then
    echo "Creating persistent volume..."
    podman volume create health-data
fi
echo "Volume details:"
podman volume inspect health-data
echo ""
read -p "Press Enter to continue..."

# Step 5: Run the container
echo ""
echo "🚀 Step 5: Running Container"
echo "----------------------------"
echo "Command: podman run -d --name health-monitor-app -p 5000:5000 -v health-data:/data smart-health-monitor:v1.0"
echo ""
read -p "Press Enter to run..."
./run.sh
echo ""
read -p "Press Enter to continue..."

# Step 6: Container inspection
echo ""
echo "🔍 Step 6: Container Inspection"
echo "----------------------------"
echo "Running containers:"
podman ps
echo ""
echo "Container details:"
podman inspect health-monitor-app --format '
Container Name: {{.Name}}
Status: {{.State.Status}}
IP Address: {{.NetworkSettings.IPAddress}}
Port Mappings: {{range .NetworkSettings.Ports}}{{.}}{{end}}
Mounts: {{range .Mounts}}{{.Source}} -> {{.Destination}}{{end}}'
echo ""
read -p "Press Enter to continue..."

# Step 7: Show logs
echo ""
echo "📝 Step 7: Container Logs"
echo "----------------------------"
echo "Recent container logs:"
podman logs --tail 15 health-monitor-app
echo ""
read -p "Press Enter to continue..."

# Step 8: Show running processes
echo ""
echo "⚙️  Step 8: Container Processes"
echo "----------------------------"
echo "Processes running inside container:"
podman top health-monitor-app
echo ""
read -p "Press Enter to continue..."

# Step 9: Resource usage
echo ""
echo "📊 Step 9: Resource Monitoring"
echo "----------------------------"
echo "Container resource usage:"
podman stats health-monitor-app --no-stream
echo ""
read -p "Press Enter to continue..."

# Step 10: Application access
echo ""
echo "🌐 Step 10: Application Access"
echo "----------------------------"
echo "The application is now running!"
echo ""
echo "Access it at: http://localhost:5000"
echo ""
echo "You can now:"
echo "  1. Open the browser and show the dashboard"
echo "  2. Add health records"
echo "  3. View all records"
echo "  4. Visualize data with charts"
echo ""
read -p "Press Enter when done with application demo..."

# Step 11: Health check
echo ""
echo "🏥 Step 11: Health Check"
echo "----------------------------"
echo "Testing application health endpoint:"
curl -s http://localhost:5000/health | python3 -m json.tool
echo ""
read -p "Press Enter to continue..."

# Step 12: Execute command in container
echo ""
echo "💻 Step 12: Execute Commands in Container"
echo "----------------------------"
echo "Listing files in /data directory:"
podman exec health-monitor-app ls -lah /data
echo ""
echo "Checking database file:"
podman exec health-monitor-app file /data/health_monitor.db
echo ""
read -p "Press Enter to continue..."

# Step 13: Stop and restart (show persistence)
echo ""
echo "🔄 Step 13: Data Persistence Demo"
echo "----------------------------"
echo "Stopping container..."
podman stop health-monitor-app
echo "Container stopped."
echo ""
echo "Removing container..."
podman rm health-monitor-app
echo "Container removed."
echo ""
echo "Note: Volume 'health-data' still exists with all data!"
podman volume ls | grep health-data
echo ""
read -p "Press Enter to restart container..."
echo ""
echo "Restarting container..."
./run.sh
echo ""
echo "✅ Container restarted! All data is preserved."
echo "You can verify by checking the application at http://localhost:5000"
echo ""
read -p "Press Enter to continue..."

# Final step
echo ""
echo "=========================================="
echo "✅ Demo Complete!"
echo "=========================================="
echo ""
echo "Summary of demonstrated concepts:"
echo "  ✓ Container image building"
echo "  ✓ Image inspection and management"
echo "  ✓ Volume creation and persistence"
echo "  ✓ Container lifecycle (run, stop, remove)"
echo "  ✓ Container inspection and monitoring"
echo "  ✓ Log management"
echo "  ✓ Process monitoring"
echo "  ✓ Resource usage tracking"
echo "  ✓ Health checks"
echo "  ✓ Command execution in containers"
echo "  ✓ Data persistence across container restarts"
echo ""
echo "The application is still running at: http://localhost:5000"
echo ""
echo "To stop the application: ./stop.sh"
echo "=========================================="

