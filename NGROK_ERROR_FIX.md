# Fix ngrok Errors

## Common Errors and Solutions

### Error 1: "ngrok: command not found" or "ngrok is not recognized"

**Problem:** ngrok is not installed or not in PATH

**Solutions:**

**Option A: Add to PATH**
1. Find where you extracted ngrok.exe (e.g., `C:\ngrok\`)
2. Add that folder to Windows PATH:
   - Right-click "This PC" → Properties
   - Advanced System Settings → Environment Variables
   - Edit "Path" → Add `C:\ngrok\`
3. Restart Command Prompt

**Option B: Use Full Path**
```bash
C:\ngrok\ngrok.exe http 5000
```

**Option C: Place in Project Folder**
1. Put `ngrok.exe` in your project folder
2. Run: `.\ngrok.exe http 5000`

**Option D: Reinstall**
```bash
# If you have Chocolatey:
choco install ngrok

# Or download from:
https://ngrok.com/download
```

---

### Error 2: "You must pass a single argument" or "authtoken not found"

**Problem:** ngrok authtoken is not configured

**Solution:**
1. Sign up at: https://dashboard.ngrok.com/signup
2. Get your authtoken from: https://dashboard.ngrok.com/get-started/your-authtoken
3. Run:
   ```bash
   ngrok config add-authtoken YOUR_TOKEN_HERE
   ```
4. Replace `YOUR_TOKEN_HERE` with your actual token

**Example:**
```bash
ngrok config add-authtoken 2abc123def456ghi789jkl012mno345pq_6r7s8t9u0v1w2x3y4z5
```

---

### Error 3: "bind: address already in use" or "port already in use"

**Problem:** Another ngrok instance is already running

**Solution:**
1. Close all ngrok windows
2. Check for running processes:
   ```bash
   tasklist | findstr ngrok
   ```
3. Kill ngrok process if found:
   ```bash
   taskkill /F /IM ngrok.exe
   ```
4. Try again: `ngrok http 5000`

---

### Error 4: "failed to start tunnel" or "connection refused"

**Problem:** Flask server is not running on port 5000

**Solution:**
1. Make sure Flask server is running:
   ```bash
   python app.py
   ```
2. Wait for: `* Running on http://127.0.0.1:5000`
3. Then start ngrok in another terminal

**Or check if port 5000 is in use:**
```bash
netstat -ano | findstr :5000
```

---

### Error 5: "dial tcp: lookup ngrok.com" or "network error"

**Problem:** Internet connection issue or ngrok servers unreachable

**Solutions:**
1. Check internet connection
2. Check firewall isn't blocking ngrok
3. Try again later (ngrok servers might be down)
4. Check if you're behind a corporate proxy

---

### Error 6: "tunnel session failed" or "ERR_NGROK_XXX"

**Problem:** Various ngrok-specific errors

**Solutions:**
1. Check ngrok status: https://status.ngrok.com
2. Update ngrok to latest version:
   ```bash
   ngrok update
   ```
3. Check your ngrok account limits (free tier has limits)
4. Try restarting ngrok

---

### Error 7: "invalid authtoken" or "authtoken format error"

**Problem:** Wrong authtoken format

**Solution:**
1. Make sure you copied the entire token
2. Don't include extra spaces
3. Get a fresh token from dashboard
4. Run: `ngrok config add-authtoken NEW_TOKEN`

---

## Step-by-Step Fix

### If You're Getting Any Error:

1. **Run the diagnostic:**
   ```bash
   fix_ngrok_error.bat
   ```
   This will check common issues

2. **Verify Installation:**
   ```bash
   ngrok version
   ```
   Should show version number

3. **Check Configuration:**
   ```bash
   ngrok config check
   ```
   Should show your config

4. **Test Connection:**
   ```bash
   ngrok http 5000
   ```

## Quick Diagnostic Checklist

- [ ] ngrok is downloaded and extracted
- [ ] ngrok.exe is accessible (in PATH or full path)
- [ ] Signed up for ngrok account
- [ ] Authtoken is configured
- [ ] Flask server is running on port 5000
- [ ] Internet connection is working
- [ ] No other ngrok instance is running
- [ ] Firewall allows ngrok

## Still Not Working?

### Share These Details:

1. **The exact error message** (copy/paste it)
2. **What you see when you run:**
   ```bash
   ngrok version
   ```
3. **What you see when you run:**
   ```bash
   ngrok config check
   ```
4. **Is Flask server running?**
   - Check: `netstat -ano | findstr :5000`

### Alternative: Use the Python Script

Instead of `ngrok http 5000`, try:
```bash
python setup_easy_url.py
```

This script checks everything first and gives better error messages.

## Most Common Fix

**90% of errors are solved by:

1. **Configuring authtoken:**
   ```bash
   ngrok config add-authtoken YOUR_TOKEN
   ```

2. **Making sure Flask is running:**
   ```bash
   python app.py
   ```

3. **Then starting ngrok:**
   ```bash
   ngrok http 5000
   ```

Try running `fix_ngrok_error.bat` first - it will diagnose the issue!



