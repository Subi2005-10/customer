# Simple Start Guide - Fix "Failed to Connect"

## The Problem
"Failed to connect" means the server is NOT running. Let's fix it!

## Step-by-Step Solution

### Step 1: Test Your Setup
Double-click `test_server.py` or run:
```bash
python test_server.py
```

This will check if everything is ready.

### Step 2: Start the Server

**IMPORTANT:** You MUST see "Running on..." message!

**Option A: Use Batch File**
1. Double-click `start_website.bat`
2. **LOOK FOR THIS MESSAGE:**
   ```
   * Running on http://127.0.0.1:5000
   ```
3. **If you see this, server is running!**
4. **Keep the window open!**

**Option B: Manual Start**
1. Open Command Prompt
2. Go to your project folder:
   ```bash
   cd "C:\Users\vidhy\OneDrive - SRM Institute of Science & Technology\Desktop\customer"
   ```
3. Run:
   ```bash
   python app.py
   ```
4. **LOOK FOR:**
   ```
   * Running on http://127.0.0.1:5000
   ```

### Step 3: Open Browser

**ONLY AFTER** you see "Running on..." message:

1. Open your web browser
2. Type in address bar:
   ```
   http://localhost:5000
   ```
   OR
   ```
   http://127.0.0.1:5000
   ```
3. Press Enter

## Common Mistakes

### ❌ Mistake 1: Server Not Started
- **Symptom:** Browser shows "Failed to connect"
- **Fix:** Start the server first! See Step 2

### ❌ Mistake 2: Closed the Terminal
- **Symptom:** Website worked, then stopped
- **Fix:** Keep the terminal window open while using the website

### ❌ Mistake 3: Wrong URL
- **Wrong:** `localhost` (missing http:// and port)
- **Wrong:** `http://localhost` (missing port)
- **Correct:** `http://localhost:5000`

### ❌ Mistake 4: Server Crashed
- **Symptom:** Server started then stopped
- **Fix:** Check terminal for error messages

## Quick Checklist

Before opening browser, verify:

- [ ] Terminal/Command Prompt is open
- [ ] You ran `python app.py` or `start_website.bat`
- [ ] You see "Running on http://127.0.0.1:5000" message
- [ ] Terminal window is still open (not closed)
- [ ] No error messages in terminal

## Still Not Working?

### Check 1: Is Python Working?
```bash
python --version
```
Should show Python 3.x

### Check 2: Are Dependencies Installed?
```bash
python -c "import flask; print('OK')"
```
Should print "OK"

### Check 3: Does Model Exist?
```bash
dir models
```
Should show 4 .pkl files

### Check 4: Is Port 5000 Free?
```bash
netstat -ano | findstr :5000
```
If something is using it, you'll see output

## Visual Guide

```
┌─────────────────────────────────────┐
│  Terminal Window                    │
│  ───────────────────────────────   │
│  $ python app.py                    │
│                                     │
│  =================================  │
│   Churn Prediction Website          │
│  =================================  │
│                                     │
│   Website is running at:            │
│   http://localhost:5000            │
│   http://127.0.0.1:5000             │
│                                     │
│  * Running on http://127.0.0.1:5000│ ← YOU MUST SEE THIS!
│  * Running on http://0.0.0.0:5000   │
│                                     │
└─────────────────────────────────────┘
         ↑
         │
    KEEP THIS OPEN!
         │
         ↓
┌─────────────────────────────────────┐
│  Browser                             │
│  ───────────────────────────────   │
│  Address: http://localhost:5000    │
│                                     │
│  [Website loads here]               │
└─────────────────────────────────────┘
```

## Emergency Fix

If nothing works, try this:

1. **Close everything** (all terminals, browsers)

2. **Open NEW Command Prompt**

3. **Run these commands one by one:**
   ```bash
   cd "C:\Users\vidhy\OneDrive - SRM Institute of Science & Technology\Desktop\customer"
   python test_server.py
   python app.py
   ```

4. **Wait for "Running on..." message**

5. **Then open browser to:** `http://localhost:5000`

## Need Help?

Share with me:
1. What you see when you run `python app.py`
2. Do you see "Running on..." message? (Yes/No)
3. Any error messages in the terminal?



