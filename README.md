# Smart Health Monitor 🏥

**A Containerized Health Monitoring System Using Podman on Linux**

**Course:** 21CSE216P – Linux and Container Technologies  
**Batch:** Batch 3  
**Team Members:**
- Shivaya Pandey - RA2311056010032
- Tanisha Raha - RA2311056010042

---

## 📋 Table of Contents
- [Project Overview](#project-overview)
- [Features](#features)
- [Technology Stack](#technology-stack)
- [Prerequisites](#prerequisites)
- [Quick Start Guide](#quick-start-guide)
- [Container Operations](#container-operations)
- [Application Usage](#application-usage)
- [Demo Instructions](#demo-instructions)
- [Viva Talking Points](#viva-talking-points)
- [Troubleshooting](#troubleshooting)

---

## 🎯 Project Overview

The **Smart Health Monitor** is a lightweight, containerized web application that enables users to record and visualize essential health metrics including:
- ❤️ Heart Rate (bpm)
- 🩺 Blood Pressure (Systolic/Diastolic)
- 🩸 Glucose Levels (mg/dL)

This project demonstrates practical implementation of **Linux fundamentals** and **Podman-based containerization**, ensuring seamless deployment, scalability, and platform independence.

### Problem Statement
Managing personal health data traditionally requires multiple software dependencies across different systems, leading to:
- Portability issues
- Inconsistent performance
- Environmental incompatibility

### Solution
A fully containerized Flask-based web application deployed using Podman, featuring:
- ✅ Persistent data storage using volumes
- ✅ Interactive data visualization with Plotly
- ✅ Container lifecycle management
- ✅ Platform-independent deployment

---

## ✨ Features

### Application Features
- 📊 **Dashboard**: Overview of health statistics and recent records
- ➕ **Add Records**: Input health metrics with validation
- 📋 **View Records**: Browse all health data with color-coded indicators
- 📈 **Visualize**: Interactive charts showing health trends over time
- 🗑️ **Delete Records**: Remove unwanted entries
- 🔍 **Health Check**: Container monitoring endpoint

### Container Features
- 🐳 **Podman Containerization**: Rootless container deployment
- 💾 **Persistent Volumes**: Data survives container restarts
- 🔄 **Lifecycle Management**: Build, run, stop, inspect operations
- 📦 **Registry Support**: Push/pull from Quay.io or Docker Hub
- 🏥 **Health Checks**: Automated container health monitoring
- 📝 **Logging**: Comprehensive container logs

---

## 🛠️ Technology Stack

| Component | Technology |
|-----------|-----------|
| **Operating System** | Fedora / RHEL / Linux |
| **Container Engine** | Podman |
| **Backend Framework** | Python Flask |
| **Database** | SQLite |
| **Visualization** | Plotly.js |
| **Frontend** | HTML5, CSS3, Bootstrap 5 |
| **Version Control** | Git |

---

## 📦 Prerequisites

### System Requirements
- Linux OS (Fedora, RHEL, Ubuntu, etc.)
- Podman installed
- Python 3.11+ (for local development)
- 2GB RAM minimum
- 1GB free disk space

### Installing Podman

**Fedora/RHEL:**
```bash
sudo dnf install podman
```

**Ubuntu/Debian:**
```bash
sudo apt-get update
sudo apt-get install podman
```

**Verify Installation:**
```bash
podman --version
```

---

## 🚀 Quick Start Guide

### Step 1: Clone the Repository
```bash
git clone <repository-url>
cd linux
```

### Step 2: Make Scripts Executable
```bash
chmod +x build.sh run.sh stop.sh inspect.sh push-registry.sh
```

### Step 3: Build the Container Image
```bash
./build.sh
```

This will:
- Build the container image using the Containerfile
- Tag it as `smart-health-monitor:v1.0`
- Display image details

### Step 4: Run the Container
```bash
./run.sh
```

This will:
- Create a persistent volume named `health-data`
- Start the container on port 5000
- Mount the volume to `/data` inside the container
- Display access information

### Step 5: Access the Application
Open your browser and navigate to:
```
http://localhost:5000
```

---

## 🔧 Container Operations

### Build Image
```bash
./build.sh
# OR manually:
podman build -t smart-health-monitor:v1.0 -f Containerfile .
```

### Run Container
```bash
./run.sh
# OR manually:
podman run -d --name health-monitor-app -p 5000:5000 -v health-data:/data smart-health-monitor:v1.0
```

### Stop Container
```bash
./stop.sh
# OR manually:
podman stop health-monitor-app
podman rm health-monitor-app
```

### Inspect Container
```bash
./inspect.sh
# OR manually:
podman inspect health-monitor-app
podman logs health-monitor-app
podman stats health-monitor-app
```

### View Logs
```bash
# View all logs
podman logs health-monitor-app

# Follow logs in real-time
podman logs -f health-monitor-app

# Last 50 lines
podman logs --tail 50 health-monitor-app
```

### Execute Commands Inside Container
```bash
# Open shell
podman exec -it health-monitor-app /bin/bash

# Check database
podman exec health-monitor-app ls -la /data
```

### Volume Management
```bash
# List volumes
podman volume ls

# Inspect volume
podman volume inspect health-data

# Remove volume (WARNING: deletes all data)
podman volume rm health-data
```

### Push to Registry
```bash
./push-registry.sh
# Follow prompts to push to Quay.io or Docker Hub
```

### Pull from Registry
```bash
podman pull quay.io/<username>/smart-health-monitor:v1.0
```

---

## 📱 Application Usage

### 1. Dashboard
- View summary statistics (total records, averages)
- See recent health records
- Quick access to all features

### 2. Add Health Record
- Enter heart rate (40-200 bpm)
- Enter blood pressure (systolic/diastolic)
- Enter glucose level (50-400 mg/dL)
- Add optional notes
- Automatic validation and warnings

### 3. View All Records
- Browse complete health history
- Color-coded health indicators:
  - 🟢 Green: Normal range
  - 🟡 Yellow: Elevated
  - 🔴 Red: High risk
- Delete unwanted records

### 4. Visualize Data
- Interactive line charts
- Three separate graphs:
  - Heart rate trends
  - Blood pressure trends
  - Glucose level trends
- Hover for detailed values
- Zoom and pan capabilities

---

## 🎬 Demo Instructions

### Preparation (Before Demo)
1. Ensure Podman is installed and running
2. Build the container image
3. Have the application running
4. Add 5-10 sample health records for visualization

### Demo Flow (10-15 minutes)

#### Part 1: Introduction (2 min)
- Explain the problem statement
- Show the project architecture diagram
- Mention technologies used

#### Part 2: Container Operations (5 min)
```bash
# Show container image
podman images smart-health-monitor

# Show running containers
podman ps

# Inspect container
./inspect.sh

# Show logs
podman logs health-monitor-app

# Show volume
podman volume inspect health-data
```

#### Part 3: Application Demo (5 min)
1. Open browser to `http://localhost:5000`
2. Show dashboard with statistics
3. Add a new health record
4. View all records table
5. Show visualization charts
6. Demonstrate delete functionality

#### Part 4: Container Lifecycle (3 min)
```bash
# Stop container
./stop.sh

# Verify it's stopped
podman ps -a

# Restart container
./run.sh

# Show data persistence (records still there)
```

---

## 💡 Viva Talking Points

### Linux Fundamentals

**Q: What Linux concepts does this project demonstrate?**
- File system operations (volume mounting)
- Process management (container processes)
- Networking (port mapping, container networking)
- User permissions (rootless containers with Podman)
- Shell scripting (build.sh, run.sh, etc.)

**Q: How does the application use the Linux file system?**
- SQLite database stored in `/data` directory
- Volume mounted from host to container
- Persistent storage across container restarts
- File permissions managed by Podman

### Container Technologies

**Q: Why Podman instead of Docker?**
- Rootless containers (better security)
- Daemonless architecture
- Compatible with Docker commands
- Native to RHEL/Fedora ecosystem
- OCI-compliant

**Q: Explain the container lifecycle in this project**
1. **Build**: Create image from Containerfile
2. **Run**: Start container with volume and port mapping
3. **Inspect**: Monitor container status and logs
4. **Stop**: Gracefully stop and remove container
5. **Push/Pull**: Share via container registry

**Q: What is a volume and why is it important?**
- Named storage that persists beyond container lifecycle
- Separates data from application
- Enables data backup and migration
- In this project: stores SQLite database

**Q: Explain port mapping**
- Host port 5000 → Container port 5000
- Allows external access to containerized app
- Format: `-p host_port:container_port`

### Application Architecture

**Q: Why Flask for this project?**
- Lightweight and simple
- Perfect for containerization
- Easy to demonstrate
- Good for educational purposes

**Q: How does data persistence work?**
- SQLite database in `/data/health_monitor.db`
- Volume `health-data` mounted to `/data`
- Data survives container deletion
- Can be backed up independently

**Q: What are the health check endpoints?**
- `/health` - Returns container health status
- Used by Podman's HEALTHCHECK
- Monitors application availability

### Technical Details

**Q: What happens when you run `./build.sh`?**
1. Reads Containerfile
2. Pulls base image (python:3.11-slim)
3. Copies application files
4. Installs dependencies
5. Sets environment variables
6. Creates tagged image

**Q: What happens when you run `./run.sh`?**
1. Checks for existing container
2. Creates volume if needed
3. Starts container in detached mode
4. Maps port 5000
5. Mounts volume
6. Returns container ID

**Q: How is the database initialized?**
- `init_db()` function in app.py
- Creates table if not exists
- Runs on application startup
- Schema: id, timestamp, heart_rate, systolic_bp, diastolic_bp, glucose_level, notes

### Visualization

**Q: How does the visualization work?**
- Plotly.js for interactive charts
- Data fetched from SQLite
- Three subplots: heart rate, BP, glucose
- Real-time rendering in browser

### Security & Best Practices

**Q: What security measures are implemented?**
- Rootless containers (Podman)
- No hardcoded credentials
- Input validation on forms
- Minimal base image (slim)
- Health checks for monitoring

**Q: What are the best practices followed?**
- Multi-stage builds (efficient layers)
- .containerignore (smaller images)
- Environment variables for configuration
- Volume for data persistence
- Proper labeling of images

### Troubleshooting

**Q: What if the container won't start?**
```bash
# Check logs
podman logs health-monitor-app

# Check if port is in use
sudo lsof -i :5000

# Verify image exists
podman images
```

**Q: What if data is lost?**
- Check volume exists: `podman volume ls`
- Inspect volume: `podman volume inspect health-data`
- Verify mount point in container

---

## 🐛 Troubleshooting

### Container Issues

**Problem: Port already in use**
```bash
# Find process using port 5000
sudo lsof -i :5000
# Kill the process or use different port
```

**Problem: Permission denied**
```bash
# Ensure scripts are executable
chmod +x *.sh
```

**Problem: Container won't start**
```bash
# Check logs
podman logs health-monitor-app

# Verify image
podman images

# Try running in foreground
podman run --rm -p 5000:5000 smart-health-monitor:v1.0
```

### Application Issues

**Problem: Database not found**
```bash
# Verify volume mount
podman inspect health-monitor-app | grep -A 5 Mounts

# Check volume
podman volume inspect health-data
```

**Problem: Can't access application**
- Verify container is running: `podman ps`
- Check firewall settings
- Try `http://127.0.0.1:5000` instead of localhost

---

## 📚 Project Structure

```
linux/
├── app.py                  # Flask application
├── requirements.txt        # Python dependencies
├── Containerfile          # Container image definition
├── .containerignore       # Files to exclude from image
├── build.sh              # Build container image
├── run.sh                # Run container
├── stop.sh               # Stop container
├── inspect.sh            # Inspect container
├── push-registry.sh      # Push to registry
├── README.md             # This file
├── templates/            # HTML templates
│   ├── base.html
│   ├── index.html
│   ├── add_record.html
│   ├── records.html
│   └── visualize.html
└── static/              # Static files (CSS, JS)
```

---

## 🎓 Learning Outcomes

This project demonstrates:
1. ✅ Linux administration and process management
2. ✅ File system operations and volume management
3. ✅ Container image creation and versioning
4. ✅ Container lifecycle operations (build, run, inspect, log)
5. ✅ Container registry management
6. ✅ Networking and port mapping
7. ✅ Data persistence in containers
8. ✅ Health monitoring and logging
9. ✅ Shell scripting for automation
10. ✅ Web application containerization

---

## 📝 Additional Commands Reference

### Container Management
```bash
# List all containers
podman ps -a

# Remove all stopped containers
podman container prune

# View container resource usage
podman stats

# Export container
podman export health-monitor-app > health-app.tar

# Import container
podman import health-app.tar
```

### Image Management
```bash
# List all images
podman images

# Remove image
podman rmi smart-health-monitor:v1.0

# Remove unused images
podman image prune

# Save image to file
podman save -o health-monitor.tar smart-health-monitor:v1.0

# Load image from file
podman load -i health-monitor.tar
```

### Volume Management
```bash
# List volumes
podman volume ls

# Create volume
podman volume create health-data

# Remove volume
podman volume rm health-data

# Backup volume data
podman run --rm -v health-data:/data -v $(pwd):/backup alpine tar czf /backup/health-data-backup.tar.gz /data
```

---

## 🤝 Contributing

This is an academic project for demonstration purposes.

---

## 📄 License

Educational project for 21CSE216P – Linux and Container Technologies

---

## 👥 Authors

- **Shivaya Pandey** - RA2311056010032
- **Tanisha Raha** - RA2311056010042

**Batch 3** | Linux and Container Technologies

---

## 🙏 Acknowledgments

- Course: 21CSE216P – Linux and Container Technologies
- Institution: SRM Institute of Science and Technology
- Technologies: Podman, Flask, Python, SQLite, Plotly

---

**Happy Health Monitoring! 🏥💪**

