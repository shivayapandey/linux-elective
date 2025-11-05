# Project Summary 📊

## Smart Health Monitor - Complete Overview

**Course**: 21CSE216P – Linux and Container Technologies  
**Batch**: Batch 3  
**Students**: Shivaya Pandey (RA2311056010032) & Tanisha Raha (RA2311056010042)

---

## 🎯 What This Project Does

A **containerized web application** that allows users to:
1. ✅ Record health metrics (heart rate, blood pressure, glucose)
2. ✅ View health history in a table
3. ✅ Visualize trends with interactive charts
4. ✅ Track health statistics over time

All running inside a **Podman container** with **persistent data storage**.

---

## 📁 Project Files

### Core Application Files
- **app.py** - Flask web application (main code)
- **requirements.txt** - Python dependencies
- **Containerfile** - Container image definition

### HTML Templates (in `templates/`)
- **base.html** - Master layout template
- **index.html** - Dashboard page
- **add_record.html** - Form to add health data
- **records.html** - Table view of all records
- **visualize.html** - Interactive charts page

### Container Scripts
- **build.sh** - Build the container image
- **run.sh** - Run the container
- **stop.sh** - Stop and remove container
- **inspect.sh** - Inspect container details
- **push-registry.sh** - Push image to registry
- **demo.sh** - Automated demo for viva

### Documentation
- **README.md** - Complete project documentation
- **QUICKSTART.md** - 5-minute setup guide
- **VIVA_GUIDE.md** - Viva preparation with Q&A
- **ARCHITECTURE.md** - System architecture details
- **PROJECT_SUMMARY.md** - This file

### Utilities
- **add_sample_data.py** - Generate sample health records
- **.gitignore** - Git ignore rules
- **.containerignore** - Container build ignore rules

---

## 🚀 How to Run (3 Steps)

### Step 1: Make scripts executable
```bash
chmod +x *.sh
```

### Step 2: Build container
```bash
./build.sh
```

### Step 3: Run application
```bash
./run.sh
```

**Access at**: http://localhost:5000

---

## 🎬 For Demo/Viva

### Quick Demo (5 minutes)
```bash
./demo.sh
```
This automated script walks through all features!

### Manual Demo Steps
1. Show Containerfile and explain
2. Build image: `./build.sh`
3. Run container: `./run.sh`
4. Open browser: http://localhost:5000
5. Add health records
6. Show visualizations
7. Inspect container: `./inspect.sh`
8. Show data persistence: `./stop.sh` then `./run.sh`

---

## 💡 Key Concepts Demonstrated

### Linux Fundamentals
- ✅ File system operations (volume mounting)
- ✅ Process management (container processes)
- ✅ Networking (port mapping)
- ✅ Shell scripting (automation)

### Container Technologies
- ✅ Image creation (Containerfile)
- ✅ Container lifecycle (build, run, stop, inspect)
- ✅ Volume management (persistent storage)
- ✅ Registry operations (push/pull)
- ✅ Container monitoring (logs, stats, health checks)

### Application Development
- ✅ Web application (Flask)
- ✅ Database (SQLite)
- ✅ Data visualization (Plotly)
- ✅ Responsive UI (Bootstrap)

---

## 📊 Application Features

### 1. Dashboard (/)
- Total records count
- Average heart rate
- Average blood pressure
- Average glucose level
- Recent 10 records

### 2. Add Record (/add)
- Input form with validation
- Heart rate (40-200 bpm)
- Blood pressure (systolic/diastolic)
- Glucose level (50-400 mg/dL)
- Optional notes

### 3. View Records (/records)
- Complete health history
- Color-coded indicators:
  - 🟢 Green = Normal
  - 🟡 Yellow = Elevated
  - 🔴 Red = High
- Delete functionality

### 4. Visualize (/visualize)
- Interactive line charts
- Heart rate trends
- Blood pressure trends
- Glucose level trends
- Zoom, pan, hover features

---

## 🔧 Container Operations

### Build
```bash
./build.sh
# Creates: smart-health-monitor:v1.0
```

### Run
```bash
./run.sh
# Creates volume: health-data
# Starts container: health-monitor-app
# Port mapping: 5000:5000
```

### Inspect
```bash
./inspect.sh
# Shows: status, logs, processes, resources
```

### Stop
```bash
./stop.sh
# Stops and removes container
# Volume persists!
```

### Logs
```bash
podman logs health-monitor-app
podman logs -f health-monitor-app  # Follow
```

### Stats
```bash
podman stats health-monitor-app
```

---

## 🗄️ Database Schema

```sql
CREATE TABLE health_records (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    timestamp DATETIME DEFAULT CURRENT_TIMESTAMP,
    heart_rate INTEGER,
    systolic_bp INTEGER,
    diastolic_bp INTEGER,
    glucose_level REAL,
    notes TEXT
);
```

**Location**: `/data/health_monitor.db` (inside container)  
**Persistence**: Stored in `health-data` volume

---

## 🎓 Syllabus Coverage

| Requirement | Implementation |
|-------------|----------------|
| Linux administration | Shell scripts, process management |
| File system operations | Volume mounting, data persistence |
| Container image creation | Containerfile, build process |
| Container versioning | Image tagging (v1.0) |
| Container lifecycle | Build, run, inspect, stop, logs |
| Container registry | Push/pull scripts for Quay.io/Docker Hub |
| Networking | Port mapping, container networking |
| Process management | Container processes, monitoring |

---

## 🛠️ Technology Stack

| Component | Technology | Version |
|-----------|-----------|---------|
| Container Engine | Podman | Latest |
| Base Image | Python | 3.11-slim |
| Web Framework | Flask | 3.0.0 |
| Database | SQLite | 3.x |
| Visualization | Plotly | 5.18.0 |
| Frontend | Bootstrap | 5.3.0 |
| Icons | Bootstrap Icons | 1.11.0 |
| OS | Linux | Fedora/RHEL/Ubuntu |

---

## 📝 Important Commands

### Container Management
```bash
podman ps                    # List running containers
podman ps -a                 # List all containers
podman images                # List images
podman volume ls             # List volumes
podman inspect <name>        # Inspect container/image
podman logs <name>           # View logs
podman stats <name>          # Resource usage
podman exec -it <name> bash  # Shell access
```

### Volume Management
```bash
podman volume create health-data
podman volume inspect health-data
podman volume rm health-data
```

### Image Management
```bash
podman build -t name:tag .
podman tag local remote
podman push remote
podman pull remote
podman rmi name:tag
```

---

## 🎯 Viva Quick Points

**Q: What is your project?**
> A containerized health monitoring web application using Podman that tracks heart rate, blood pressure, and glucose levels with data visualization.

**Q: Why containerization?**
> Ensures portability, eliminates dependency issues, provides consistent environment across systems, and simplifies deployment.

**Q: Why Podman?**
> Rootless (more secure), daemonless (simpler), OCI-compliant (compatible), and native to RHEL/Fedora.

**Q: How is data persisted?**
> Using Podman volumes. The SQLite database is stored in a named volume `health-data` that persists even when containers are deleted.

**Q: Explain the container lifecycle**
> Build image → Create volume → Run container → Mount volume → Application serves → Stop container → Data persists in volume

**Q: What Linux concepts are used?**
> File system operations (volumes), process management (containers), networking (port mapping), and shell scripting (automation).

---

## 🐛 Common Issues & Solutions

**Port 5000 in use?**
```bash
sudo lsof -i :5000
# Kill process or change port
```

**Container won't start?**
```bash
podman logs health-monitor-app
# Check error messages
```

**Data lost?**
```bash
podman volume ls
# Verify volume exists
```

**Permission denied?**
```bash
chmod +x *.sh
# Make scripts executable
```

---

## 📈 Demo Checklist

Before demo:
- [ ] Podman installed and working
- [ ] All scripts executable (`chmod +x *.sh`)
- [ ] Container image built (`./build.sh`)
- [ ] Sample data added (optional: `python3 add_sample_data.py`)
- [ ] Application running (`./run.sh`)
- [ ] Browser tested (http://localhost:5000)

During demo:
- [ ] Explain problem statement
- [ ] Show Containerfile
- [ ] Demonstrate build process
- [ ] Show running container
- [ ] Demo application features
- [ ] Show container inspection
- [ ] Demonstrate data persistence
- [ ] Answer questions confidently

---

## 🎉 Success Criteria

Your project successfully demonstrates:
- ✅ Container image creation from Containerfile
- ✅ Container lifecycle management
- ✅ Persistent data storage with volumes
- ✅ Port mapping and networking
- ✅ Container monitoring and logging
- ✅ Registry operations (push/pull)
- ✅ Practical application of Linux concepts
- ✅ Working web application with visualization

---

## 📚 Additional Resources

- **Full Documentation**: README.md
- **Quick Setup**: QUICKSTART.md
- **Viva Prep**: VIVA_GUIDE.md
- **Architecture**: ARCHITECTURE.md
- **Podman Docs**: https://docs.podman.io/

---

## 🏆 Project Highlights

1. **Complete Implementation** - All requirements met
2. **Production-Ready** - Follows best practices
3. **Well-Documented** - Comprehensive guides
4. **Demo-Ready** - Automated demo script
5. **Educational** - Clear learning outcomes
6. **Practical** - Real-world application
7. **Scalable** - Can be extended
8. **Secure** - Rootless containers

---

**You're ready for your demo and viva! Good luck! 🍀**

---

## Quick Reference Card

```
BUILD:    ./build.sh
RUN:      ./run.sh
STOP:     ./stop.sh
INSPECT:  ./inspect.sh
DEMO:     ./demo.sh
ACCESS:   http://localhost:5000
```

**Remember**: Data persists in the `health-data` volume even after container deletion!

