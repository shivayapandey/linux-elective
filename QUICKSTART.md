# Quick Start Guide 🚀

Get the Smart Health Monitor running in 5 minutes!

## Prerequisites

- Linux OS (Fedora, RHEL, Ubuntu, etc.)
- Podman installed

### Install Podman

**Fedora/RHEL:**
```bash
sudo dnf install podman
```

**Ubuntu/Debian:**
```bash
sudo apt-get update
sudo apt-get install podman
```

**Verify:**
```bash
podman --version
```

## 3-Step Setup

### Step 1: Make Scripts Executable
```bash
chmod +x *.sh
```

### Step 2: Build the Container
```bash
./build.sh
```

### Step 3: Run the Application
```bash
./run.sh
```

## Access the Application

Open your browser:
```
http://localhost:5000
```

## What You'll See

1. **Dashboard** - Overview of your health statistics
2. **Add Record** - Input your health metrics
3. **All Records** - View complete history
4. **Visualize** - Interactive charts

## Add Your First Record

1. Click "Add Record"
2. Enter:
   - Heart Rate: e.g., 72 bpm
   - Blood Pressure: e.g., 120/80 mmHg
   - Glucose: e.g., 95 mg/dL
3. Click "Save Record"

## View Visualizations

1. Add at least 3-5 records
2. Click "Visualize"
3. See interactive charts of your health trends

## Stop the Application

```bash
./stop.sh
```

## Useful Commands

```bash
# View logs
podman logs health-monitor-app

# Check container status
podman ps

# Inspect container
./inspect.sh

# View all images
podman images

# View volumes
podman volume ls
```

## Troubleshooting

**Port already in use?**
```bash
sudo lsof -i :5000
# Kill the process or change port in run.sh
```

**Container won't start?**
```bash
podman logs health-monitor-app
```

**Need to reset everything?**
```bash
./stop.sh
podman volume rm health-data
./run.sh
```

## For Demo/Viva

Use the automated demo script:
```bash
./demo.sh
```

This will walk through all features step-by-step!

## Next Steps

- Read [README.md](README.md) for detailed documentation
- Check [VIVA_GUIDE.md](VIVA_GUIDE.md) for viva preparation
- Explore container operations with `./inspect.sh`

---

**That's it! You're ready to go! 🎉**

