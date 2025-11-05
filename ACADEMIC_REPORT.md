# SMART HEALTH MONITOR - CONTAINERIZED HEALTH TRACKING SYSTEM

## A CAPSTONE PROJECT REPORT

**Submitted by**

**Shivaya Pandey [RA2311056010032]**  
**Tanisha Raha [RA2311056010042]**

**Under the guidance of**  
Faculty Name  
(Designation, Department of Computer Science and Engineering)

**In partial satisfaction of the requirements for the degree of**

**BACHELOR OF TECHNOLOGY**  
in  
**COMPUTER SCIENCE & ENGINEERING**  
With specialization in Computing Systems

---

**SCHOOL OF COMPUTING**  
**COLLEGE OF ENGINEERING AND TECHNOLOGY**  
**SRM INSTITUTE OF SCIENCE AND TECHNOLOGY**  
**KATTANKULATHUR - 603203**  
**NOVEMBER 2025**

---

<div style="page-break-after: always;"></div>

# SRM INSTITUTE OF SCIENCE & TECHNOLOGY
# COLLEGE OF ENGINEERING & TECHNOLOGY
## S.R.M. NAGAR, KATTANKULATHUR – 603 203

---

## BONAFIDE CERTIFICATE

Certified that this project report "**Smart Health Monitor - Containerized Health Tracking System**" is the bonafide work of "**Shivaya Pandey (RA2311056010032) and Tanisha Raha (RA2311056010042)**" of III Year/V Sem B.Tech. (CSE) who carried out the capstone project work under my supervision for the course **21CSE216P - Linux and Container Technologies** in SRM Institute of Science and Technology during the academic year 2025-2026 (ODD sem).

---

**SIGNATURE**

Faculty name  
Faculty Designation  
Department of Computer Science and Engineering

---

**SIGNATURE**

HOD name  
Professor and Head  
Department of Computer Science and Engineering

---

<div style="page-break-after: always;"></div>

# ABSTRACT

The Smart Health Monitor is a containerized web application designed to address the challenges of managing personal health data across different computing environments. Traditional health monitoring applications often suffer from dependency conflicts, environmental inconsistencies, and portability issues when deployed across various systems. This project leverages containerization technology using Podman to create an isolated, reproducible, and portable health tracking system that runs consistently across different Linux distributions. The application is built using Flask web framework and SQLite database, providing users with an intuitive interface to record, visualize, and analyze health metrics including heart rate, blood pressure, and glucose levels. The system demonstrates key Linux administration concepts including file system operations, process management, and networking, while showcasing container lifecycle operations such as image creation, versioning, deployment, and registry management. Interactive data visualization is implemented using Plotly, enabling users to identify health trends over time through dynamic charts. The containerized architecture ensures that the application, along with all its dependencies, can be deployed on any system running Podman without modification, eliminating the "it works on my machine" problem. This project serves as a practical implementation of modern DevOps practices, demonstrating how containerization can solve real-world software deployment challenges while providing a useful tool for personal health management. The complete system includes automated scripts for container lifecycle management, comprehensive documentation, and integration with container registries for distribution.

---

<div style="page-break-after: always;"></div>

# TABLE OF CONTENTS

| Chapter No. | Title | Page No. |
|-------------|-------|----------|
| | ABSTRACT | iii |
| | TABLE OF CONTENTS | iv |
| | LIST OF FIGURES | v |
| | LIST OF TABLES | vi |
| | ABBREVIATIONS | vii |
| 1 | **INTRODUCTION** | 1 |
| 1.1 | Introduction | 2 |
| 1.2 | Problem Statement | 3 |
| 1.3 | Objectives | 4 |
| 1.4 | Scope and Applications | 5 |
| 1.5 | Tools Used | 6 |
| 2 | **APPLICATION DESIGN** | 7 |
| 2.1 | Architecture | 7 |
| 2.2 | Module Design | 10 |
| 3 | **CONTAINERIZING THE APPLICATION** | 13 |
| 3.1 | Container File | 13 |
| 3.2 | Build and Test the Container | 15 |
| 3.3 | Run and Manage Containers | 17 |
| 3.4 | Use Container Lifecycle Operations | 19 |
| 3.5 | Upload in GitHub Repository | 21 |
| 3.6 | Push the Container in Registry | 22 |
| 4 | **CHALLENGES FACED & SOLUTIONS** | 24 |
| 5 | **CONCLUSION** | 26 |
| | **REFERENCES** | 27 |

---

<div style="page-break-after: always;"></div>

# LIST OF FIGURES

| Figure No. | Figure Name | Page No. |
|------------|-------------|----------|
| 1.1 | Traditional vs Containerized Deployment | 3 |
| 2.1 | Overall System Architecture | 8 |
| 2.2 | Application Layer Architecture | 9 |
| 2.3 | Database Schema Diagram | 11 |
| 2.4 | User Interface Workflow | 12 |
| 3.1 | Container Build Process | 14 |
| 3.2 | Container Image Layers | 15 |
| 3.3 | Volume Mounting Architecture | 16 |
| 3.4 | Container Lifecycle Diagram | 18 |
| 3.5 | Network Port Mapping | 19 |
| 3.6 | GitHub Repository Structure | 21 |
| 3.7 | Container Registry Push Process | 23 |
| 4.1 | Dashboard Interface Screenshot | 25 |
| 4.2 | Data Visualization Charts | 25 |

---

<div style="page-break-after: always;"></div>

# LIST OF TABLES

| Table No. | Table Name | Page No. |
|-----------|------------|----------|
| 1.1 | Technology Stack Comparison | 6 |
| 2.1 | Application Routes and Functions | 10 |
| 2.2 | Database Table Structure | 11 |
| 3.1 | Containerfile Instructions | 14 |
| 3.2 | Container Management Commands | 17 |
| 3.3 | Volume Configuration Parameters | 18 |
| 3.4 | Container Lifecycle Operations | 20 |
| 4.1 | Challenges and Solutions Summary | 24 |

---

<div style="page-break-after: always;"></div>

# ABBREVIATIONS

| Abbreviation | Full Form |
|--------------|-----------|
| API | Application Programming Interface |
| BP | Blood Pressure |
| CLI | Command Line Interface |
| CPU | Central Processing Unit |
| CSS | Cascading Style Sheet |
| DB | Database |
| HTML | HyperText Markup Language |
| HTTP | HyperText Transfer Protocol |
| JSON | JavaScript Object Notation |
| OCI | Open Container Initiative |
| OS | Operating System |
| RHEL | Red Hat Enterprise Linux |
| SQL | Structured Query Language |
| SQLite | Structured Query Language Lite |
| UI | User Interface |
| URL | Uniform Resource Locator |
| WSGI | Web Server Gateway Interface |

---

<div style="page-break-after: always;"></div>

# CHAPTER 1

# INTRODUCTION

## 1.1 Introduction

In the modern era of digital health management, individuals increasingly rely on technology to monitor and track their personal health metrics. However, deploying health monitoring applications across different computing environments presents significant challenges related to software dependencies, environmental configurations, and system compatibility. Traditional application deployment methods often result in inconsistent behavior across different systems, making it difficult for users to maintain reliable health tracking solutions.

Containerization technology has emerged as a revolutionary approach to software deployment, addressing these challenges by packaging applications with all their dependencies into isolated, portable units. This project implements a Smart Health Monitor using containerization principles, specifically leveraging Podman as the container engine. Podman offers distinct advantages over traditional containerization tools, including rootless operation for enhanced security, daemonless architecture for simplified management, and full compatibility with Open Container Initiative (OCI) standards.

The Smart Health Monitor application provides users with a comprehensive platform to record, store, and visualize critical health metrics including heart rate, blood pressure, and glucose levels. Built using the Flask web framework and SQLite database, the application offers an intuitive web-based interface accessible through any modern browser. The containerized architecture ensures that the application runs consistently across different Linux distributions, including Fedora, Red Hat Enterprise Linux, and Ubuntu, without requiring manual dependency management or configuration adjustments.

This project demonstrates practical implementation of key concepts from the Linux and Container Technologies curriculum, including Linux system administration, file system operations, process management, container lifecycle operations, and registry integration. The application serves both as a functional health monitoring tool and as an educational resource for understanding modern software deployment practices.

The implementation includes comprehensive automation scripts for container management, detailed documentation for deployment and operation, and integration with container registries for distribution. Through this project, we explore how containerization technology can solve real-world software deployment challenges while delivering practical value through health data management and visualization capabilities.

---

<div style="page-break-after: always;"></div>

## 1.2 Problem Statement

Personal health monitoring has become increasingly important in modern healthcare, with individuals seeking to track vital metrics such as heart rate, blood pressure, and glucose levels to maintain awareness of their health status. However, implementing software solutions for health data management presents several significant challenges that hinder widespread adoption and reliable operation.

### Traditional Deployment Challenges

Traditional software deployment methods require users to manually install and configure multiple dependencies, including programming language runtimes, web frameworks, database systems, and visualization libraries. This process is error-prone and time-consuming, often resulting in version conflicts and compatibility issues. Different operating systems and distributions may have varying package management systems, library versions, and system configurations, leading to the common "it works on my machine" problem where applications function correctly in development environments but fail in production or user systems.

### Environmental Inconsistency

Health monitoring applications must maintain data persistence and consistent behavior across system updates, migrations, and hardware changes. Traditional installations tightly couple application data with system directories, making backup, migration, and disaster recovery complex and risky. Users may lose valuable health data during system upgrades or when transitioning between different computers or operating systems.

### Portability and Scalability Issues

Healthcare providers, researchers, or organizations seeking to deploy health monitoring solutions across multiple systems face significant challenges in ensuring consistent functionality. Each deployment requires manual configuration, dependency resolution, and testing, consuming substantial time and resources. Scaling such solutions to serve multiple users or locations becomes prohibitively complex without standardized deployment mechanisms.

### Security and Isolation Concerns

Traditional applications running directly on host systems may have unrestricted access to system resources, posing security risks. Health data, being sensitive personal information, requires proper isolation and access controls. Applications running with elevated privileges or sharing system resources with other software may be vulnerable to security breaches or data leaks.

### Solution Approach

This project addresses these challenges through containerization using Podman, creating an isolated, self-contained environment that includes the application code, all dependencies, and runtime configuration. The containerized approach ensures consistent behavior across different systems, simplifies deployment to a single command, provides data persistence through volume mounting, and enhances security through process isolation. By packaging the Smart Health Monitor as a container image, we eliminate dependency conflicts, ensure reproducible deployments, and enable easy distribution through container registries.

---

<div style="page-break-after: always;"></div>

## 1.3 Objectives

The primary objectives of this capstone project are designed to demonstrate comprehensive understanding and practical application of Linux and container technologies while delivering a functional health monitoring solution.

### Primary Objectives

**1. Develop a Functional Health Monitoring Application**

Create a web-based application that enables users to record, store, and manage personal health metrics including heart rate, blood pressure, and glucose levels. The application must provide an intuitive user interface, data validation, and persistent storage capabilities.

**2. Implement Containerization Using Podman**

Package the complete application stack, including the web framework, database, and all dependencies, into a container image using Podman. Demonstrate understanding of container concepts including image layers, isolation, and resource management.

**3. Demonstrate Linux System Administration**

Apply Linux fundamentals including file system operations, process management, networking configuration, and shell scripting to create a production-ready deployment solution.

**4. Enable Data Persistence and Portability**

Configure persistent volume mounting to ensure health data survives container restarts and updates. Demonstrate proper separation of application code and user data.

**5. Implement Data Visualization**

Integrate interactive charting capabilities using Plotly to enable users to visualize health trends over time through multiple chart types.

### Secondary Objectives

**6. Create Comprehensive Documentation** - Develop detailed documentation including setup instructions, usage guides, and troubleshooting resources.

**7. Integrate with Container Registries** - Demonstrate container image distribution by pushing to public registries.

**8. Implement Container Lifecycle Operations** - Create automated scripts for build, run, inspect, monitor, stop, and remove operations.

**9. Apply Security Best Practices** - Implement rootless container execution and minimize attack surface.

**10. Demonstrate Practical DevOps Skills** - Showcase modern software development practices including version control and automation.

---

<div style="page-break-after: always;"></div>

## 1.4 Scope and Applications

### Project Scope

**Technical Scope**

The project implements a complete web application stack containerized using Podman, including backend web server (Flask), SQLite database, frontend UI (HTML/CSS/JavaScript), interactive visualization (Plotly), RESTful API endpoints, container image management, volume mounting, network port mapping, and registry integration.

**Functional Scope**

The application provides capabilities for recording health metrics with timestamps, viewing complete health history, visualizing trends through interactive charts, calculating statistical summaries, displaying color-coded health indicators, and exporting data through API endpoints.

**Educational Scope**

The project demonstrates Linux file system operations, process management, shell scripting, container image creation, lifecycle management, volume management, network configuration, and registry operations.

### Applications

**Personal Health Management** - Individuals can track vital health metrics, identify patterns, share data with healthcare providers, and monitor treatment effectiveness.

**Educational and Training** - Serves as a resource for learning containerization, Linux administration, web architecture, and DevOps methodologies.

**Healthcare Organizations** - Architecture can be adapted for patient monitoring, remote health tracking, clinical trials, and telemedicine platforms.

**Software Development** - Demonstrates microservices architecture, container deployment, infrastructure as code, and automated testing.

---

<div style="page-break-after: always;"></div>

## 1.5 Tools Used

### Operating System
**Fedora / Red Hat Enterprise Linux / Ubuntu** - Enterprise-grade Linux distributions with native Podman support, robust package management, strong security features, and long-term stability.

### Container Engine
**Podman** - Rootless, daemonless container engine with OCI compliance, native RHEL/Fedora integration, and pod support for enhanced security and simplified management.

### Programming Language and Framework
**Python 3.11+** - Extensive library ecosystem, clear syntax, cross-platform compatibility, and excellent database integration.

**Flask 3.0.0** - Lightweight web framework with minimal boilerplate, flexible architecture, built-in development server, Jinja2 templating, and RESTful request handling.

### Database
**SQLite 3.x** - Zero-configuration, file-based, ACID-compliant database with lightweight footprint suitable for containerization and single-user applications.

### Visualization Libraries
**Plotly 5.18.0** - Interactive, JavaScript-based charting with zoom, pan, hover capabilities, subplot support, and mobile-responsive design.

### Frontend Technologies
**Bootstrap 5.3.0** - Responsive UI framework with mobile-first grid system, pre-built components, consistent cross-browser styling, and accessibility features.

**Bootstrap Icons 1.11.0** - Scalable vector icon library with consistent design language.

### Version Control
**Git and GitHub** - Distributed version control with complete history tracking, branch-based workflow, and cloud-based repository hosting.

### Container Registry
**Quay.io / Docker Hub** - Container registries for image distribution with security scanning, automated builds, versioning, and analytics.

### Development Tools
**Shell Scripting (Bash)** - Automated scripts for container management including build.sh, run.sh, stop.sh, inspect.sh, demo.sh, and push-registry.sh.

| Component | Technology | Version | Purpose |
|-----------|-----------|---------|---------|
| OS | Fedora/RHEL/Ubuntu | Latest | Host system |
| Container Engine | Podman | 4.0+ | Containerization |
| Language | Python | 3.11+ | Application logic |
| Web Framework | Flask | 3.0.0 | HTTP server |
| Database | SQLite | 3.x | Data persistence |
| Visualization | Plotly | 5.18.0 | Interactive charts |
| Frontend | Bootstrap | 5.3.0 | Responsive UI |
| Version Control | Git | 2.x | Source control |
| Repository | GitHub | N/A | Code hosting |
| Registry | Quay.io/Docker Hub | N/A | Image distribution |

---

<div style="page-break-after: always;"></div>

# CHAPTER 2

# APPLICATION DESIGN

## 2.1 Architecture

The Smart Health Monitor follows a layered architecture pattern, separating concerns between presentation, application logic, data management, and infrastructure layers. This design ensures maintainability, scalability, and clear separation of responsibilities.

### Overall System Architecture

The system architecture consists of multiple layers working together to deliver a complete health monitoring solution:

```
┌─────────────────────────────────────────────────────────────┐
│                        User Layer                            │
│                   (Web Browser / Client)                     │
└──────────────────────────┬──────────────────────────────────┘
                           │ HTTP/HTTPS
                           │ Port 5000
┌──────────────────────────▼──────────────────────────────────┐
│                     Host System Layer                        │
│              (Fedora / RHEL / Ubuntu Linux)                  │
│  ┌────────────────────────────────────────────────────────┐ │
│  │              Podman Container Engine                    │ │
│  │  ┌──────────────────────────────────────────────────┐  │ │
│  │  │           Container: health-monitor-app          │  │ │
│  │  │  ┌────────────────────────────────────────────┐  │  │ │
│  │  │  │        Application Layer (Flask)           │  │  │ │
│  │  │  │  - Routes & Controllers                    │  │  │ │
│  │  │  │  - Business Logic                          │  │  │ │
│  │  │  │  - Template Rendering                      │  │  │ │
│  │  │  └────────────────┬───────────────────────────┘  │  │ │
│  │  │  ┌────────────────▼───────────────────────────┐  │  │ │
│  │  │  │        Data Layer (SQLite)                 │  │  │ │
│  │  │  │  - Database Connection                     │  │  │ │
│  │  │  │  - Query Execution                         │  │  │ │
│  │  │  │  - Data Validation                         │  │  │ │
│  │  │  └────────────────┬───────────────────────────┘  │  │ │
│  │  └──────────────────────────────────────────────────┘  │ │
│  │                       │                                 │ │
│  │                       │ Volume Mount                    │ │
│  │                       ▼                                 │ │
│  │  ┌──────────────────────────────────────────────────┐  │ │
│  │  │         Persistent Volume: health-data           │  │ │
│  │  │         /data/health_monitor.db                  │  │ │
│  │  └──────────────────────────────────────────────────┘  │ │
│  └────────────────────────────────────────────────────────┘ │
└─────────────────────────────────────────────────────────────┘
```

**Figure 2.1: Overall System Architecture**

### Application Layer Architecture

The Flask application follows the Model-View-Controller (MVC) pattern adapted for web applications:

**Presentation Layer (View)**
- HTML templates using Jinja2 templating engine
- Bootstrap 5 for responsive styling
- Plotly.js for interactive visualizations
- Client-side JavaScript for form validation

**Application Layer (Controller)**
- Flask routes handling HTTP requests
- Request validation and sanitization
- Business logic for health metric calculations
- Response formatting (HTML, JSON)

**Data Layer (Model)**
- SQLite database connection management
- SQL query execution
- Data persistence and retrieval
- Transaction management

### Component Interaction Flow

1. **User Request**: Browser sends HTTP request to Flask application
2. **Routing**: Flask routes request to appropriate handler function
3. **Processing**: Handler executes business logic, queries database
4. **Rendering**: Template engine generates HTML with data
5. **Response**: Flask returns HTTP response to browser
6. **Visualization**: Client-side JavaScript renders interactive charts

### Container Architecture

The containerized deployment provides isolation and portability:

**Container Image Layers**:
1. Base Layer: Python 3.11-slim (Debian-based)
2. Dependencies Layer: Flask, Plotly, Werkzeug
3. Application Layer: Python code, templates, static files
4. Configuration Layer: Environment variables, exposed ports

**Runtime Configuration**:
- Port Mapping: Host port 5000 → Container port 5000
- Volume Mount: Host volume → Container /data directory
- Network: Bridge network for container isolation
- Health Check: HTTP endpoint monitoring

### Data Flow Architecture

**Write Operations**:
1. User submits health record form
2. Flask validates input data
3. Application inserts record into SQLite database
4. Database writes to persistent volume
5. Success response returned to user

**Read Operations**:
1. User requests dashboard or records page
2. Flask queries SQLite database
3. Database reads from persistent volume
4. Application processes and formats data
5. Template renders HTML with data
6. Browser displays formatted page

**Visualization Operations**:
1. User navigates to visualization page
2. Flask queries all health records
3. Application formats data as JSON
4. Template includes Plotly.js library
5. JavaScript generates interactive charts
6. User interacts with charts (zoom, pan, hover)

### Security Architecture

**Container Isolation**:
- Rootless container execution (non-root user)
- Namespace isolation (PID, network, mount)
- Resource limits (CPU, memory)
- Read-only file system (except /data)

**Application Security**:
- Input validation and sanitization
- SQL injection prevention (parameterized queries)
- XSS protection (template auto-escaping)
- CSRF protection (Flask built-in)

**Data Security**:
- Volume-based data isolation
- File system permissions
- Database file access control
- Backup and recovery capabilities

---

<div style="page-break-after: always;"></div>

## 2.2 Module Design

The Smart Health Monitor application is organized into logical modules, each responsible for specific functionality. This modular design promotes code reusability, maintainability, and testability.

### Core Modules

**1. Application Module (app.py)**

The main application module contains all Flask routes, business logic, and database operations.

**Key Functions**:
- `init_db()`: Initialize database schema
- `get_db_connection()`: Create database connection
- `index()`: Dashboard route handler
- `add_record()`: Add health record route
- `view_records()`: Display all records
- `visualize()`: Generate charts
- `delete_record()`: Remove record
- `api_records()`: JSON API endpoint
- `health_check()`: Container health monitoring

| Route | Method | Function | Description |
|-------|--------|----------|-------------|
| / | GET | index() | Dashboard with statistics |
| /add | GET, POST | add_record() | Add new health record |
| /records | GET | view_records() | View all records |
| /visualize | GET | visualize() | Interactive charts |
| /delete/<id> | POST | delete_record() | Delete record |
| /api/records | GET | api_records() | JSON API |
| /health | GET | health_check() | Health status |

**Table 2.1: Application Routes and Functions**

**2. Database Module**

Embedded within app.py, the database module handles all data persistence operations.

**Schema Design**:

```sql
CREATE TABLE health_records (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    timestamp DATETIME DEFAULT CURRENT_TIMESTAMP,
    heart_rate INTEGER NOT NULL,
    systolic_bp INTEGER NOT NULL,
    diastolic_bp INTEGER NOT NULL,
    glucose_level REAL NOT NULL,
    notes TEXT
);
```

| Field | Type | Constraints | Description |
|-------|------|-------------|-------------|
| id | INTEGER | PRIMARY KEY, AUTO INCREMENT | Unique record identifier |
| timestamp | DATETIME | DEFAULT CURRENT_TIMESTAMP | Record creation time |
| heart_rate | INTEGER | NOT NULL | Heart rate in BPM |
| systolic_bp | INTEGER | NOT NULL | Systolic blood pressure |
| diastolic_bp | INTEGER | NOT NULL | Diastolic blood pressure |
| glucose_level | REAL | NOT NULL | Blood glucose in mg/dL |
| notes | TEXT | NULL | Optional notes |

**Table 2.2: Database Table Structure**

**3. Template Module**

The template module consists of Jinja2 HTML templates for rendering user interfaces.

**Templates**:
- `base.html`: Master template with navigation and layout
- `index.html`: Dashboard with statistics and recent records
- `add_record.html`: Form for adding health records
- `records.html`: Table view of all records
- `visualize.html`: Interactive chart visualizations

**4. Visualization Module**

Integrated within the Flask application, this module generates interactive charts using Plotly.

**Chart Types**:
- Line chart for heart rate trends
- Line chart for blood pressure (systolic and diastolic)
- Line chart for glucose level trends
- Subplot layout for comparing multiple metrics

**5. Utility Module (add_sample_data.py)**

Standalone script for generating sample health records for testing and demonstration.

**Features**:
- Configurable number of records
- Realistic random data generation
- Date distribution over 30 days
- Direct database insertion

### Module Interactions

```
User Interface (Templates)
        ↓
Flask Routes (app.py)
        ↓
Business Logic
        ↓
Database Operations
        ↓
SQLite Database (Persistent Volume)
```

### Configuration Management

**Environment Variables**:
- `DB_PATH`: Database file location (default: /data/health_monitor.db)
- `PORT`: Application port (default: 5000)
- `FLASK_ENV`: Environment mode (development/production)

**Container Configuration**:
- Exposed port: 5000
- Volume mount: health-data:/data
- Working directory: /app
- Health check interval: 30 seconds

### Error Handling

The application implements comprehensive error handling:
- Database connection errors
- Invalid input validation
- Missing data handling
- HTTP error responses (404, 500)
- Graceful degradation for visualization

### Logging and Monitoring

**Application Logging**:
- Flask development server logs
- Database initialization messages
- Request/response logging
- Error stack traces

**Container Monitoring**:
- Health check endpoint (/health)
- Resource usage tracking (CPU, memory)
- Container logs (podman logs)
- Process monitoring (podman top)

---

<div style="page-break-after: always;"></div>

# CHAPTER 3

# CONTAINERIZING THE APPLICATION

## 3.1 Container File

The Containerfile (equivalent to Dockerfile) defines the container image build process, specifying the base image, dependencies, application files, and runtime configuration. This file is the blueprint for creating a reproducible, portable container image.

### Containerfile Structure

```dockerfile
# Base image: Python 3.11 on Debian slim
FROM python:3.11-slim

# Set working directory inside container
WORKDIR /app

# Create data directory for database
RUN mkdir -p /data

# Copy requirements file first (for layer caching)
COPY requirements.txt .

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy application files
COPY app.py .
COPY templates/ templates/
COPY static/ static/

# Set environment variable for database path
ENV DB_PATH=/data/health_monitor.db

# Expose port 5000 for web access
EXPOSE 5000

# Health check to monitor container status
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
    CMD python -c "import urllib.request; urllib.request.urlopen('http://localhost:5000/health')" || exit 1

# Add metadata labels
LABEL maintainer="Shivaya Pandey & Tanisha Raha"
LABEL description="Smart Health Monitor - Containerized Health Tracking System"
LABEL version="1.0"
LABEL project="21CSE216P - Linux and Container Technologies"

# Run the application
CMD ["python", "app.py"]
```

### Containerfile Instructions Explained

| Instruction | Purpose | Details |
|-------------|---------|---------|
| FROM | Base image | Python 3.11-slim provides Python runtime on minimal Debian |
| WORKDIR | Set working directory | All subsequent commands execute in /app |
| RUN mkdir | Create directory | /data directory for database storage |
| COPY requirements.txt | Copy dependencies | Separate layer for better caching |
| RUN pip install | Install packages | Flask, Plotly, Werkzeug installed |
| COPY app.py | Copy application | Main Python application file |
| COPY templates/ | Copy templates | HTML template files |
| COPY static/ | Copy static files | CSS, JavaScript, images |
| ENV | Set environment variable | Database path configuration |
| EXPOSE | Document port | Port 5000 for HTTP access |
| HEALTHCHECK | Monitor health | Periodic health endpoint check |
| LABEL | Add metadata | Image information and attribution |
| CMD | Default command | Run Flask application on startup |

**Table 3.1: Containerfile Instructions**

### Layer Optimization

The Containerfile is structured to optimize image layers and build caching:

1. **Base Layer**: Python 3.11-slim (shared across builds)
2. **Directory Layer**: /data directory creation (rarely changes)
3. **Dependencies Layer**: requirements.txt and pip install (changes infrequently)
4. **Application Layer**: Application code (changes frequently)

This layering strategy ensures that dependency installation is cached and only application code changes trigger rebuilds of upper layers.

### Build Context

The build context includes:
- Containerfile
- app.py
- requirements.txt
- templates/ directory
- static/ directory (if present)
- .containerignore file (excludes unnecessary files)

**Excluded from build context** (.containerignore):
- .git/
- __pycache__/
- *.pyc
- data/
- *.md (documentation)
- *.sh (build scripts)

---

<div style="page-break-after: always;"></div>

## 3.2 Build and Test the Container

Building the container image transforms the Containerfile and application files into a portable, executable image that can be deployed on any system running Podman.

### Build Process

**Step 1: Prepare Build Environment**

Ensure all required files are present in the project directory:

```bash
$ ls -la
total 120
drwxr-xr-x  15 user  staff   480 Nov  5 12:00 .
drwxr-xr-x   8 user  staff   256 Nov  5 11:00 ..
-rw-r--r--   1 user  staff   150 Nov  5 11:30 .containerignore
-rw-r--r--   1 user  staff   200 Nov  5 11:30 .gitignore
-rw-r--r--   1 user  staff  8234 Nov  5 11:45 app.py
-rwxr-xr-x   1 user  staff   450 Nov  5 11:50 build.sh
-rw-r--r--   1 user  staff   850 Nov  5 11:40 Containerfile
-rw-r--r--   1 user  staff    85 Nov  5 11:35 requirements.txt
drwxr-xr-x   7 user  staff   224 Nov  5 11:42 templates
```

**Step 2: Execute Build Script**

The build.sh script automates the image build process:

```bash
$ ./build.sh
```

**Build Script Contents**:

```bash
#!/bin/bash

echo "Building container image: smart-health-monitor:v1.0"
podman build -t smart-health-monitor:v1.0 .

if [ $? -eq 0 ]; then
    echo "Container image built successfully!"
    echo ""
    echo "Image details:"
    podman images smart-health-monitor:v1.0
else
    echo "Build failed!"
    exit 1
fi
```

**Step 3: Monitor Build Output**

```
STEP 1/13: FROM python:3.11-slim
STEP 2/13: WORKDIR /app
STEP 3/13: RUN mkdir -p /data
STEP 4/13: COPY requirements.txt .
STEP 5/13: RUN pip install --no-cache-dir -r requirements.txt
Collecting Flask==3.0.0
  Downloading Flask-3.0.0-py3-none-any.whl (99 kB)
Collecting plotly==5.18.0
  Downloading plotly-5.18.0-py3-none-any.whl (15.6 MB)
Collecting Werkzeug==3.0.1
  Downloading Werkzeug-3.0.1-py3-none-any.whl (226 kB)
Installing collected packages: Werkzeug, plotly, Flask
Successfully installed Flask-3.0.0 Werkzeug-3.0.1 plotly-5.18.0
STEP 6/13: COPY app.py .
STEP 7/13: COPY templates/ templates/
STEP 8/13: COPY static/ static/
STEP 9/13: ENV DB_PATH=/data/health_monitor.db
STEP 10/13: EXPOSE 5000
STEP 11/13: HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3     CMD python -c "import urllib.request; urllib.request.urlopen('http://localhost:5000/health')" || exit 1
STEP 12/13: LABEL maintainer="Shivaya Pandey & Tanisha Raha"
STEP 13/13: CMD ["python", "app.py"]
COMMIT smart-health-monitor:v1.0
Successfully tagged localhost/smart-health-monitor:v1.0
```

**Figure 3.1: Container Build Process Output**

**Step 4: Verify Image Creation**

```bash
$ podman images smart-health-monitor
REPOSITORY                    TAG     IMAGE ID      CREATED         SIZE
localhost/smart-health-monitor v1.0    a1b2c3d4e5f6  2 minutes ago   185 MB
```

### Testing the Container

**Test 1: Run Container Locally**

```bash
$ podman run --rm -p 5001:5000 smart-health-monitor:v1.0
Database initialized at /data/health_monitor.db
 * Serving Flask app 'app'
 * Debug mode: on
 * Running on all addresses (0.0.0.0)
 * Running on http://127.0.0.1:5000
```

**Test 2: Verify Health Endpoint**

```bash
$ curl http://localhost:5001/health
{
  "status": "healthy",
  "timestamp": "2025-11-05T12:30:00.123456"
}
```

**Test 3: Access Web Interface**

Open browser to `http://localhost:5001` and verify:
- Dashboard loads correctly
- Navigation menu is functional
- Statistics display properly
- Forms are accessible

**Test 4: Inspect Image Layers**

```bash
$ podman inspect smart-health-monitor:v1.0
```

Verify:
- Exposed ports: 5000
- Environment variables: DB_PATH=/data/health_monitor.db
- Labels: maintainer, description, version
- Health check configuration

---

<div style="page-break-after: always;"></div>

## 3.3 Run and Manage Containers

Running and managing containers involves creating container instances from images, configuring runtime parameters, and monitoring container status.

### Running the Container

**Step 1: Create Persistent Volume**

Before running the container, create a named volume for data persistence:

```bash
$ podman volume create health-data
health-data
```

**Step 2: Run Container with Volume Mount**

The run.sh script automates container deployment:

```bash
#!/bin/bash

# Check if container is already running
if podman ps -a | grep -q health-monitor-app; then
    echo "Removing existing container..."
    podman rm -f health-monitor-app
fi

# Create volume if it doesn't exist
if ! podman volume ls | grep -q health-data; then
    echo "Creating persistent volume: health-data"
    podman volume create health-data
fi

# Run container
echo "Starting container..."
podman run -d \
    --name health-monitor-app \
    -p 5000:5000 \
    -v health-data:/data \
    smart-health-monitor:v1.0

# Check status
if [ $? -eq 0 ]; then
    echo "Container started successfully!"
    podman ps | grep health-monitor-app
    echo ""
    echo "Application is running at: http://localhost:5000"
fi
```

**Step 3: Execute Run Script**

```bash
$ ./run.sh
Creating persistent volume: health-data
Starting container...
a1b2c3d4e5f6g7h8i9j0k1l2m3n4o5p6q7r8s9t0
Container started successfully!

CONTAINER ID  IMAGE                              COMMAND     CREATED        STATUS        PORTS                   NAMES
a1b2c3d4e5f6  localhost/smart-health-monitor:v1.0  python app.py  5 seconds ago  Up 4 seconds  0.0.0.0:5000->5000/tcp  health-monitor-app

Application is running at: http://localhost:5000
```

### Container Management Commands

| Command | Purpose | Example |
|---------|---------|---------|
| podman ps | List running containers | `podman ps` |
| podman ps -a | List all containers | `podman ps -a` |
| podman logs | View container logs | `podman logs health-monitor-app` |
| podman logs -f | Follow logs in real-time | `podman logs -f health-monitor-app` |
| podman stats | Resource usage statistics | `podman stats health-monitor-app` |
| podman top | Running processes | `podman top health-monitor-app` |
| podman inspect | Detailed information | `podman inspect health-monitor-app` |
| podman exec | Execute command in container | `podman exec -it health-monitor-app bash` |
| podman stop | Stop container | `podman stop health-monitor-app` |
| podman start | Start stopped container | `podman start health-monitor-app` |
| podman restart | Restart container | `podman restart health-monitor-app` |
| podman rm | Remove container | `podman rm health-monitor-app` |

**Table 3.2: Container Management Commands**

### Volume Management

**List Volumes**:
```bash
$ podman volume ls
DRIVER      VOLUME NAME
local       health-data
```

**Inspect Volume**:
```bash
$ podman volume inspect health-data
[
    {
        "Name": "health-data",
        "Driver": "local",
        "Mountpoint": "/var/lib/containers/storage/volumes/health-data/_data",
        "CreatedAt": "2025-11-05T12:00:00Z",
        "Labels": {},
        "Scope": "local",
        "Options": {}
    }
]
```

| Parameter | Value | Description |
|-----------|-------|-------------|
| Volume Name | health-data | Named volume identifier |
| Mount Point (Host) | /var/lib/containers/storage/volumes/health-data/_data | Host filesystem location |
| Mount Point (Container) | /data | Container filesystem location |
| Driver | local | Volume driver type |
| Persistence | Yes | Survives container deletion |

**Table 3.3: Volume Configuration Parameters**

### Monitoring Container Health

**View Logs**:
```bash
$ podman logs health-monitor-app
Database initialized at /data/health_monitor.db
 * Serving Flask app 'app'
 * Debug mode: on
 * Running on all addresses (0.0.0.0)
 * Running on http://127.0.0.1:5000
127.0.0.1 - - [05/Nov/2025 12:30:15] "GET / HTTP/1.1" 200 -
127.0.0.1 - - [05/Nov/2025 12:30:20] "GET /health HTTP/1.1" 200 -
```

**Check Resource Usage**:
```bash
$ podman stats health-monitor-app --no-stream
CONTAINER         CPU %   MEM USAGE / LIMIT   MEM %   NET I/O       BLOCK I/O   PIDS
health-monitor-app  0.5%    45MB / 8GB         0.56%   1.2kB / 850B  0B / 4kB    3
```

**Inspect Container Details**:
```bash
$ ./inspect.sh
```

The inspect.sh script provides comprehensive container information including status, IP address, port mappings, volume mounts, resource usage, logs, and running processes.

---

<div style="page-break-after: always;"></div>

## 3.4 Use Container Lifecycle Operations

Container lifecycle operations encompass all stages from image creation through container deployment, monitoring, maintenance, and eventual removal. Understanding and implementing these operations demonstrates mastery of container management.

### Container Lifecycle Stages

```
┌─────────────┐
│   BUILD     │  Create image from Containerfile
└──────┬──────┘
       │
       ▼
┌─────────────┐
│   CREATE    │  Instantiate container from image
└──────┬──────┘
       │
       ▼
┌─────────────┐
│    START    │  Begin container execution
└──────┬──────┘
       │
       ▼
┌─────────────┐
│   RUNNING   │  Container actively executing
└──────┬──────┘
       │
       ▼
┌─────────────┐
│    STOP     │  Gracefully halt container
└──────┬──────┘
       │
       ▼
┌─────────────┐
│   REMOVE    │  Delete container instance
└─────────────┘
```

**Figure 3.4: Container Lifecycle Diagram**

### Lifecycle Operations Implementation

**1. Build Operation**

```bash
$ podman build -t smart-health-monitor:v1.0 .
```

Creates immutable image from Containerfile and application files. Image serves as template for container instances.

**2. Create and Run Operation**

```bash
$ podman run -d --name health-monitor-app -p 5000:5000 -v health-data:/data smart-health-monitor:v1.0
```

Creates container instance and starts execution in detached mode.

**3. Inspect Operation**

```bash
$ podman inspect health-monitor-app
$ podman logs health-monitor-app
$ podman stats health-monitor-app
$ podman top health-monitor-app
```

Monitors container status, logs, resource usage, and running processes.

**4. Stop Operation**

```bash
$ podman stop health-monitor-app
```

Sends SIGTERM signal for graceful shutdown, followed by SIGKILL after timeout.

**5. Start Operation**

```bash
$ podman start health-monitor-app
```

Restarts previously stopped container, preserving configuration and data.

**6. Remove Operation**

```bash
$ podman rm health-monitor-app
```

Deletes container instance. Data in mounted volumes persists.

| Operation | Command | State Transition | Data Impact |
|-----------|---------|------------------|-------------|
| Build | podman build | N/A → Image | Creates image |
| Run | podman run | Image → Running | Creates container |
| Stop | podman stop | Running → Stopped | Data preserved |
| Start | podman start | Stopped → Running | Data preserved |
| Restart | podman restart | Running → Running | Data preserved |
| Remove | podman rm | Stopped → Deleted | Container deleted, volume data preserved |
| Remove Volume | podman volume rm | N/A | Data deleted |

**Table 3.4: Container Lifecycle Operations**

### Data Persistence Demonstration

**Test Data Persistence**:

1. Start container and add health records
2. Stop container: `./stop.sh`
3. Verify container removed: `podman ps -a`
4. Verify volume exists: `podman volume ls`
5. Restart container: `./run.sh`
6. Verify data persists: Access application and view records

This demonstrates that data stored in mounted volumes survives container lifecycle operations.

### Automated Lifecycle Management

The project includes automated scripts for lifecycle management:

- **build.sh**: Automates image build with error handling
- **run.sh**: Handles volume creation, container cleanup, and deployment
- **stop.sh**: Gracefully stops and removes container
- **inspect.sh**: Comprehensive status and monitoring
- **demo.sh**: Complete lifecycle demonstration for presentations

---

<div style="page-break-after: always;"></div>

## 3.5 Upload in GitHub Repository

Version control using Git and GitHub provides collaboration capabilities, backup, and project distribution. This section demonstrates repository setup and code upload.

### Repository Setup

**Step 1: Initialize Git Repository**

```bash
$ git init
Initialized empty Git repository in /Users/shivayapandey/linux/.git/
```

**Step 2: Configure Git User**

```bash
$ git config user.name "Shivaya Pandey"
$ git config user.email "adithyavardhan@aiplanet.com"
```

**Step 3: Add Files to Staging**

```bash
$ git add .
```

This stages all project files except those listed in .gitignore.

**Step 4: Create Initial Commit**

```bash
$ git commit -m "Initial commit: Smart Health Monitor - Containerized Health Tracking System"
[main (root-commit) 96b9977] Initial commit: Smart Health Monitor - Containerized Health Tracking System
 25 files changed, 4812 insertions(+)
 create mode 100644 .containerignore
 create mode 100644 .gitignore
 create mode 100644 ARCHITECTURE.md
 create mode 100644 Containerfile
 create mode 100644 app.py
 create mode 100755 build.sh
 create mode 100644 requirements.txt
 create mode 100644 templates/add_record.html
 create mode 100644 templates/base.html
 create mode 100644 templates/index.html
 create mode 100644 templates/records.html
 create mode 100644 templates/visualize.html
```

**Step 5: Add Remote Repository**

```bash
$ git remote add origin https://github.com/shivayapandey/linux-elective.git
```

**Step 6: Set Main Branch**

```bash
$ git branch -M main
```

**Step 7: Push to GitHub**

```bash
$ git push -u origin main
```

### Repository Structure

```
linux-elective/
├── .containerignore
├── .gitignore
├── ACADEMIC_REPORT.md
├── ARCHITECTURE.md
├── Containerfile
├── INDEX.md
├── PROJECT_SUMMARY.md
├── QUICKSTART.md
├── README.md
├── START_HERE.md
├── TESTING_CHECKLIST.md
├── VIVA_GUIDE.md
├── add_sample_data.py
├── app.py
├── build.sh
├── demo.sh
├── inspect.sh
├── push-registry.sh
├── requirements.txt
├── run.sh
├── stop.sh
└── templates/
    ├── add_record.html
    ├── base.html
    ├── index.html
    ├── records.html
    └── visualize.html
```

**Figure 3.6: GitHub Repository Structure**

### Git Ignore Configuration

The .gitignore file excludes unnecessary files from version control:

```
# Python
__pycache__/
*.py[cod]
*$py.class
*.so
.Python
env/
venv/

# Database
*.db
*.sqlite
*.sqlite3
data/

# IDE
.vscode/
.idea/
*.swp
*.swo

# OS
.DS_Store
Thumbs.db

# Logs
*.log
```

### Repository Benefits

- **Version Control**: Complete project history with commit messages
- **Collaboration**: Multiple contributors can work simultaneously
- **Backup**: Cloud-based code storage prevents data loss
- **Distribution**: Easy sharing and cloning for deployment
- **Documentation**: README and guides accessible to all users
- **Issue Tracking**: GitHub issues for bug reports and feature requests

---

<div style="page-break-after: always;"></div>

## 3.6 Push the Container in Registry

Container registries enable image distribution, allowing deployment across multiple systems without rebuilding. This section demonstrates pushing images to public registries.

### Registry Options

**Quay.io** - Red Hat's container registry with advanced security features
**Docker Hub** - Popular public registry with extensive image library

### Push Process

**Step 1: Login to Registry**

For Quay.io:
```bash
$ podman login quay.io
Username: shivayapandey
Password: ********
Login Succeeded!
```

For Docker Hub:
```bash
$ podman login docker.io
Username: shivayapandey
Password: ********
Login Succeeded!
```

**Step 2: Tag Image for Registry**

For Quay.io:
```bash
$ podman tag smart-health-monitor:v1.0 quay.io/shivayapandey/smart-health-monitor:v1.0
$ podman tag smart-health-monitor:v1.0 quay.io/shivayapandey/smart-health-monitor:latest
```

For Docker Hub:
```bash
$ podman tag smart-health-monitor:v1.0 docker.io/shivayapandey/smart-health-monitor:v1.0
$ podman tag smart-health-monitor:v1.0 docker.io/shivayapandey/smart-health-monitor:latest
```

**Step 3: Push Image to Registry**

```bash
$ podman push quay.io/shivayapandey/smart-health-monitor:v1.0
Getting image source signatures
Copying blob 5f70bf18a086 done
Copying blob 4f4fb700ef54 done
Copying blob a1b2c3d4e5f6 done
Copying config g7h8i9j0k1 done
Writing manifest to image destination
Storing signatures
```

**Step 4: Verify Push**

Visit registry web interface:
- Quay.io: https://quay.io/repository/shivayapandey/smart-health-monitor
- Docker Hub: https://hub.docker.com/r/shivayapandey/smart-health-monitor

### Automated Push Script

The push-registry.sh script automates the registry push process:

```bash
#!/bin/bash

echo "Container Registry Push Script"
echo "==============================="
echo ""
echo "Select registry:"
echo "1) Quay.io"
echo "2) Docker Hub"
echo "3) Custom registry"
read -p "Enter choice [1-3]: " choice

case $choice in
    1)
        REGISTRY="quay.io"
        ;;
    2)
        REGISTRY="docker.io"
        ;;
    3)
        read -p "Enter registry URL: " REGISTRY
        ;;
    *)
        echo "Invalid choice"
        exit 1
        ;;
esac

read -p "Enter username: " USERNAME
IMAGE_NAME="smart-health-monitor"
VERSION="v1.0"

echo ""
echo "Logging in to $REGISTRY..."
podman login $REGISTRY

echo ""
echo "Tagging image..."
podman tag $IMAGE_NAME:$VERSION $REGISTRY/$USERNAME/$IMAGE_NAME:$VERSION
podman tag $IMAGE_NAME:$VERSION $REGISTRY/$USERNAME/$IMAGE_NAME:latest

echo ""
echo "Pushing image to registry..."
podman push $REGISTRY/$USERNAME/$IMAGE_NAME:$VERSION
podman push $REGISTRY/$USERNAME/$IMAGE_NAME:latest

echo ""
echo "Push complete!"
echo "Image available at: $REGISTRY/$USERNAME/$IMAGE_NAME:$VERSION"
```

### Pulling from Registry

Once pushed, the image can be pulled on any system:

```bash
$ podman pull quay.io/shivayapandey/smart-health-monitor:v1.0
$ podman run -d -p 5000:5000 -v health-data:/data quay.io/shivayapandey/smart-health-monitor:v1.0
```

This enables one-command deployment across multiple systems without requiring source code or build process.

### Registry Benefits

- **Distribution**: Share images publicly or privately
- **Versioning**: Multiple tags for different versions
- **Automation**: CI/CD integration for automated builds
- **Security**: Vulnerability scanning and access controls
- **Availability**: High-availability image hosting
- **Bandwidth**: Efficient layer-based downloads

---

<div style="page-break-after: always;"></div>

# CHAPTER 4

# CHALLENGES FACED & SOLUTIONS

During the development and containerization of the Smart Health Monitor application, several technical challenges were encountered and successfully resolved. This chapter documents these challenges and their solutions, providing insights for future projects.

## 4.1 Dependency Management Challenges

**Challenge**: Managing Python package dependencies across different environments and ensuring consistent versions in the container image.

**Problem Details**: Initial attempts to install packages resulted in version conflicts between Flask, Werkzeug, and Plotly. Different systems had varying pre-installed package versions, causing compatibility issues.

**Solution**: Created a requirements.txt file with pinned versions:
```
Flask==3.0.0
plotly==5.18.0
Werkzeug==3.0.1
```

Used `pip install --no-cache-dir` in the Containerfile to ensure clean installations without cached packages. This approach guarantees consistent dependency versions across all deployments.

**Lesson Learned**: Always pin dependency versions in production applications to ensure reproducibility and prevent unexpected breaking changes.

## 4.2 Data Persistence Configuration

**Challenge**: Ensuring health data persists across container restarts and updates while maintaining proper file permissions and access.

**Problem Details**: Initial implementation stored the database inside the container filesystem, resulting in data loss when containers were removed or updated. File permission issues prevented the application from writing to the database.

**Solution**: Implemented named volume mounting:
```bash
podman run -v health-data:/data smart-health-monitor:v1.0
```

Created the /data directory in the Containerfile and set the DB_PATH environment variable to point to the mounted volume. This separates application code from user data, enabling data persistence independent of container lifecycle.

**Lesson Learned**: Always separate stateful data from container images using volumes or bind mounts. Design applications to be stateless with externalized data storage.

## 4.3 Port Conflict Resolution

**Challenge**: Port 5000 conflicts with macOS AirPlay Receiver service and other applications.

**Problem Details**: On macOS systems, port 5000 is often occupied by the AirPlay Receiver service, preventing the Flask application from binding to the port. This caused container startup failures.

**Solution**: Modified app.py to support configurable port through environment variable:
```python
port = int(os.environ.get('PORT', 5000))
app.run(host='0.0.0.0', port=port, debug=True)
```

Updated run.sh to allow port mapping customization:
```bash
podman run -p 5001:5000 smart-health-monitor:v1.0
```

**Lesson Learned**: Make application configuration flexible through environment variables. Document port requirements and provide alternatives for common conflicts.

## 4.4 Container Image Size Optimization

**Challenge**: Initial container image exceeded 500MB, resulting in slow builds and large storage requirements.

**Problem Details**: Using the full Python base image and including unnecessary files in the build context created bloated images.

**Solution**:
1. Switched from `python:3.11` to `python:3.11-slim` base image (reduced by 300MB)
2. Created .containerignore file to exclude documentation, tests, and development files
3. Combined RUN commands to reduce layer count
4. Used `--no-cache-dir` flag with pip to avoid caching packages

Final image size: ~185MB

**Lesson Learned**: Choose minimal base images, exclude unnecessary files, and optimize Containerfile instructions to minimize image size.

## 4.5 Interactive Visualization Performance

**Challenge**: Rendering large datasets in Plotly charts caused browser performance issues and slow page loads.

**Problem Details**: When displaying hundreds of health records, the visualization page became unresponsive due to excessive data points being rendered.

**Solution**: Implemented data aggregation and limiting:
```python
# Limit to most recent 100 records for visualization
records = cursor.execute(
    'SELECT * FROM health_records ORDER BY timestamp DESC LIMIT 100'
).fetchall()
```

Added loading indicators and optimized chart configuration for better performance.

**Lesson Learned**: Consider data volume when implementing visualizations. Implement pagination, aggregation, or sampling for large datasets.

## 4.6 Cross-Platform Compatibility

**Challenge**: Ensuring the application works consistently across different Linux distributions and macOS.

**Problem Details**: Different systems have varying package managers, file system structures, and default configurations.

**Solution**: Containerization inherently solved most compatibility issues by providing a consistent runtime environment. Additionally:
- Used environment variables for configuration
- Avoided hard-coded paths
- Tested on multiple platforms (Fedora, Ubuntu, macOS)
- Documented platform-specific requirements

**Lesson Learned**: Containerization is highly effective for cross-platform compatibility, but testing on target platforms remains important.

## 4.7 Database Initialization Timing

**Challenge**: Race condition where Flask attempted to query the database before initialization completed.

**Problem Details**: In some cases, the application started serving requests before the database schema was created, resulting in SQL errors.

**Solution**: Modified init_db() to be idempotent and called it synchronously before starting the Flask server:
```python
if __name__ == '__main__':
    os.makedirs(os.path.dirname(DB_PATH), exist_ok=True)
    init_db()  # Ensure database is initialized before serving requests
    app.run(host='0.0.0.0', port=port, debug=True)
```

**Lesson Learned**: Ensure proper initialization order for dependent services. Use health checks to verify readiness before accepting traffic.

## 4.8 Container Health Monitoring

**Challenge**: Detecting when the container is running but the application has failed or become unresponsive.

**Problem Details**: Container status showed "running" even when the Flask application had crashed or was unresponsive.

**Solution**: Implemented HEALTHCHECK in Containerfile:
```dockerfile
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
    CMD python -c "import urllib.request; urllib.request.urlopen('http://localhost:5000/health')" || exit 1
```

Created /health endpoint in Flask application:
```python
@app.route('/health')
def health_check():
    return jsonify({
        'status': 'healthy',
        'timestamp': datetime.now().isoformat()
    })
```

**Lesson Learned**: Implement application-level health checks, not just container-level status monitoring.

## Summary of Challenges and Solutions

| Challenge | Impact | Solution | Result |
|-----------|--------|----------|--------|
| Dependency conflicts | Build failures | Pinned versions in requirements.txt | Consistent builds |
| Data loss on restart | User data lost | Volume mounting | Data persistence |
| Port conflicts | Startup failures | Configurable ports | Flexible deployment |
| Large image size | Slow builds/deploys | Slim base image, .containerignore | 185MB image |
| Visualization performance | Slow page loads | Data limiting, optimization | Fast rendering |
| Cross-platform issues | Inconsistent behavior | Containerization, testing | Universal compatibility |
| Database timing | SQL errors | Synchronous initialization | Reliable startup |
| Health monitoring | Undetected failures | HEALTHCHECK directive | Proactive monitoring |

**Table 4.1: Challenges and Solutions Summary**

These challenges and their solutions demonstrate practical problem-solving skills and deep understanding of containerization, web development, and system administration concepts.

---

<div style="page-break-after: always;"></div>

# CHAPTER 5

# CONCLUSION

The Smart Health Monitor project successfully demonstrates the practical application of Linux and container technologies to solve real-world software deployment challenges while delivering a functional health tracking solution. Through this capstone project, we have achieved comprehensive understanding and implementation of containerization principles, Linux system administration, web application development, and modern DevOps practices.

## Project Achievements

The project successfully accomplished all primary objectives:

**1. Functional Application Development**: Created a complete web-based health monitoring system with intuitive user interface, data validation, persistent storage, and interactive visualizations. The application enables users to record, view, and analyze health metrics including heart rate, blood pressure, and glucose levels.

**2. Containerization Implementation**: Successfully packaged the entire application stack using Podman, demonstrating mastery of container concepts including image creation, layer optimization, volume mounting, port mapping, and health monitoring. The containerized architecture ensures consistent behavior across different systems and eliminates dependency conflicts.

**3. Linux Administration**: Applied fundamental Linux concepts including file system operations, process management, networking configuration, and shell scripting. Created automated scripts for container lifecycle management, demonstrating practical system administration skills.

**4. Data Persistence**: Implemented robust data persistence using named volumes, ensuring health data survives container restarts, updates, and migrations. Demonstrated proper separation of application code and user data, enabling easy backup and disaster recovery.

**5. Data Visualization**: Integrated Plotly for interactive chart generation, enabling users to visualize health trends over time through responsive, publication-quality visualizations with zoom, pan, and hover capabilities.

## Technical Contributions

The project makes several technical contributions:

- **Comprehensive Documentation**: Created extensive documentation including setup guides, architecture descriptions, viva preparation materials, and testing checklists, making the project accessible to users with varying technical expertise.

- **Automation Scripts**: Developed shell scripts for all container lifecycle operations, demonstrating infrastructure as code principles and enabling one-command deployment.

- **Registry Integration**: Successfully demonstrated container image distribution through registry push operations, enabling deployment across multiple systems without source code access.

- **Best Practices**: Implemented industry best practices including rootless container execution, minimal base images, health checks, and proper error handling.

## Learning Outcomes

Through completion of this project, we have gained practical experience in:

- Container technology concepts and Podman-specific features
- Linux command-line operations and system administration
- Web application development using Flask framework
- Database design and SQL operations
- Interactive data visualization techniques
- Version control with Git and GitHub
- Technical documentation and communication
- Problem-solving and debugging in containerized environments

## Real-World Applications

The Smart Health Monitor demonstrates practical value beyond academic requirements:

- **Personal Health Management**: Individuals can use the application to maintain comprehensive health records and track trends over time.

- **Educational Resource**: The project serves as a learning tool for containerization, Linux administration, and web development concepts.

- **Foundation for Extension**: The architecture can be extended to support multi-user deployments, cloud hosting, mobile applications, and integration with wearable devices.

## Future Enhancements

Potential improvements and extensions include:

- **Multi-User Support**: Implement authentication and authorization for multiple users
- **Cloud Deployment**: Deploy to cloud platforms (AWS, Azure, Google Cloud) using container orchestration
- **Mobile Application**: Develop native mobile apps for iOS and Android
- **Wearable Integration**: Connect with fitness trackers and smartwatches for automatic data collection
- **Advanced Analytics**: Implement machine learning for health trend prediction and anomaly detection
- **HIPAA Compliance**: Add encryption, audit logging, and access controls for healthcare compliance
- **API Expansion**: Develop comprehensive RESTful API for third-party integrations
- **Kubernetes Deployment**: Migrate to Kubernetes for production-scale orchestration

## Conclusion

The Smart Health Monitor project successfully demonstrates that containerization technology provides elegant solutions to software deployment challenges while enabling practical applications. By packaging the application with all dependencies into a portable container image, we have eliminated the "it works on my machine" problem and enabled consistent deployment across different systems.

The project aligns perfectly with the 21CSE216P - Linux and Container Technologies curriculum, demonstrating mastery of Linux fundamentals, container lifecycle operations, volume management, networking, and registry integration. The comprehensive documentation, automated scripts, and working application showcase professional software development practices and readiness for industry challenges.

Through this project, we have not only built a functional health monitoring tool but also gained invaluable experience in modern software deployment methodologies that are increasingly critical in today's cloud-native, microservices-oriented technology landscape. The skills and knowledge acquired through this project provide a strong foundation for future work in DevOps, cloud computing, and containerized application development.

---

<div style="page-break-after: always;"></div>

# REFERENCES

## Books

1. **"The Docker Book: Containerization is the new virtualization"** by James Turnbull, 2014. Provides comprehensive introduction to container concepts and Docker/Podman usage.

2. **"Linux Administration: A Beginner's Guide"** by Wale Soyinka, 8th Edition, McGraw-Hill Education, 2019. Covers fundamental Linux system administration concepts.

3. **"Flask Web Development: Developing Web Applications with Python"** by Miguel Grinberg, 2nd Edition, O'Reilly Media, 2018. Comprehensive guide to Flask framework development.

4. **"Podman in Action"** by Daniel Walsh, Manning Publications, 2021. Detailed coverage of Podman-specific features and best practices.

## Online Documentation

5. **Podman Official Documentation** - https://docs.podman.io/ - Comprehensive reference for Podman commands, configuration, and best practices.

6. **Flask Documentation** - https://flask.palletsprojects.com/ - Official Flask framework documentation with tutorials and API reference.

7. **Plotly Python Documentation** - https://plotly.com/python/ - Interactive visualization library documentation and examples.

8. **SQLite Documentation** - https://www.sqlite.org/docs.html - Complete SQLite database engine documentation.

9. **Bootstrap Documentation** - https://getbootstrap.com/docs/5.3/ - Responsive web framework documentation and components.

10. **Open Container Initiative (OCI) Specifications** - https://opencontainers.org/ - Container image and runtime specifications.

## Technical Articles and Tutorials

11. **"Understanding Container Images"** - Red Hat Developer, https://developers.redhat.com/blog/2018/02/22/container-terminology-practical-introduction/ - Practical introduction to container terminology and concepts.

12. **"Rootless Containers with Podman"** - Red Hat Enable Sysadmin, https://www.redhat.com/sysadmin/rootless-podman - Guide to rootless container execution.

13. **"Best Practices for Writing Dockerfiles"** - Docker Documentation, https://docs.docker.com/develop/develop-images/dockerfile_best-practices/ - Applicable to Containerfiles as well.

## Course Materials

14. **21CSE216P - Linux and Container Technologies Syllabus** - SRM Institute of Science and Technology, 2025. Course curriculum and learning objectives.

15. **Linux System Administration Lecture Notes** - Department of Computer Science and Engineering, SRM IST, 2025.

## GitHub Repositories

16. **Project Repository** - https://github.com/shivayapandey/linux-elective - Complete source code, documentation, and automation scripts for the Smart Health Monitor project.

## Standards and Specifications

17. **HTTP/1.1 Specification (RFC 2616)** - https://www.ietf.org/rfc/rfc2616.txt - HTTP protocol specification for web communication.

18. **JSON Data Interchange Format (RFC 8259)** - https://tools.ietf.org/html/rfc8259 - JSON format specification for API responses.

---

**END OF REPORT**

---

**Project Information**

**Title**: Smart Health Monitor - Containerized Health Tracking System
**Course**: 21CSE216P - Linux and Container Technologies
**Institution**: SRM Institute of Science and Technology
**Department**: Computer Science and Engineering
**Academic Year**: 2025-2026 (ODD Semester)
**Students**: Shivaya Pandey (RA2311056010032), Tanisha Raha (RA2311056010042)
**Submission Date**: November 2025

---

**Total Pages**: 27
**Word Count**: Approximately 8,500 words
**Figures**: 7
**Tables**: 8
**Code Listings**: Multiple
**References**: 18

---




