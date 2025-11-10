# Fix "Connection Refused" Error

## What This Error Means
"Connection refused" or "localhost refused to connect" means:
- ❌ The server is **NOT running**
- ❌ Nothing is listening on port 5000
- ✅ Your browser is working fine
- ✅ The URL is correct

## The Solution: Start the Server First!

### Method 1: Easiest Way (Recommended)

1. **Double-click `START_SERVER.bat`**
   - This is a new, improved startup script
   - It checks everything and starts the server

2. **Wait for this message:**
   ```
   * Running on http://127.0.0.1:5000
   ```

3. **THEN open your browser**
   - Go to: `http://localhost:5000`
   - The website should load!

### Method 2: Manual Start

1. **Open Command Prompt**

2. **Go to project folder:**
   ```bash
   cd "C:\Users\vidhy\OneDrive - SRM Institute of Science & Technology\Desktop\customer"
   ```

3. **Start the server:**
   ```bash
   python app.py
   ```

4. **Look for this:**
   ```
   * Running on http://127.0.0.1:5000
   ```

5. **Open browser to:** `http://localhost:5000`

## Common Mistakes

### ❌ Mistake 1: Opening Browser Before Server Starts
- **Wrong:** Open browser → See "refused to connect"
- **Right:** Start server → Wait for "Running on..." → Then open browser

### ❌ Mistake 2: Closing the Terminal
- **Problem:** Server stops when you close the terminal
- **Fix:** Keep the terminal window open!

### ❌ Mistake 3: Server Crashed
- **Symptom:** Server started then stopped immediately
- **Fix:** Check terminal for error messages

## Step-by-Step Visual Guide

```
STEP 1: Start Server
┌─────────────────────────────────┐
│ Terminal Window                 │
│ ─────────────────────────────  │
│ $ python app.py                 │
│                                 │
│ =============================== │
│  Churn Prediction Website       │
│ =============================== │
│                                 │
│  Website is running at:          │
│  http://localhost:5000          │
│                                 │
│ * Running on http://127.0.0.1:5000 ← WAIT FOR THIS!
│                                 │
└─────────────────────────────────┘
         ↑
         │
    KEEP OPEN!
         │
         ↓

STEP 2: Open Browser
┌─────────────────────────────────┐
│ Browser                          │
│ ─────────────────────────────  │
│ Address: http://localhost:5000 │
│                                 │
│ [Website loads here]            │
└─────────────────────────────────┘
```

## Quick Test

Run this to verify everything works:

```bash
python test_server.py
```

This will check:
- ✅ Python is installed
- ✅ Flask is installed
- ✅ Model files exist
- ✅ App can be imported

## If Server Won't Start

### Check 1: Python Works?
```bash
python --version
```
Should show: `Python 3.x.x`

### Check 2: Flask Installed?
```bash
python -c "import flask; print('OK')"
```
Should print: `OK`

### Check 3: Model Exists?
```bash
dir models
```
Should show 4 files ending in `.pkl`

### Check 4: Port 5000 Free?
```bash
netstat -ano | findstr :5000
```
If you see output, something else is using port 5000

## Still Not Working?

### Try This Emergency Fix:

1. **Close everything** (all terminals, browsers)

2. **Open NEW Command Prompt**

3. **Run these commands:**
   ```bash
   cd "C:\Users\vidhy\OneDrive - SRM Institute of Science & Technology\Desktop\customer"
   python test_server.py
   python app.py
   ```

4. **Wait for "Running on..." message**

5. **Open browser:** `http://localhost:5000`

## What to Share If Still Broken

Please share:
1. What happens when you run `python app.py`?
2. Do you see "Running on http://127.0.0.1:5000"? (Yes/No)
3. Any error messages in the terminal?
4. What does `python test_server.py` show?

## Remember

**The server MUST be running BEFORE you open the browser!**

The sequence is:
1. ✅ Start server (`python app.py`)
2. ✅ See "Running on..." message
3. ✅ THEN open browser
4. ✅ Website loads!

If you skip step 1 or 2, you'll get "connection refused" error.



