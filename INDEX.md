# Smart Health Monitor - Project Index 📑

**Complete File Guide for Your Project**

---

## 🎯 Start Here

**New to the project?** → Read [QUICKSTART.md](QUICKSTART.md)  
**Preparing for demo?** → Read [PROJECT_SUMMARY.md](PROJECT_SUMMARY.md)  
**Preparing for viva?** → Read [VIVA_GUIDE.md](VIVA_GUIDE.md)

---

## 📚 Documentation Files

### Essential Reading

| File | Purpose | When to Read |
|------|---------|--------------|
| **[QUICKSTART.md](QUICKSTART.md)** | 5-minute setup guide | First time setup |
| **[PROJECT_SUMMARY.md](PROJECT_SUMMARY.md)** | Complete overview | Before demo |
| **[README.md](README.md)** | Full documentation | Detailed reference |
| **[VIVA_GUIDE.md](VIVA_GUIDE.md)** | Viva Q&A preparation | Before viva |
| **[ARCHITECTURE.md](ARCHITECTURE.md)** | System architecture | Understanding design |
| **[TESTING_CHECKLIST.md](TESTING_CHECKLIST.md)** | Pre-demo testing | Before demo |
| **[INDEX.md](INDEX.md)** | This file - project index | Navigation |

### Quick Reference

```
QUICKSTART.md       → Get running in 5 minutes
PROJECT_SUMMARY.md  → Everything in one place
VIVA_GUIDE.md       → Ace your viva
README.md           → Complete documentation
```

---

## 💻 Application Files

### Core Application

| File | Description | Lines | Purpose |
|------|-------------|-------|---------|
| **app.py** | Flask application | ~250 | Main application logic |
| **requirements.txt** | Python dependencies | ~3 | Package requirements |
| **Containerfile** | Container definition | ~40 | Image build instructions |
| **.containerignore** | Build exclusions | ~20 | Optimize image size |
| **.gitignore** | Git exclusions | ~30 | Version control |

### HTML Templates (templates/)

| File | Description | Purpose |
|------|-------------|---------|
| **base.html** | Master template | Layout, navigation, styling |
| **index.html** | Dashboard page | Statistics and recent records |
| **add_record.html** | Input form | Add new health data |
| **records.html** | Data table | View all records |
| **visualize.html** | Charts page | Interactive visualizations |

---

## 🔧 Automation Scripts

### Container Management Scripts

| Script | Purpose | Usage |
|--------|---------|-------|
| **build.sh** | Build container image | `./build.sh` |
| **run.sh** | Run container | `./run.sh` |
| **stop.sh** | Stop container | `./stop.sh` |
| **inspect.sh** | Inspect container | `./inspect.sh` |
| **push-registry.sh** | Push to registry | `./push-registry.sh` |
| **demo.sh** | Automated demo | `./demo.sh` |

### Utility Scripts

| Script | Purpose | Usage |
|--------|---------|-------|
| **add_sample_data.py** | Generate test data | `python3 add_sample_data.py 10` |

---

## 📂 Directory Structure

```
linux/
│
├── 📄 Documentation (Read These!)
│   ├── INDEX.md                    ← You are here
│   ├── QUICKSTART.md              ← Start here for setup
│   ├── PROJECT_SUMMARY.md         ← Overview for demo
│   ├── README.md                  ← Complete documentation
│   ├── VIVA_GUIDE.md              ← Viva preparation
│   ├── ARCHITECTURE.md            ← System design
│   └── TESTING_CHECKLIST.md       ← Pre-demo testing
│
├── 🐍 Application Code
│   ├── app.py                     ← Flask application
│   ├── requirements.txt           ← Python packages
│   └── add_sample_data.py         ← Test data generator
│
├── 🐳 Container Files
│   ├── Containerfile              ← Image definition
│   ├── .containerignore           ← Build exclusions
│   └── .gitignore                 ← Git exclusions
│
├── 🔧 Automation Scripts
│   ├── build.sh                   ← Build image
│   ├── run.sh                     ← Run container
│   ├── stop.sh                    ← Stop container
│   ├── inspect.sh                 ← Inspect container
│   ├── push-registry.sh           ← Push to registry
│   └── demo.sh                    ← Automated demo
│
├── 🎨 Templates (HTML)
│   └── templates/
│       ├── base.html              ← Master layout
│       ├── index.html             ← Dashboard
│       ├── add_record.html        ← Input form
│       ├── records.html           ← Data table
│       └── visualize.html         ← Charts
│
└── 📁 Static Files
    └── static/
        ├── css/                   ← Stylesheets (if any)
        └── js/                    ← JavaScript (if any)
```

---

## 🎯 Workflow Guide

### First Time Setup

1. Read [QUICKSTART.md](QUICKSTART.md)
2. Run `chmod +x *.sh`
3. Run `./build.sh`
4. Run `./run.sh`
5. Open http://localhost:5000

### Before Demo

1. Read [PROJECT_SUMMARY.md](PROJECT_SUMMARY.md)
2. Read [VIVA_GUIDE.md](VIVA_GUIDE.md)
3. Follow [TESTING_CHECKLIST.md](TESTING_CHECKLIST.md)
4. Practice with `./demo.sh`
5. Add sample data: `python3 add_sample_data.py 10`

### During Demo

1. Run `./demo.sh` for automated demo, OR
2. Manual demo:
   - Show Containerfile
   - Run `./build.sh`
   - Run `./run.sh`
   - Demo application features
   - Run `./inspect.sh`
   - Show data persistence

### Understanding the System

1. Read [ARCHITECTURE.md](ARCHITECTURE.md) for system design
2. Read [README.md](README.md) for complete details
3. Review app.py for application logic
4. Review Containerfile for container setup

---

## 🎓 Learning Path

### Beginner
1. ✅ QUICKSTART.md - Get it running
2. ✅ PROJECT_SUMMARY.md - Understand what it does
3. ✅ Use the application - Add records, view charts

### Intermediate
4. ✅ README.md - Learn all features
5. ✅ ARCHITECTURE.md - Understand design
6. ✅ Review app.py - Understand code

### Advanced
7. ✅ VIVA_GUIDE.md - Master concepts
8. ✅ Modify and experiment
9. ✅ Push to registry

---

## 📖 Documentation by Purpose

### For Setup
- [QUICKSTART.md](QUICKSTART.md) - Fast setup
- [README.md](README.md) - Detailed setup

### For Demo
- [PROJECT_SUMMARY.md](PROJECT_SUMMARY.md) - Quick reference
- [demo.sh](demo.sh) - Automated demo
- [TESTING_CHECKLIST.md](TESTING_CHECKLIST.md) - Pre-demo checks

### For Viva
- [VIVA_GUIDE.md](VIVA_GUIDE.md) - Q&A preparation
- [ARCHITECTURE.md](ARCHITECTURE.md) - Technical details
- [README.md](README.md) - Complete reference

### For Understanding
- [ARCHITECTURE.md](ARCHITECTURE.md) - System design
- [README.md](README.md) - How it works
- [app.py](app.py) - Source code

---

## 🔍 Find Information Quickly

### "How do I...?"

**...set up the project?**
→ [QUICKSTART.md](QUICKSTART.md)

**...build the container?**
→ Run `./build.sh` or see [README.md](README.md#container-operations)

**...run the application?**
→ Run `./run.sh` or see [QUICKSTART.md](QUICKSTART.md#3-step-setup)

**...prepare for demo?**
→ [PROJECT_SUMMARY.md](PROJECT_SUMMARY.md#-for-demoviva)

**...prepare for viva?**
→ [VIVA_GUIDE.md](VIVA_GUIDE.md)

**...understand the architecture?**
→ [ARCHITECTURE.md](ARCHITECTURE.md)

**...test before demo?**
→ [TESTING_CHECKLIST.md](TESTING_CHECKLIST.md)

**...add sample data?**
→ Run `python3 add_sample_data.py 10`

**...troubleshoot issues?**
→ [README.md](README.md#troubleshooting) or [TESTING_CHECKLIST.md](TESTING_CHECKLIST.md#-known-issues--workarounds)

---

## 🎯 Key Commands Reference

### Container Operations
```bash
./build.sh              # Build image
./run.sh                # Run container
./stop.sh               # Stop container
./inspect.sh            # Inspect container
./demo.sh               # Automated demo
```

### Manual Podman Commands
```bash
podman images           # List images
podman ps               # List containers
podman logs <name>      # View logs
podman stats <name>     # Resource usage
podman volume ls        # List volumes
```

### Application Access
```bash
http://localhost:5000   # Main application
http://localhost:5000/add       # Add record
http://localhost:5000/records   # View records
http://localhost:5000/visualize # Charts
http://localhost:5000/health    # Health check
```

---

## 📊 File Statistics

| Category | Count | Total Lines |
|----------|-------|-------------|
| Documentation | 7 files | ~2500 lines |
| Python Code | 2 files | ~350 lines |
| Shell Scripts | 6 files | ~400 lines |
| HTML Templates | 5 files | ~500 lines |
| Config Files | 3 files | ~50 lines |
| **Total** | **23 files** | **~3800 lines** |

---

## ✅ Pre-Demo Checklist

Quick checklist before your demo:

- [ ] Read [PROJECT_SUMMARY.md](PROJECT_SUMMARY.md)
- [ ] Read [VIVA_GUIDE.md](VIVA_GUIDE.md)
- [ ] Complete [TESTING_CHECKLIST.md](TESTING_CHECKLIST.md)
- [ ] Container builds: `./build.sh`
- [ ] Container runs: `./run.sh`
- [ ] Application accessible: http://localhost:5000
- [ ] Sample data added: `python3 add_sample_data.py 10`
- [ ] All features tested
- [ ] Demo script works: `./demo.sh`

---

## 🎓 Syllabus Mapping

This project covers all requirements from **21CSE216P – Linux and Container Technologies**:

| Requirement | Files Demonstrating |
|-------------|---------------------|
| Linux administration | build.sh, run.sh, stop.sh, inspect.sh |
| File system operations | Containerfile, volume mounting in run.sh |
| Container image creation | Containerfile, build.sh |
| Container versioning | Image tagging in build.sh |
| Container lifecycle | build.sh, run.sh, stop.sh, inspect.sh |
| Container registry | push-registry.sh |
| Process management | inspect.sh, app.py |
| Networking | Port mapping in run.sh |

---

## 🆘 Need Help?

1. **Setup issues?** → [QUICKSTART.md](QUICKSTART.md) or [README.md](README.md#troubleshooting)
2. **Demo preparation?** → [PROJECT_SUMMARY.md](PROJECT_SUMMARY.md)
3. **Viva questions?** → [VIVA_GUIDE.md](VIVA_GUIDE.md)
4. **Technical details?** → [ARCHITECTURE.md](ARCHITECTURE.md)
5. **Testing?** → [TESTING_CHECKLIST.md](TESTING_CHECKLIST.md)

---

## 🎉 You're All Set!

**Everything you need is in this project:**
- ✅ Complete working application
- ✅ Comprehensive documentation
- ✅ Automated scripts
- ✅ Demo preparation
- ✅ Viva preparation
- ✅ Testing guides

**Start with:** [QUICKSTART.md](QUICKSTART.md)  
**Prepare with:** [PROJECT_SUMMARY.md](PROJECT_SUMMARY.md) + [VIVA_GUIDE.md](VIVA_GUIDE.md)  
**Demo with:** `./demo.sh`

---

**Good luck with your project! 🍀**

---

*Smart Health Monitor - Linux and Container Technologies Project*  
*Shivaya Pandey & Tanisha Raha | Batch 3*

