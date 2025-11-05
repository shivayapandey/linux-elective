# System Architecture 🏗️

## Smart Health Monitor - Containerized Architecture

---

## High-Level Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                        User Layer                           │
│                                                             │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐    │
│  │   Browser    │  │   Browser    │  │   Browser    │    │
│  │  (Chrome)    │  │  (Firefox)   │  │   (Safari)   │    │
│  └──────┬───────┘  └──────┬───────┘  └──────┬───────┘    │
│         │                  │                  │            │
│         └──────────────────┼──────────────────┘            │
│                            │                               │
└────────────────────────────┼───────────────────────────────┘
                             │
                             │ HTTP (Port 5000)
                             │
┌────────────────────────────▼───────────────────────────────┐
│                     Host System (Linux)                    │
│                                                            │
│  ┌──────────────────────────────────────────────────────┐ │
│  │              Podman Container Engine                 │ │
│  │                                                      │ │
│  │  ┌────────────────────────────────────────────────┐ │ │
│  │  │        Container: health-monitor-app          │ │ │
│  │  │                                                │ │ │
│  │  │  ┌──────────────────────────────────────────┐ │ │ │
│  │  │  │        Flask Application Layer           │ │ │ │
│  │  │  │                                          │ │ │ │
│  │  │  │  • Routes (/, /add, /records, etc.)     │ │ │ │
│  │  │  │  • Business Logic                        │ │ │ │
│  │  │  │  • Template Rendering                    │ │ │ │
│  │  │  │  • API Endpoints                         │ │ │ │
│  │  │  └──────────────┬───────────────────────────┘ │ │ │
│  │  │                 │                              │ │ │
│  │  │  ┌──────────────▼───────────────────────────┐ │ │ │
│  │  │  │      Presentation Layer (Templates)      │ │ │ │
│  │  │  │                                          │ │ │ │
│  │  │  │  • base.html (Layout)                   │ │ │ │
│  │  │  │  • index.html (Dashboard)               │ │ │ │
│  │  │  │  • add_record.html (Input Form)         │ │ │ │
│  │  │  │  • records.html (Data Table)            │ │ │ │
│  │  │  │  • visualize.html (Charts)              │ │ │ │
│  │  │  └──────────────────────────────────────────┘ │ │ │
│  │  │                                                │ │ │
│  │  │  ┌──────────────────────────────────────────┐ │ │ │
│  │  │  │         Data Layer (SQLite)              │ │ │ │
│  │  │  │                                          │ │ │ │
│  │  │  │  Database: /data/health_monitor.db      │ │ │ │
│  │  │  │                                          │ │ │ │
│  │  │  │  Table: health_records                  │ │ │ │
│  │  │  │  - id (PRIMARY KEY)                     │ │ │ │
│  │  │  │  - timestamp                            │ │ │ │
│  │  │  │  - heart_rate                           │ │ │ │
│  │  │  │  - systolic_bp                          │ │ │ │
│  │  │  │  - diastolic_bp                         │ │ │ │
│  │  │  │  - glucose_level                        │ │ │ │
│  │  │  │  - notes                                │ │ │ │
│  │  │  └──────────────┬───────────────────────────┘ │ │ │
│  │  │                 │                              │ │ │
│  │  └─────────────────┼──────────────────────────────┘ │ │
│  │                    │                                │ │
│  │                    │ Volume Mount                   │ │
│  │                    │                                │ │
│  └────────────────────┼────────────────────────────────┘ │
│                       │                                  │
│  ┌────────────────────▼────────────────────────────────┐ │
│  │         Podman Volume: health-data                  │ │
│  │         (Persistent Storage)                        │ │
│  │                                                     │ │
│  │  Mount Point: /var/lib/containers/storage/volumes/ │ │
│  └─────────────────────────────────────────────────────┘ │
│                                                          │
└──────────────────────────────────────────────────────────┘
```

---

## Component Details

### 1. User Layer
- **Web Browsers**: Any modern browser (Chrome, Firefox, Safari, Edge)
- **Access Point**: `http://localhost:5000`
- **Interface**: Responsive web UI with Bootstrap 5

### 2. Host System (Linux)
- **Operating System**: Fedora, RHEL, Ubuntu, or any Linux distribution
- **Container Engine**: Podman (rootless, daemonless)
- **Port Mapping**: Host port 5000 → Container port 5000
- **Volume Management**: Podman volume driver

### 3. Container Layer

#### Container: health-monitor-app
- **Base Image**: `python:3.11-slim`
- **Image Name**: `smart-health-monitor:v1.0`
- **Runtime**: Podman container
- **Network**: Bridge network with port mapping
- **Storage**: Volume mount for persistence

### 4. Application Layer (Flask)

#### Routes
```python
/                    # Dashboard (GET)
/add                 # Add record (GET, POST)
/records             # View all records (GET)
/visualize           # Charts (GET)
/delete/<id>         # Delete record (POST)
/api/records         # JSON API (GET)
/health              # Health check (GET)
```

#### Key Functions
- `init_db()`: Initialize database schema
- `get_db_connection()`: Create database connection
- Route handlers for each endpoint
- Data validation and processing
- Chart generation with Plotly

### 5. Presentation Layer

#### Templates
- **base.html**: Master template with navigation
- **index.html**: Dashboard with statistics
- **add_record.html**: Form for data entry
- **records.html**: Table view of all records
- **visualize.html**: Interactive charts

#### Frontend Technologies
- HTML5
- CSS3 (Bootstrap 5)
- JavaScript (Plotly.js for charts)
- Bootstrap Icons

### 6. Data Layer

#### SQLite Database
- **Location**: `/data/health_monitor.db`
- **Type**: File-based relational database
- **Schema**: Single table `health_records`

#### Database Schema
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

### 7. Storage Layer

#### Podman Volume
- **Name**: `health-data`
- **Type**: Named volume
- **Mount Point**: `/data` (inside container)
- **Persistence**: Survives container deletion
- **Backup**: Can be exported/imported

---

## Data Flow

### Adding a Health Record

```
User fills form → POST /add → Flask validates data → 
Insert into SQLite → Commit transaction → Redirect to dashboard
```

### Viewing Visualizations

```
User clicks Visualize → GET /visualize → Flask queries database →
Process data → Generate Plotly charts → Render template →
Browser displays interactive charts
```

### Container Lifecycle

```
Build Image → Create Volume → Run Container → 
Mount Volume → Start Flask → Initialize DB → Serve Application
```

---

## Network Architecture

```
┌─────────────────────────────────────────┐
│         External Network                │
│                                         │
│  User Browser: http://localhost:5000   │
└──────────────────┬──────────────────────┘
                   │
                   │ TCP/IP
                   │
┌──────────────────▼──────────────────────┐
│         Host Network Interface          │
│         (localhost:5000)                │
└──────────────────┬──────────────────────┘
                   │
                   │ Port Mapping (-p 5000:5000)
                   │
┌──────────────────▼──────────────────────┐
│      Container Network Namespace        │
│                                         │
│  Container IP: 10.88.0.x (dynamic)     │
│  Container Port: 5000                   │
│                                         │
│  ┌───────────────────────────────────┐ │
│  │   Flask App listening on 0.0.0.0  │ │
│  │   Port: 5000                      │ │
│  └───────────────────────────────────┘ │
└─────────────────────────────────────────┘
```

---

## File System Structure

### Host System
```
/Users/shivayapandey/linux/
├── app.py                      # Flask application
├── requirements.txt            # Python dependencies
├── Containerfile              # Container image definition
├── build.sh                   # Build script
├── run.sh                     # Run script
├── stop.sh                    # Stop script
├── inspect.sh                 # Inspection script
├── demo.sh                    # Demo script
├── templates/                 # HTML templates
│   ├── base.html
│   ├── index.html
│   ├── add_record.html
│   ├── records.html
│   └── visualize.html
└── static/                    # Static files (if any)
```

### Inside Container
```
/app/                          # Working directory
├── app.py
├── requirements.txt
├── templates/
│   └── (all templates)
└── static/

/data/                         # Volume mount point
└── health_monitor.db          # SQLite database
```

---

## Technology Stack Details

| Layer | Technology | Purpose |
|-------|-----------|---------|
| **Container** | Podman | Container runtime |
| **Base Image** | Python 3.11 Slim | Minimal Python environment |
| **Web Framework** | Flask 3.0 | HTTP server & routing |
| **Database** | SQLite 3 | Data persistence |
| **Visualization** | Plotly 5.18 | Interactive charts |
| **Frontend** | Bootstrap 5 | Responsive UI |
| **Icons** | Bootstrap Icons | UI icons |
| **Scripting** | Bash | Automation |

---

## Security Architecture

### Container Security
- **Rootless**: Runs without root privileges
- **Isolation**: Separate network and file system namespace
- **Minimal Base**: Reduced attack surface
- **No Secrets**: No hardcoded credentials

### Application Security
- **Input Validation**: Form validation on client and server
- **SQL Injection**: Parameterized queries
- **XSS Protection**: Template escaping
- **CSRF**: Form tokens (can be added)

---

## Scalability Considerations

### Current Architecture
- Single container
- SQLite database
- Suitable for: Personal use, demos, small deployments

### Future Scalability
- **Multiple Containers**: Load balancing
- **External Database**: PostgreSQL/MySQL
- **Container Orchestration**: Kubernetes/Podman pods
- **Caching**: Redis for session management
- **CDN**: Static file delivery

---

## Monitoring & Logging

### Container Monitoring
```bash
podman stats health-monitor-app    # Resource usage
podman logs health-monitor-app     # Application logs
podman inspect health-monitor-app  # Container details
```

### Health Checks
- **Endpoint**: `/health`
- **Interval**: 30 seconds
- **Timeout**: 10 seconds
- **Retries**: 3

### Logging
- **Container Logs**: stdout/stderr captured by Podman
- **Flask Logs**: Debug mode enabled
- **Access Logs**: HTTP requests logged

---

## Backup & Recovery

### Database Backup
```bash
# Backup volume
podman run --rm -v health-data:/data -v $(pwd):/backup alpine \
  tar czf /backup/health-data-backup.tar.gz /data

# Restore volume
podman run --rm -v health-data:/data -v $(pwd):/backup alpine \
  tar xzf /backup/health-data-backup.tar.gz -C /
```

### Image Backup
```bash
# Save image
podman save -o health-monitor.tar smart-health-monitor:v1.0

# Load image
podman load -i health-monitor.tar
```

---

## Deployment Workflow

```
┌─────────────┐
│ Development │
│   (Local)   │
└──────┬──────┘
       │
       │ 1. Build Image
       ▼
┌─────────────┐
│   Podman    │
│   Build     │
└──────┬──────┘
       │
       │ 2. Test Locally
       ▼
┌─────────────┐
│ Local Test  │
└──────┬──────┘
       │
       │ 3. Push to Registry
       ▼
┌─────────────┐
│  Quay.io /  │
│ Docker Hub  │
└──────┬──────┘
       │
       │ 4. Pull on Target
       ▼
┌─────────────┐
│ Production  │
│   Server    │
└─────────────┘
```

---

This architecture ensures:
- ✅ **Portability**: Runs anywhere with Podman
- ✅ **Persistence**: Data survives container restarts
- ✅ **Scalability**: Can be extended for larger deployments
- ✅ **Security**: Rootless and isolated
- ✅ **Maintainability**: Clear separation of concerns

