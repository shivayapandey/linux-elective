#!/usr/bin/env python3
"""
Sample Data Generator for Smart Health Monitor
Use this to populate the database with sample health records for demonstration
"""

import sqlite3
import random
from datetime import datetime, timedelta
import os

# Database path
DB_PATH = os.environ.get('DB_PATH', 'health_monitor.db')

def generate_sample_data(num_records=10):
    """Generate sample health records"""
    
    # Connect to database
    conn = sqlite3.connect(DB_PATH)
    cursor = conn.cursor()
    
    # Create table if not exists
    cursor.execute('''
        CREATE TABLE IF NOT EXISTS health_records (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            timestamp DATETIME DEFAULT CURRENT_TIMESTAMP,
            heart_rate INTEGER,
            systolic_bp INTEGER,
            diastolic_bp INTEGER,
            glucose_level REAL,
            notes TEXT
        )
    ''')
    
    print(f"Generating {num_records} sample health records...")
    print("-" * 50)
    
    # Sample notes
    notes_options = [
        "Morning reading before breakfast",
        "After 30 minutes of exercise",
        "Evening reading before dinner",
        "Post-meal reading",
        "Resting state measurement",
        "After morning walk",
        "Before bedtime",
        "Feeling energetic today",
        "Slightly tired",
        ""
    ]
    
    # Generate records with timestamps spread over the last 30 days
    base_date = datetime.now() - timedelta(days=30)
    
    for i in range(num_records):
        # Generate realistic health metrics with some variation
        heart_rate = random.randint(60, 100)  # Normal range
        systolic_bp = random.randint(110, 135)  # Slightly varied
        diastolic_bp = random.randint(70, 85)  # Normal range
        glucose_level = round(random.uniform(80, 110), 1)  # Normal fasting range
        notes = random.choice(notes_options)
        
        # Create timestamp (spread over 30 days)
        days_offset = (30 / num_records) * i
        timestamp = base_date + timedelta(days=days_offset, hours=random.randint(6, 22))
        
        # Insert record
        cursor.execute('''
            INSERT INTO health_records (timestamp, heart_rate, systolic_bp, diastolic_bp, glucose_level, notes)
            VALUES (?, ?, ?, ?, ?, ?)
        ''', (timestamp.strftime('%Y-%m-%d %H:%M:%S'), heart_rate, systolic_bp, diastolic_bp, glucose_level, notes))
        
        print(f"Record {i+1}: {timestamp.strftime('%Y-%m-%d %H:%M')} | "
              f"HR: {heart_rate} bpm | BP: {systolic_bp}/{diastolic_bp} mmHg | "
              f"Glucose: {glucose_level} mg/dL")
    
    conn.commit()
    conn.close()
    
    print("-" * 50)
    print(f"✅ Successfully added {num_records} sample records!")
    print(f"Database location: {DB_PATH}")
    print("\nYou can now:")
    print("  1. Start the application: ./run.sh")
    print("  2. View the dashboard at http://localhost:5000")
    print("  3. Check visualizations with the sample data")

if __name__ == "__main__":
    import sys
    
    # Get number of records from command line argument
    num_records = 10
    if len(sys.argv) > 1:
        try:
            num_records = int(sys.argv[1])
        except ValueError:
            print("Invalid number. Using default: 10 records")
    
    print("=" * 50)
    print("Smart Health Monitor - Sample Data Generator")
    print("=" * 50)
    print()
    
    generate_sample_data(num_records)

