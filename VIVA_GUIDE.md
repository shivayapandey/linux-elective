# Viva Voce Preparation Guide 🎓

## Smart Health Monitor - Container Technologies Project

---

## 📚 Quick Reference for Viva

### Project Basics

**Q: What is the title of your project?**
> Smart Health Monitor – A Lightweight Health Dashboard Deployed Inside Linux Containers

**Q: What problem does it solve?**
> Managing personal health data traditionally requires multiple software dependencies across different systems, leading to portability issues, inconsistent performance, and environmental incompatibility. Our containerized solution ensures seamless deployment across any Linux platform.

**Q: What are the key health metrics tracked?**
1. Heart Rate (bpm)
2. Blood Pressure - Systolic and Diastolic (mmHg)
3. Glucose Level (mg/dL)

---

## 🐳 Container Technology Questions

### Podman vs Docker

**Q: Why did you choose Podman over Docker?**
- **Rootless containers**: Better security, no root daemon required
- **Daemonless architecture**: No background service needed
- **OCI-compliant**: Compatible with Docker images
- **Native to RHEL/Fedora**: Recommended for enterprise Linux
- **Pod support**: Can manage groups of containers

**Q: What is a rootless container?**
> Rootless containers run without root privileges, improving security by limiting potential damage from container breakouts. Podman allows regular users to run containers without sudo.

### Container Lifecycle

**Q: Explain the container lifecycle in your project**

1. **BUILD**
   ```bash
   podman build -t smart-health-monitor:v1.0 -f Containerfile .
   ```
   - Reads Containerfile
   - Creates image layers
   - Installs dependencies
   - Tags the image

2. **RUN**
   ```bash
   podman run -d --name health-monitor-app -p 5000:5000 -v health-data:/data smart-health-monitor:v1.0
   ```
   - Creates container from image
   - Mounts volume
   - Maps ports
   - Starts application

3. **INSPECT**
   ```bash
   podman inspect health-monitor-app
   podman logs health-monitor-app
   podman stats health-monitor-app
   ```
   - Monitor container status
   - View logs
   - Check resource usage

4. **STOP**
   ```bash
   podman stop health-monitor-app
   podman rm health-monitor-app
   ```
   - Gracefully stop container
   - Remove container instance

5. **PUSH/PULL**
   ```bash
   podman push quay.io/username/smart-health-monitor:v1.0
   podman pull quay.io/username/smart-health-monitor:v1.0
   ```
   - Share via registry
   - Deploy on other systems

### Containerfile Explanation

**Q: Explain your Containerfile**

```dockerfile
FROM python:3.11-slim          # Base image - minimal Python
WORKDIR /app                   # Set working directory
RUN mkdir -p /data            # Create data directory for DB
COPY requirements.txt .        # Copy dependencies first (caching)
RUN pip install -r requirements.txt  # Install dependencies
COPY app.py templates/ static/ .     # Copy application files
ENV DB_PATH=/data/health_monitor.db  # Environment variable
EXPOSE 5000                    # Document port usage
HEALTHCHECK ...                # Container health monitoring
CMD ["python", "app.py"]      # Start application
```

**Key concepts:**
- **Layer caching**: Dependencies copied first for faster rebuilds
- **Minimal base**: `slim` variant reduces image size
- **Environment variables**: Configuration without code changes
- **Health checks**: Automated monitoring

---

## 💾 Volume and Persistence

**Q: What is a volume and why is it important?**
> A volume is a persistent storage mechanism that exists independently of containers. It's crucial because:
- Data survives container deletion
- Can be shared between containers
- Easier to backup and migrate
- Better performance than bind mounts

**Q: How does data persistence work in your project?**
1. Volume `health-data` created: `podman volume create health-data`
2. Mounted to container: `-v health-data:/data`
3. SQLite database stored at `/data/health_monitor.db`
4. Data persists even when container is removed
5. New container can mount same volume and access data

**Q: What happens to data when container is deleted?**
> The container is deleted, but the volume remains intact with all data. When we start a new container with the same volume mount, all previous data is immediately available.

---

## 🌐 Networking

**Q: Explain port mapping in your project**
```bash
-p 5000:5000
```
- **Host port**: 5000 (left side)
- **Container port**: 5000 (right side)
- Maps host's port 5000 to container's port 5000
- Allows external access to containerized application
- Access via `http://localhost:5000`

**Q: What is container networking?**
> Containers have their own network namespace. Podman creates a virtual network interface for each container, assigns an IP address, and manages routing. Port mapping bridges the container network to the host network.

---

## 🏗️ Application Architecture

**Q: Explain your application architecture**

```
┌─────────────────────────────────────┐
│         User Browser                │
│     http://localhost:5000           │
└──────────────┬──────────────────────┘
               │
               ▼
┌─────────────────────────────────────┐
│      Host System (Linux)            │
│  Port 5000 → Container Port 5000    │
└──────────────┬──────────────────────┘
               │
               ▼
┌─────────────────────────────────────┐
│    Podman Container                 │
│  ┌─────────────────────────────┐   │
│  │   Flask Application         │   │
│  │   - Routes & Logic          │   │
│  │   - HTML Templates          │   │
│  │   - Plotly Visualization    │   │
│  └──────────┬──────────────────┘   │
│             │                       │
│             ▼                       │
│  ┌─────────────────────────────┐   │
│  │   SQLite Database           │   │
│  │   /data/health_monitor.db   │   │
│  └─────────────────────────────┘   │
└──────────────┬──────────────────────┘
               │
               ▼
┌─────────────────────────────────────┐
│    Podman Volume: health-data       │
│    (Persistent Storage)             │
└─────────────────────────────────────┘
```

**Q: Why Flask?**
- Lightweight and simple
- Easy to containerize
- Perfect for small applications
- Good for educational purposes
- Minimal dependencies

**Q: Why SQLite?**
- Serverless database
- No separate database container needed
- File-based (easy to backup)
- Perfect for single-user applications
- Zero configuration

---

## 📊 Visualization

**Q: How does visualization work?**
1. Flask queries SQLite database
2. Data converted to Python lists
3. Plotly creates interactive charts
4. JSON data passed to template
5. Plotly.js renders in browser
6. User can zoom, pan, hover for details

**Q: What charts are displayed?**
- Heart Rate over time (line chart)
- Blood Pressure over time (dual line chart - systolic/diastolic)
- Glucose Level over time (line chart)
- All with interactive features

---

## 🔒 Security

**Q: What security measures are implemented?**
1. **Rootless containers**: No root privileges required
2. **Input validation**: Form validation for health metrics
3. **Minimal base image**: Reduced attack surface
4. **No hardcoded secrets**: Environment variables for config
5. **Health checks**: Monitor container health
6. **Isolated environment**: Container isolation

---

## 🛠️ Linux Concepts

**Q: What Linux concepts does your project demonstrate?**

1. **File System Operations**
   - Volume mounting
   - File permissions
   - Directory structure

2. **Process Management**
   - Container processes
   - Process isolation
   - Resource limits

3. **Networking**
   - Port mapping
   - Network namespaces
   - TCP/IP communication

4. **Shell Scripting**
   - Automation scripts (build.sh, run.sh)
   - Error handling
   - User interaction

---

## 🎯 Demo Flow

### Recommended Demo Sequence (10-15 minutes)

1. **Introduction (1 min)**
   - Project overview
   - Problem and solution

2. **Show Containerfile (1 min)**
   - Explain key lines
   - Highlight best practices

3. **Build Image (2 min)**
   ```bash
   ./build.sh
   podman images
   ```

4. **Run Container (2 min)**
   ```bash
   ./run.sh
   podman ps
   ```

5. **Application Demo (4 min)**
   - Dashboard
   - Add record
   - View records
   - Visualization

6. **Container Operations (3 min)**
   ```bash
   ./inspect.sh
   podman logs health-monitor-app
   podman stats health-monitor-app
   ```

7. **Data Persistence (2 min)**
   ```bash
   ./stop.sh
   ./run.sh
   # Show data still exists
   ```

---

## 💡 Common Viva Questions & Answers

**Q: What is the difference between an image and a container?**
> An **image** is a read-only template with application code and dependencies. A **container** is a running instance of an image. Think of image as a class and container as an object.

**Q: What is a Containerfile?**
> A Containerfile (also called Dockerfile) is a text file with instructions to build a container image. It specifies the base image, dependencies, files to copy, and commands to run.

**Q: Can you run this on Windows?**
> Yes, with Podman Desktop or WSL2 (Windows Subsystem for Linux). The container ensures it runs identically on any platform that supports Podman.

**Q: What happens if the container crashes?**
> The data in the volume is safe. We can start a new container with the same volume mount, and all data is preserved. The health check can also trigger automatic restarts.

**Q: How do you backup the data?**
```bash
podman run --rm -v health-data:/data -v $(pwd):/backup alpine tar czf /backup/health-data-backup.tar.gz /data
```

**Q: What is the size of your container image?**
```bash
podman images smart-health-monitor
# Approximately 150-200 MB (Python slim base + dependencies)
```

**Q: How would you scale this application?**
- Use container orchestration (Kubernetes, Podman pods)
- Add load balancer
- Use external database (PostgreSQL)
- Multiple container instances

**Q: What is OCI?**
> Open Container Initiative - industry standards for container formats and runtimes. Ensures compatibility between different container tools.

---

## 🚨 Troubleshooting During Demo

**If container won't start:**
```bash
podman logs health-monitor-app
# Check for errors
```

**If port is busy:**
```bash
podman run -d --name health-monitor-app -p 5001:5000 -v health-data:/data smart-health-monitor:v1.0
# Use different host port
```

**If volume issues:**
```bash
podman volume ls
podman volume inspect health-data
```

---

## 📝 Key Takeaways

1. ✅ Containerization solves portability issues
2. ✅ Podman provides rootless, secure containers
3. ✅ Volumes ensure data persistence
4. ✅ Port mapping enables external access
5. ✅ Health checks monitor application status
6. ✅ Container lifecycle: build → run → inspect → stop
7. ✅ Registry enables sharing and deployment
8. ✅ Linux fundamentals: processes, networking, file systems

---

## 🎓 Syllabus Coverage

This project covers:
- ✅ Linux administration and process management
- ✅ File system operations
- ✅ Container image creation and versioning
- ✅ Container lifecycle operations (build, run, inspect, log, push, pull)
- ✅ Container registry management and deployment
- ✅ Volume management
- ✅ Networking and port mapping
- ✅ Shell scripting

---

**Good luck with your viva! 🍀**
