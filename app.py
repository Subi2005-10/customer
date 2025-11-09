"""
Flask application for Customer Churn Prediction
"""
from flask import Flask, render_template, request, jsonify, redirect, url_for, flash
import pandas as pd
import numpy as np
import joblib
import os
from datetime import datetime
import sqlite3
from werkzeug.utils import secure_filename

app = Flask(__name__)
app.secret_key = 'your-secret-key-change-in-production'

# Ensure we're in the correct directory
script_dir = os.path.dirname(os.path.abspath(__file__))
os.chdir(script_dir)

app.config['UPLOAD_FOLDER'] = 'uploads'
app.config['MAX_CONTENT_LENGTH'] = 16 * 1024 * 1024  # 16MB max file size

# Allowed file extensions
ALLOWED_EXTENSIONS = {'csv'}

# Create necessary directories
os.makedirs('uploads', exist_ok=True)
os.makedirs('models', exist_ok=True)
os.makedirs('static/images', exist_ok=True)
os.makedirs('data', exist_ok=True)

# Load model and encoders
def load_model():
    """Load the trained model and encoders."""
    try:
        model = joblib.load('models/knn_model.pkl')
        label_encoders = joblib.load('models/label_encoders.pkl')
        target_encoder = joblib.load('models/target_encoder.pkl')
        feature_cols = joblib.load('models/feature_cols.pkl')
        return model, label_encoders, target_encoder, feature_cols
    except FileNotFoundError:
        return None, None, None, None

# Initialize database
def init_db():
    """Initialize SQLite database for prediction history."""
    conn = sqlite3.connect('churn_predictions.db')
    c = conn.cursor()
    c.execute('''
        CREATE TABLE IF NOT EXISTS predictions (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            timestamp TEXT,
            customer_id TEXT,
            prediction TEXT,
            probability REAL,
            features TEXT
        )
    ''')
    conn.commit()
    conn.close()

def allowed_file(filename):
    """Check if file extension is allowed."""
    return '.' in filename and filename.rsplit('.', 1)[1].lower() in ALLOWED_EXTENSIONS

def preprocess_data(df, label_encoders, feature_cols):
    """Preprocess input data for prediction."""
    # Ensure all required columns exist
    missing_cols = set(feature_cols) - set(df.columns)
    if missing_cols:
        raise ValueError(f"Missing columns: {missing_cols}")
    
    X = df[feature_cols].copy()
    
    # Encode categorical variables
    for col in X.select_dtypes(include=['object']).columns:
        if col in label_encoders:
            # Handle unseen categories
            le = label_encoders[col]
            X[col] = X[col].apply(lambda x: x if x in le.classes_ else le.classes_[0])
            X[col] = le.transform(X[col])
    
    return X

@app.route('/')
def index():
    """Home page."""
    return render_template('index.html')

@app.route('/predict', methods=['GET', 'POST'])
def predict():
    """Prediction page with manual input form."""
    if request.method == 'POST':
        try:
            model, label_encoders, target_encoder, feature_cols = load_model()
            if model is None:
                flash('Model not found. Please train the model first.', 'error')
                return redirect(url_for('index'))
            
            # Get form data
            data = {
                'gender': request.form.get('gender'),
                'SeniorCitizen': int(request.form.get('SeniorCitizen', 0)),
                'Partner': request.form.get('Partner'),
                'Dependents': request.form.get('Dependents'),
                'tenure': int(request.form.get('tenure', 0)),
                'PhoneService': request.form.get('PhoneService'),
                'MultipleLines': request.form.get('MultipleLines'),
                'InternetService': request.form.get('InternetService'),
                'OnlineSecurity': request.form.get('OnlineSecurity'),
                'OnlineBackup': request.form.get('OnlineBackup'),
                'DeviceProtection': request.form.get('DeviceProtection'),
                'TechSupport': request.form.get('TechSupport'),
                'StreamingTV': request.form.get('StreamingTV'),
                'StreamingMovies': request.form.get('StreamingMovies'),
                'Contract': request.form.get('Contract'),
                'PaperlessBilling': request.form.get('PaperlessBilling'),
                'PaymentMethod': request.form.get('PaymentMethod'),
                'MonthlyCharges': float(request.form.get('MonthlyCharges', 0)),
                'TotalCharges': float(request.form.get('TotalCharges', 0))
            }
            
            # Create DataFrame
            df = pd.DataFrame([data])
            
            # Preprocess
            X = preprocess_data(df, label_encoders, feature_cols)
            
            # Predict
            prediction = model.predict(X)[0]
            probabilities = model.predict_proba(X)[0]
            
            # Decode prediction
            churn_prediction = target_encoder.inverse_transform([prediction])[0]
            churn_probability = probabilities[prediction] * 100
            
            # Store in database
            save_prediction(data.get('customerID', 'MANUAL'), churn_prediction, churn_probability, data)
            
            return render_template('predict.html', 
                                 prediction=churn_prediction,
                                 probability=round(churn_probability, 2),
                                 show_result=True)
        except Exception as e:
            flash(f'Error: {str(e)}', 'error')
            return render_template('predict.html', show_result=False)
    
    return render_template('predict.html', show_result=False)

@app.route('/upload', methods=['GET', 'POST'])
def upload():
    """CSV upload and batch prediction page."""
    if request.method == 'POST':
        if 'file' not in request.files:
            flash('No file selected', 'error')
            return redirect(request.url)
        
        file = request.files['file']
        if file.filename == '':
            flash('No file selected', 'error')
            return redirect(request.url)
        
        if file and allowed_file(file.filename):
            try:
                filename = secure_filename(file.filename)
                filepath = os.path.join(app.config['UPLOAD_FOLDER'], filename)
                file.save(filepath)
                
                # Load model
                model, label_encoders, target_encoder, feature_cols = load_model()
                if model is None:
                    flash('Model not found. Please train the model first.', 'error')
                    return redirect(url_for('index'))
                
                # Read CSV
                df = pd.read_csv(filepath)
                
                # Check for customerID column
                if 'customerID' not in df.columns:
                    df['customerID'] = [f'CUST{i:05d}' for i in range(1, len(df) + 1)]
                
                # Preprocess
                X = preprocess_data(df, label_encoders, feature_cols)
                
                # Predict
                predictions = model.predict(X)
                probabilities = model.predict_proba(X)
                
                # Decode predictions
                churn_predictions = target_encoder.inverse_transform(predictions)
                churn_probabilities = [probs[pred] * 100 for probs, pred in zip(probabilities, predictions)]
                
                # Add predictions to dataframe
                df['Churn_Prediction'] = churn_predictions
                df['Churn_Probability'] = [round(p, 2) for p in churn_probabilities]
                
                # Store predictions in database
                for idx, row in df.iterrows():
                    save_prediction(
                        str(row.get('customerID', f'CUST{idx}')),
                        row['Churn_Prediction'],
                        row['Churn_Probability'],
                        row.to_dict()
                    )
                
                # Save results
                results_path = os.path.join(app.config['UPLOAD_FOLDER'], f'results_{filename}')
                df.to_csv(results_path, index=False)
                
                # Prepare results for display
                results = df[['customerID', 'Churn_Prediction', 'Churn_Probability']].to_dict('records')
                
                return render_template('upload.html', 
                                     results=results,
                                     filename=filename,
                                     show_results=True)
            except Exception as e:
                flash(f'Error processing file: {str(e)}', 'error')
                return render_template('upload.html', show_results=False)
        else:
            flash('Invalid file type. Please upload a CSV file.', 'error')
            return redirect(request.url)
    
    return render_template('upload.html', show_results=False)

@app.route('/dashboard')
def dashboard():
    """Dashboard with churn statistics."""
    conn = sqlite3.connect('churn_predictions.db')
    c = conn.cursor()
    
    # Get statistics
    c.execute('SELECT COUNT(*) FROM predictions')
    total_predictions = c.fetchone()[0]
    
    c.execute("SELECT COUNT(*) FROM predictions WHERE prediction = 'Yes'")
    churn_yes = c.fetchone()[0]
    
    c.execute("SELECT COUNT(*) FROM predictions WHERE prediction = 'No'")
    churn_no = c.fetchone()[0]
    
    c.execute("SELECT AVG(probability) FROM predictions WHERE prediction = 'Yes'")
    avg_prob_yes = c.fetchone()[0] or 0
    
    c.execute("SELECT AVG(probability) FROM predictions WHERE prediction = 'No'")
    avg_prob_no = c.fetchone()[0] or 0
    
    # Get recent predictions
    c.execute('SELECT * FROM predictions ORDER BY timestamp DESC LIMIT 10')
    recent_predictions = c.fetchall()
    
    conn.close()
    
    stats = {
        'total': total_predictions,
        'churn_yes': churn_yes,
        'churn_no': churn_no,
        'avg_prob_yes': round(avg_prob_yes, 2),
        'avg_prob_no': round(avg_prob_no, 2),
        'churn_rate': round((churn_yes / total_predictions * 100) if total_predictions > 0 else 0, 2)
    }
    
    return render_template('dashboard.html', stats=stats, recent_predictions=recent_predictions)

@app.route('/about')
def about():
    """About page."""
    return render_template('about.html')

@app.route('/contact')
def contact():
    """Contact page."""
    return render_template('contact.html')

def save_prediction(customer_id, prediction, probability, features):
    """Save prediction to database."""
    conn = sqlite3.connect('churn_predictions.db')
    c = conn.cursor()
    c.execute('''
        INSERT INTO predictions (timestamp, customer_id, prediction, probability, features)
        VALUES (?, ?, ?, ?, ?)
    ''', (datetime.now().isoformat(), customer_id, prediction, probability, str(features)))
    conn.commit()
    conn.close()

@app.route('/api/stats')
def api_stats():
    """API endpoint for dashboard statistics."""
    conn = sqlite3.connect('churn_predictions.db')
    c = conn.cursor()
    
    c.execute("SELECT COUNT(*) FROM predictions WHERE prediction = 'Yes'")
    churn_yes = c.fetchone()[0]
    
    c.execute("SELECT COUNT(*) FROM predictions WHERE prediction = 'No'")
    churn_no = c.fetchone()[0]
    
    conn.close()
    
    return jsonify({
        'churn_yes': churn_yes,
        'churn_no': churn_no
    })

if __name__ == '__main__':
    init_db()
    
    # Get local IP address for network access
    import socket
    def get_local_ip():
        try:
            # Connect to a remote address to get local IP
            s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
            s.connect(("8.8.8.8", 80))
            ip = s.getsockname()[0]
            s.close()
            return ip
        except:
            return "Unable to detect"
    
    local_ip = get_local_ip()
    
    print("\n" + "="*50)
    print("  Churn Prediction Website")
    print("="*50)
    print("\n  Website is running at:")
    print("  Local access:")
    print("    http://localhost:5000")
    print("    http://127.0.0.1:5000")
    print("\n  Network access (for phone/other devices):")
    print(f"    http://{local_ip}:5000")
    print("\n  Make sure your phone is on the same WiFi network!")
    print("\n  Press Ctrl+C to stop the server")
    print("="*50 + "\n")
    app.run(debug=True, host='0.0.0.0', port=5000)

