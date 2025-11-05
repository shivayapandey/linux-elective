"""
Smart Health Monitor - Flask Application
A containerized health monitoring system for tracking vital health metrics
"""

from flask import Flask, render_template, request, redirect, url_for, jsonify
import sqlite3
from datetime import datetime
import os
import plotly
import plotly.graph_objs as go
import json

app = Flask(__name__)

# Database configuration
DB_PATH = os.environ.get('DB_PATH', '/data/health_monitor.db')

def get_db_connection():
    """Create a database connection"""
    conn = sqlite3.connect(DB_PATH)
    conn.row_factory = sqlite3.Row
    return conn

def init_db():
    """Initialize the database with required tables"""
    conn = get_db_connection()
    cursor = conn.cursor()
    
    # Create health_records table
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
    
    conn.commit()
    conn.close()
    print(f"Database initialized at {DB_PATH}")

@app.route('/')
def index():
    """Home page with dashboard"""
    conn = get_db_connection()
    
    # Get recent records (last 10)
    recent_records = conn.execute(
        'SELECT * FROM health_records ORDER BY timestamp DESC LIMIT 10'
    ).fetchall()
    
    # Get statistics
    stats = conn.execute('''
        SELECT 
            COUNT(*) as total_records,
            AVG(heart_rate) as avg_heart_rate,
            AVG(systolic_bp) as avg_systolic,
            AVG(diastolic_bp) as avg_diastolic,
            AVG(glucose_level) as avg_glucose
        FROM health_records
    ''').fetchone()
    
    conn.close()
    
    return render_template('index.html', records=recent_records, stats=stats)

@app.route('/add', methods=['GET', 'POST'])
def add_record():
    """Add a new health record"""
    if request.method == 'POST':
        heart_rate = request.form.get('heart_rate')
        systolic_bp = request.form.get('systolic_bp')
        diastolic_bp = request.form.get('diastolic_bp')
        glucose_level = request.form.get('glucose_level')
        notes = request.form.get('notes', '')
        
        conn = get_db_connection()
        conn.execute('''
            INSERT INTO health_records (heart_rate, systolic_bp, diastolic_bp, glucose_level, notes)
            VALUES (?, ?, ?, ?, ?)
        ''', (heart_rate, systolic_bp, diastolic_bp, glucose_level, notes))
        conn.commit()
        conn.close()
        
        return redirect(url_for('index'))
    
    return render_template('add_record.html')

@app.route('/records')
def view_records():
    """View all health records"""
    conn = get_db_connection()
    records = conn.execute(
        'SELECT * FROM health_records ORDER BY timestamp DESC'
    ).fetchall()
    conn.close()
    
    return render_template('records.html', records=records)

@app.route('/visualize')
def visualize():
    """Visualize health data with charts"""
    conn = get_db_connection()
    records = conn.execute(
        'SELECT * FROM health_records ORDER BY timestamp ASC'
    ).fetchall()
    conn.close()
    
    if not records:
        return render_template('visualize.html', charts_json=None, no_data=True)
    
    # Prepare data for visualization
    timestamps = [record['timestamp'] for record in records]
    heart_rates = [record['heart_rate'] for record in records]
    systolic_bps = [record['systolic_bp'] for record in records]
    diastolic_bps = [record['diastolic_bp'] for record in records]
    glucose_levels = [record['glucose_level'] for record in records]
    
    # Create charts
    charts = []
    
    # Heart Rate Chart
    heart_rate_chart = go.Scatter(
        x=timestamps,
        y=heart_rates,
        mode='lines+markers',
        name='Heart Rate',
        line=dict(color='red', width=2),
        marker=dict(size=8)
    )
    
    # Blood Pressure Chart
    systolic_chart = go.Scatter(
        x=timestamps,
        y=systolic_bps,
        mode='lines+markers',
        name='Systolic BP',
        line=dict(color='blue', width=2),
        marker=dict(size=8)
    )
    
    diastolic_chart = go.Scatter(
        x=timestamps,
        y=diastolic_bps,
        mode='lines+markers',
        name='Diastolic BP',
        line=dict(color='lightblue', width=2),
        marker=dict(size=8)
    )
    
    # Glucose Level Chart
    glucose_chart = go.Scatter(
        x=timestamps,
        y=glucose_levels,
        mode='lines+markers',
        name='Glucose Level',
        line=dict(color='green', width=2),
        marker=dict(size=8)
    )
    
    # Create figure with subplots
    from plotly.subplots import make_subplots
    
    fig = make_subplots(
        rows=3, cols=1,
        subplot_titles=('Heart Rate (bpm)', 'Blood Pressure (mmHg)', 'Glucose Level (mg/dL)'),
        vertical_spacing=0.1
    )
    
    fig.add_trace(heart_rate_chart, row=1, col=1)
    fig.add_trace(systolic_chart, row=2, col=1)
    fig.add_trace(diastolic_chart, row=2, col=1)
    fig.add_trace(glucose_chart, row=3, col=1)
    
    fig.update_layout(
        height=900,
        showlegend=True,
        title_text="Health Metrics Over Time",
        hovermode='x unified'
    )
    
    fig.update_xaxes(title_text="Date/Time", row=3, col=1)
    fig.update_yaxes(title_text="BPM", row=1, col=1)
    fig.update_yaxes(title_text="mmHg", row=2, col=1)
    fig.update_yaxes(title_text="mg/dL", row=3, col=1)
    
    charts_json = json.dumps(fig, cls=plotly.utils.PlotlyJSONEncoder)
    
    return render_template('visualize.html', charts_json=charts_json, no_data=False)

@app.route('/api/records')
def api_records():
    """API endpoint to get all records as JSON"""
    conn = get_db_connection()
    records = conn.execute(
        'SELECT * FROM health_records ORDER BY timestamp DESC'
    ).fetchall()
    conn.close()
    
    records_list = [dict(record) for record in records]
    return jsonify(records_list)

@app.route('/delete/<int:record_id>', methods=['POST'])
def delete_record(record_id):
    """Delete a health record"""
    conn = get_db_connection()
    conn.execute('DELETE FROM health_records WHERE id = ?', (record_id,))
    conn.commit()
    conn.close()
    
    return redirect(url_for('view_records'))

@app.route('/health')
def health_check():
    """Health check endpoint for container monitoring"""
    return jsonify({"status": "healthy", "timestamp": datetime.now().isoformat()})

if __name__ == '__main__':
    # Ensure data directory exists
    os.makedirs(os.path.dirname(DB_PATH), exist_ok=True)

    # Initialize database
    init_db()

    # Run the application
    port = int(os.environ.get('PORT', 5000))
    app.run(host='0.0.0.0', port=port, debug=True)

