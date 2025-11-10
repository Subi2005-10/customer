# Troubleshooting Guide

## Issue: Can't Open the Website

### Problem 1: Python Not Found

**Symptoms:**
- Error: "Python was not found"
- Error: "python is not recognized as an internal or external command"

**Solutions:**

#### Option A: Install Python (Recommended)
1. Download Python from https://www.python.org/downloads/
2. **IMPORTANT**: During installation, check "Add Python to PATH"
3. Choose "Install Now" or "Customize installation"
4. Verify installation by opening a new terminal and running:
   ```bash
   python --version
   ```

#### Option B: Use Python Launcher (Windows)
If Python is installed but not in PATH, try:
```bash
py -m pip install -r requirements.txt
py train_model.py
py app.py
```

#### Option C: Find Python Installation
1. Search for "Python" in Windows Start Menu
2. Open "Python 3.x" or "IDLE"
3. Note the installation path
4. Add it to PATH:
   - Right-click "This PC" → Properties
   - Advanced System Settings → Environment Variables
   - Under "System Variables", find "Path" → Edit
   - Add Python installation directory (e.g., `C:\Python39\` or `C:\Users\YourName\AppData\Local\Programs\Python\Python39\`)
   - Also add Scripts folder (e.g., `C:\Python39\Scripts\`)

### Problem 2: Model Files Not Found

**Symptoms:**
- Error: "Model not found. Please train the model first."
- Empty `models/` directory

**Solution:**
1. Make sure Python is working (see Problem 1)
2. Install dependencies:
   ```bash
   pip install -r requirements.txt
   ```
3. Train the model:
   ```bash
   python train_model.py
   ```
   This should create:
   - `models/knn_model.pkl`
   - `models/label_encoders.pkl`
   - `models/target_encoder.pkl`
   - `models/feature_cols.pkl`
   - `data/sample_churn_data.csv`

### Problem 3: Dependencies Not Installed

**Symptoms:**
- ImportError: No module named 'flask'
- ImportError: No module named 'pandas'

**Solution:**
```bash
pip install -r requirements.txt
```

If pip is not found, try:
```bash
python -m pip install -r requirements.txt
```

### Problem 4: Port Already in Use

**Symptoms:**
- Error: "Address already in use"
- Error: "Port 5000 is already in use"

**Solution:**
1. Find what's using port 5000:
   ```bash
   netstat -ano | findstr :5000
   ```
2. Kill the process or change the port in `app.py`:
   ```python
   app.run(debug=True, host='0.0.0.0', port=5001)  # Change to 5001
   ```

### Problem 5: Flask App Not Starting

**Symptoms:**
- No error but website doesn't load
- Browser shows "This site can't be reached"

**Solution:**
1. Check if Flask is running:
   - Look for "Running on http://127.0.0.1:5000" in terminal
2. Make sure you're accessing the correct URL:
   - `http://localhost:5000`
   - `http://127.0.0.1:5000`
3. Check firewall settings
4. Try running with explicit host:
   ```python
   app.run(debug=True, host='127.0.0.1', port=5000)
   ```

## Quick Start Checklist

- [ ] Python 3.8+ is installed
- [ ] Python is in PATH (test with `python --version`)
- [ ] Dependencies installed (`pip install -r requirements.txt`)
- [ ] Model trained (`python train_model.py`)
- [ ] Flask app running (`python app.py`)
- [ ] Browser opened to `http://localhost:5000`

## Still Having Issues?

1. Check the terminal/command prompt for error messages
2. Make sure all files are in the correct directories
3. Try running each step manually:
   ```bash
   # Step 1: Install dependencies
   pip install Flask pandas scikit-learn numpy Werkzeug joblib
   
   # Step 2: Train model
   python train_model.py
   
   # Step 3: Run app
   python app.py
   ```
4. Check Python version (needs 3.8+):
   ```bash
   python --version
   ```

## Common Error Messages

### "ModuleNotFoundError: No module named 'X'"
→ Install missing module: `pip install X`

### "FileNotFoundError: [Errno 2] No such file or directory: 'models/knn_model.pkl'"
→ Train the model first: `python train_model.py`

### "This site can't be reached" or "ERR_CONNECTION_REFUSED"
→ Flask app is not running. Start it with `python app.py`

### "Address already in use"
→ Another process is using port 5000. Change the port or stop the other process.




