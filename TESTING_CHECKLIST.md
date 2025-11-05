# Testing Checklist ✅

## Pre-Demo Testing Guide

Use this checklist to verify everything works before your demo/viva.

---

## 🔧 Prerequisites Check

- [ ] Linux OS running (Fedora/RHEL/Ubuntu)
- [ ] Podman installed: `podman --version`
- [ ] Python 3.11+ available: `python3 --version`
- [ ] Port 5000 is free: `sudo lsof -i :5000` (should be empty)
- [ ] Sufficient disk space: `df -h` (at least 1GB free)
- [ ] All scripts executable: `ls -la *.sh` (should show -rwxr-xr-x)

---

## 📦 Container Build Testing

### Test 1: Build Container Image
```bash
./build.sh
```

**Expected Output:**
- ✅ "Building container image: smart-health-monitor:v1.0"
- ✅ Multiple STEP messages
- ✅ "Container image built successfully!"
- ✅ Image listed in table

**Verify:**
```bash
podman images smart-health-monitor
```
- [ ] Image exists with tag v1.0
- [ ] Size is reasonable (150-200 MB)
- [ ] Created timestamp is recent

### Test 2: Inspect Image
```bash
podman inspect smart-health-monitor:v1.0
```

**Verify:**
- [ ] Image ID exists
- [ ] Labels include maintainer, description, version
- [ ] Exposed ports include 5000
- [ ] CMD is ["python", "app.py"]

---

## 🚀 Container Run Testing

### Test 3: Run Container
```bash
./run.sh
```

**Expected Output:**
- ✅ "Creating persistent volume: health-data" (first time)
- ✅ "Starting container..."
- ✅ "Container started successfully!"
- ✅ Container listed in status table
- ✅ "Application is running!"
- ✅ Access URL shown

**Verify:**
```bash
podman ps
```
- [ ] Container named "health-monitor-app" is running
- [ ] Status is "Up"
- [ ] Port mapping shows 0.0.0.0:5000->5000/tcp

### Test 4: Volume Creation
```bash
podman volume ls
```

**Verify:**
- [ ] Volume "health-data" exists
- [ ] Driver is "local"

```bash
podman volume inspect health-data
```
- [ ] Mount point exists
- [ ] Created timestamp is present

---

## 🌐 Application Testing

### Test 5: Application Access
```bash
curl -I http://localhost:5000
```

**Expected:**
- [ ] HTTP/1.1 200 OK
- [ ] Content-Type: text/html

**Browser Test:**
- [ ] Open http://localhost:5000
- [ ] Page loads without errors
- [ ] Navigation bar visible
- [ ] Dashboard displays
- [ ] All menu items clickable

### Test 6: Dashboard Page
**URL:** http://localhost:5000

**Verify:**
- [ ] Page title: "Dashboard - Smart Health Monitor"
- [ ] Statistics cards display (4 cards)
- [ ] "Total Records" shows 0 (if fresh install)
- [ ] "Add Your First Record" button visible (if no data)
- [ ] Footer shows student names

### Test 7: Add Record Page
**URL:** http://localhost:5000/add

**Verify:**
- [ ] Form displays with all fields
- [ ] Heart Rate input (40-200 range)
- [ ] Systolic BP input
- [ ] Diastolic BP input
- [ ] Glucose Level input
- [ ] Notes textarea
- [ ] Save and Cancel buttons

**Test Form Submission:**
1. Enter valid data:
   - Heart Rate: 72
   - Systolic BP: 120
   - Diastolic BP: 80
   - Glucose: 95
   - Notes: "Test record"
2. Click "Save Record"

**Expected:**
- [ ] Redirects to dashboard
- [ ] Success (no error)
- [ ] Record appears in recent records

### Test 8: View Records Page
**URL:** http://localhost:5000/records

**Verify:**
- [ ] Table displays with headers
- [ ] Test record appears
- [ ] Color-coded badges show
- [ ] Delete button present
- [ ] Timestamp is correct

**Test Delete:**
1. Click delete button
2. Confirm deletion

**Expected:**
- [ ] Confirmation dialog appears
- [ ] Record is deleted after confirmation
- [ ] Page refreshes

### Test 9: Visualization Page
**URL:** http://localhost:5000/visualize

**Add 5+ records first, then verify:**
- [ ] Charts display
- [ ] Three subplots visible:
  - Heart Rate chart
  - Blood Pressure chart
  - Glucose Level chart
- [ ] Interactive features work:
  - [ ] Hover shows values
  - [ ] Zoom works
  - [ ] Pan works
- [ ] Legend displays
- [ ] Axes labeled correctly

### Test 10: API Endpoint
```bash
curl http://localhost:5000/api/records
```

**Expected:**
- [ ] Returns JSON array
- [ ] Contains health records
- [ ] Proper JSON format

### Test 11: Health Check Endpoint
```bash
curl http://localhost:5000/health
```

**Expected:**
- [ ] Returns JSON: `{"status": "healthy", "timestamp": "..."}`
- [ ] HTTP 200 status

---

## 🔍 Container Inspection Testing

### Test 12: Container Logs
```bash
podman logs health-monitor-app
```

**Verify:**
- [ ] Flask startup messages
- [ ] "Database initialized" message
- [ ] "Running on http://0.0.0.0:5000"
- [ ] No error messages

### Test 13: Container Stats
```bash
podman stats health-monitor-app --no-stream
```

**Verify:**
- [ ] CPU usage shown
- [ ] Memory usage shown
- [ ] Network I/O shown
- [ ] Values are reasonable

### Test 14: Container Inspection
```bash
./inspect.sh
```

**Expected Output:**
- [ ] Container status: RUNNING
- [ ] Container details displayed
- [ ] Resource usage shown
- [ ] Recent logs shown
- [ ] Running processes listed
- [ ] Volume information displayed

### Test 15: Execute Commands in Container
```bash
podman exec health-monitor-app ls -la /data
```

**Verify:**
- [ ] Directory listing shows
- [ ] health_monitor.db file exists
- [ ] File has reasonable size

```bash
podman exec health-monitor-app python -c "import sqlite3; print('SQLite OK')"
```

**Expected:**
- [ ] Prints "SQLite OK"

---

## 💾 Data Persistence Testing

### Test 16: Data Persistence
1. Add 3 health records
2. Note the record IDs
3. Stop container:
   ```bash
   ./stop.sh
   ```
4. Verify container stopped:
   ```bash
   podman ps
   ```
   - [ ] Container not in list
5. Restart container:
   ```bash
   ./run.sh
   ```
6. Open browser: http://localhost:5000
7. Check records

**Verify:**
- [ ] All 3 records still exist
- [ ] Same IDs as before
- [ ] Data is intact
- [ ] Timestamps preserved

---

## 🔄 Container Lifecycle Testing

### Test 17: Stop and Remove
```bash
./stop.sh
```

**Expected:**
- [ ] "Stopping container" message
- [ ] "Removing container" message
- [ ] Success message
- [ ] Note about data preservation

**Verify:**
```bash
podman ps -a
```
- [ ] Container not in list

```bash
podman volume ls
```
- [ ] Volume still exists

### Test 18: Rebuild and Run
```bash
./build.sh
./run.sh
```

**Verify:**
- [ ] Build succeeds
- [ ] Run succeeds
- [ ] Application accessible
- [ ] Previous data still available

---

## 📊 Sample Data Testing

### Test 19: Sample Data Generator
```bash
python3 add_sample_data.py 10
```

**Expected:**
- [ ] "Generating 10 sample health records..."
- [ ] 10 records listed
- [ ] Success message
- [ ] Database location shown

**Verify in Browser:**
- [ ] Dashboard shows 10 records
- [ ] Statistics updated
- [ ] Visualization shows trends

---

## 🎬 Demo Script Testing

### Test 20: Automated Demo
```bash
./demo.sh
```

**Follow prompts and verify:**
- [ ] System information displays
- [ ] Build completes
- [ ] Image details shown
- [ ] Volume created/inspected
- [ ] Container runs
- [ ] Inspection works
- [ ] Logs display
- [ ] Processes shown
- [ ] Stats display
- [ ] Health check works
- [ ] Data persistence demonstrated
- [ ] All steps complete successfully

---

## 🌐 Browser Compatibility Testing

Test in multiple browsers:

### Chrome/Chromium
- [ ] Dashboard loads
- [ ] Forms work
- [ ] Charts render
- [ ] No console errors

### Firefox
- [ ] Dashboard loads
- [ ] Forms work
- [ ] Charts render
- [ ] No console errors

### Safari (if on Mac)
- [ ] Dashboard loads
- [ ] Forms work
- [ ] Charts render
- [ ] No console errors

---

## 🔒 Security Testing

### Test 21: Rootless Container
```bash
podman inspect health-monitor-app | grep -i user
```

**Verify:**
- [ ] Not running as root

### Test 22: Input Validation
Try invalid inputs:
- Heart rate: -10 (should reject)
- Heart rate: 300 (should reject)
- Systolic < Diastolic (should warn)

**Verify:**
- [ ] Validation works
- [ ] Error messages shown

---

## 📝 Documentation Testing

### Test 23: README Accuracy
- [ ] All commands in README work
- [ ] Links are valid
- [ ] Examples are correct
- [ ] Screenshots match (if any)

### Test 24: Quick Start Guide
Follow QUICKSTART.md step-by-step:
- [ ] All steps work
- [ ] No missing information
- [ ] Application runs successfully

---

## 🎯 Final Verification

### Pre-Demo Checklist
- [ ] Container builds without errors
- [ ] Container runs successfully
- [ ] Application accessible at http://localhost:5000
- [ ] All pages load correctly
- [ ] Can add health records
- [ ] Can view records
- [ ] Visualizations work
- [ ] Data persists after restart
- [ ] All scripts work (build, run, stop, inspect, demo)
- [ ] Documentation is accurate
- [ ] Sample data can be generated
- [ ] No error messages in logs

### Demo Readiness
- [ ] Podman version known
- [ ] Can explain Containerfile
- [ ] Can demonstrate all features
- [ ] Can answer viva questions
- [ ] Backup plan if something fails
- [ ] Sample data loaded for visualization

---

## 🐛 Known Issues & Workarounds

### Issue: Port 5000 already in use
**Solution:**
```bash
sudo lsof -i :5000
sudo kill -9 <PID>
```

### Issue: Permission denied on scripts
**Solution:**
```bash
chmod +x *.sh
```

### Issue: Container won't start
**Solution:**
```bash
podman logs health-monitor-app
# Check error and fix
```

### Issue: Volume not mounting
**Solution:**
```bash
podman volume rm health-data
./run.sh
```

---

## ✅ Sign-Off

**Tested By:** ___________________  
**Date:** ___________________  
**All Tests Passed:** [ ] Yes [ ] No  
**Ready for Demo:** [ ] Yes [ ] No  

**Notes:**
_______________________________________
_______________________________________
_______________________________________

---

**If all tests pass, you're ready for your demo! 🎉**

