# Quick Setup Instructions

## Step 1: Verify Python Installation

Open a **NEW** Command Prompt or PowerShell window (important - close and reopen to refresh PATH) and run:

```bash
python --version
```

You should see something like: `Python 3.11.x` or `Python 3.12.x`

If that doesn't work, try:
```bash
py --version
```

## Step 2: Navigate to Project Folder

In the terminal, navigate to your project folder:

```bash
cd "C:\Users\vidhy\OneDrive - SRM Institute of Science & Technology\Desktop\customer"
```

## Step 3: Install Dependencies

Run this command:

```bash
python -m pip install -r requirements.txt
```

Or if `python` doesn't work:
```bash
py -m pip install -r requirements.txt
```

This will install:
- Flask (web framework)
- pandas (data processing)
- scikit-learn (machine learning)
- numpy (numerical computing)
- joblib (model saving)

**Wait for this to complete** - it may take a few minutes.

## Step 4: Train the Machine Learning Model

Run:

```bash
python train_model.py
```

Or:
```bash
py train_model.py
```

This will:
- Generate sample customer data
- Train the KNN model
- Save the model files

**Wait for this to complete** - you should see "Model and encoders saved successfully!"

## Step 5: Start the Website

Run:

```bash
python app.py
```

Or:
```bash
py app.py
```

You should see output like:
```
 * Running on http://127.0.0.1:5000
 * Running on http://0.0.0.0:5000
```

## Step 6: Open in Browser

Open your web browser and go to:

**http://localhost:5000**

or

**http://127.0.0.1:5000**

## Alternative: Use the Batch File

If you prefer, you can simply double-click `run.bat` in the project folder. It will do steps 3-5 automatically.

**Important:** Make sure to open a NEW terminal window after installing Python so it picks up the PATH changes!

## Troubleshooting

### If `python` command doesn't work:

1. **Restart your terminal/IDE** - This is important! PATH changes require a restart.

2. **Try `py` instead:**
   ```bash
   py -m pip install -r requirements.txt
   py train_model.py
   py app.py
   ```

3. **Check Python installation:**
   - Open Windows Start Menu
   - Search for "Python"
   - If you see "Python 3.x", it's installed
   - Click it to see the installation path

4. **Reinstall Python with PATH:**
   - Download from python.org
   - During installation, **check "Add Python to PATH"**
   - This is crucial!

### If you get "pip is not recognized":

Try:
```bash
python -m ensurepip --upgrade
python -m pip install -r requirements.txt
```

### If port 5000 is already in use:

Edit `app.py` and change the last line to:
```python
app.run(debug=True, host='0.0.0.0', port=5001)
```

Then access the site at `http://localhost:5001`

## What to Expect

Once everything is running:
- ✅ You'll see the Flask server running in the terminal
- ✅ The website will load in your browser
- ✅ You can make predictions, upload CSV files, and view the dashboard

**Keep the terminal window open** while using the website. Close it (Ctrl+C) when you're done.



