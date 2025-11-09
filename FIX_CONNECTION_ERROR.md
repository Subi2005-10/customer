# Fix "Failed to Connect" Error

## Quick Checklist

### ✅ Step 1: Is the Server Running?

**Look at your terminal/command prompt.** You should see:
```
 * Running on http://127.0.0.1:8000
```

**If you DON'T see this:**
- The server is NOT running
- **Solution:** Start the server first!

### ✅ Step 2: Start the Server

**Option A: Use the batch file (Easiest)**
1. Double-click `start_website.bat`
2. Wait for it to start
3. Look for "Running on http://127.0.0.1:8000"

**Option B: Manual start**
1. Open terminal in project folder
2. Run: `python app.py`
3. Wait for "Running on..." message

### ✅ Step 3: Check the URL

Make sure you're using the **correct URL**:
- ✅ `http://localhost:8000`
- ✅ `http://127.0.0.1:8000`
- ❌ `http://localhost` (missing port!)
- ❌ `http://localhost:5000` (wrong port!)

### ✅ Step 4: Common Issues

#### Issue 1: Server Not Started
**Symptom:** Browser shows "Failed to connect" or "This site can't be reached"

**Solution:**
1. Open terminal
2. Go to project folder
3. Run: `python app.py`
4. Wait for server to start
5. Then open browser

#### Issue 2: Wrong Port
**Symptom:** Using port 5000 instead of 8000

**Solution:** Use `http://localhost:8000` (not 5000)

#### Issue 3: Port Already in Use
**Symptom:** Error message says "Address already in use"

**Solution:**
1. Find what's using port 8000:
   ```bash
   netstat -ano | findstr :8000
   ```
2. Kill the process, OR
3. Change port in `app.py` to 8001

#### Issue 4: Firewall Blocking
**Symptom:** Server runs but browser can't connect

**Solution:**
1. Windows Firewall might be blocking
2. Allow Python through firewall
3. Or try: `http://127.0.0.1:8000` instead of `localhost`

#### Issue 5: Server Crashed
**Symptom:** Server started but then stopped

**Solution:**
1. Check terminal for error messages
2. Make sure model files exist in `models/` folder
3. If model missing, run: `python train_model.py`

## Step-by-Step Fix

### Method 1: Fresh Start

1. **Close all terminals/browsers**

2. **Double-click `start_website.bat`**
   - Wait for it to complete
   - Look for "Running on http://127.0.0.1:8000"

3. **Open browser**
   - Go to: `http://localhost:8000`
   - Or: `http://127.0.0.1:8000`

### Method 2: Manual Start

1. **Open Command Prompt**

2. **Navigate to project:**
   ```bash
   cd "C:\Users\vidhy\OneDrive - SRM Institute of Science & Technology\Desktop\customer"
   ```

3. **Check if model exists:**
   ```bash
   dir models
   ```
   Should show .pkl files

4. **Start server:**
   ```bash
   python app.py
   ```

5. **Wait for this message:**
   ```
   * Running on http://127.0.0.1:8000
   ```

6. **Open browser to:**
   ```
   http://localhost:8000
   ```

## Verify Server is Running

Run `check_server.bat` to check:
- Python installation
- Port status
- Model files

## Still Not Working?

### Check These:

1. **Python is installed:**
   ```bash
   python --version
   ```

2. **Dependencies installed:**
   ```bash
   python -c "import flask; print('OK')"
   ```

3. **Model exists:**
   ```bash
   dir models
   ```
   Should show 4 .pkl files

4. **No errors in terminal:**
   - Look for red error messages
   - Share the error if you see one

### Try Different Browser

Sometimes browser cache causes issues:
- Try Chrome
- Try Firefox
- Try Edge
- Clear browser cache

### Try Different URL Format

- `http://127.0.0.1:8000` (most reliable)
- `http://localhost:8000`
- `http://0.0.0.0:8000` (usually doesn't work)

## Quick Test

1. **Start server:**
   ```bash
   python app.py
   ```

2. **In another terminal, test connection:**
   ```bash
   curl http://localhost:8000
   ```
   Or use browser to visit the URL

3. **If curl works but browser doesn't:**
   - Browser cache issue
   - Try incognito/private mode

## Need More Help?

Share:
1. What you see in the terminal when running `python app.py`
2. The exact error message from browser
3. Whether you see "Running on..." message


