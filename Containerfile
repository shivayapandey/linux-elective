# Containerfile for Smart Health Monitor
# This demonstrates Linux container technologies using Podman

# Use official Python base image
FROM python:3.11-slim

# Set metadata labels
LABEL maintainer="Shivaya Pandey & Tanisha Raha"
LABEL description="Smart Health Monitor - Containerized Health Tracking System"
LABEL version="1.0"
LABEL project="Linux and Container Technologies - Batch 3"

# Set working directory
WORKDIR /app

# Create data directory for SQLite database (will be mounted as volume)
RUN mkdir -p /data

# Copy requirements first for better layer caching
COPY requirements.txt .

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy application files
COPY app.py .
COPY templates/ templates/
COPY static/ static/

# Set environment variables
ENV FLASK_APP=app.py
ENV DB_PATH=/data/health_monitor.db
ENV PYTHONUNBUFFERED=1

# Expose port 5000 for Flask application
EXPOSE 5000

# Health check to monitor container status
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
    CMD python -c "import requests; requests.get('http://localhost:5000/health')" || exit 1

# Run the Flask application
CMD ["python", "app.py"]

