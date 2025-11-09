# Step-by-Step Guide: Fix Offline ngrok URL

## 📋 What You Need to Do

You need to start **TWO things**:
1. Flask server (your website)
2. ngrok tunnel (makes your website accessible from internet)

---

## 🚀 STEP-BY-STEP INSTRUCTIONS

### **STEP 1: Check if Flask Server is Running**

1. Open Command Prompt or PowerShell
2. Run this command:
   ```
   netstat -ano | findstr :5000
   ```
3. **What to look for:**
   - ✅ If you see output → Flask is running (go to STEP 2)
   - ❌ If you see nothing → Flask is NOT running (go to STEP 1A)

#### **STEP 1A: Start Flask Server**

1. **Open a NEW Command Prompt/PowerShell window**
2. Navigate to your project folder:
   ```
   cd "C:\Users\vidhy\OneDrive - SRM Institute of Science & Technology\Desktop\customer"
   ```
3. Start Flask server:
   ```
   python app.py
   ```
4. **Wait for this message:**
   ```
   * Running on http://127.0.0.1:5000
   ```
5. **IMPORTANT:** Keep this window open! Don't close it!
6. ✅ Flask server is now running!

---

### **STEP 2: Start ngrok Tunnel**

1. **Open a NEW Command Prompt/PowerShell window** (keep Flask window open!)
2. Navigate to your project folder:
   ```
   cd "C:\Users\vidhy\OneDrive - SRM Institute of Science & Technology\Desktop\customer"
   ```
3. Start ngrok:
   ```
   ngrok http 5000
   ```
4. **Wait 5-10 seconds** for ngrok to start

---

### **STEP 3: Copy Your NEW URL**

1. Look at the ngrok window
2. You should see something like this:
   ```
   ngrok
   
   Session Status                online
   Account                       your-email@example.com
   Version                       3.x.x
   Region                        United States (us)
   Web Interface                 http://127.0.0.1:4040
   Forwarding                    https://abc123-def456.ngrok-free.app -> http://localhost:5000
   Forwarding                    http://abc123-def456.ngrok-free.app -> http://localhost:5000
   ```
3. **Find the line that says "Forwarding"**
4. **Copy the HTTPS URL** (the one starting with `https://`)
   - Example: `https://abc123-def456.ngrok-free.app`
   - ⚠️ **This is your NEW URL - it's different from the old one!**

---

### **STEP 4: Test Your Website**

1. Open your web browser
2. Paste the NEW URL you copied
3. Press Enter
4. **First time visiting?** You might see ngrok branding page
   - Click the **"Visit Site"** button
   - This is normal for free ngrok accounts
5. ✅ Your website should now load!

---

## 📝 Quick Reference Checklist

- [ ] Flask server is running (STEP 1)
- [ ] ngrok tunnel is running (STEP 2)
- [ ] Copied the NEW URL from ngrok window (STEP 3)
- [ ] Tested the NEW URL in browser (STEP 4)
- [ ] Both windows are still open (Flask + ngrok)

---

## ⚠️ Important Reminders

### ✅ Keep Both Windows Open
- **Flask window** - Must stay running
- **ngrok window** - Must stay running
- If you close either one, your URL stops working

### ✅ New URL Every Time
- Each time you restart ngrok, you get a NEW URL
- The old URL (`bettina-inventional-nominally.ngrok-free.dev`) will **NEVER work again**
- Always use the URL shown in the ngrok window

### ✅ URL Format
- Your URL will look like: `https://xxxx-xxxx.ngrok-free.app`
- Or: `https://xxxx-xxxx.ngrok-free.dev`
- The exact name changes every time

---

## 🔧 Alternative: Use Batch Files (Easier)

If you don't want to type commands, use these batch files:

### **Method 1: Automated (Recommended)**

1. Double-click: `start_all.bat`
2. Wait for both windows to open
3. Copy the NEW URL from ngrok window
4. Done! ✅

### **Method 2: Manual with Batch Files**

**Terminal 1:**
1. Double-click: `start_website.bat`
2. Wait for "Running on..." message
3. Keep window open

**Terminal 2:**
1. Double-click: `URLngrok.bat`
2. Copy the NEW URL shown
3. Keep window open

---

## ❌ Troubleshooting

### Problem: "Flask server is NOT running"

**Solution:**
1. Make sure Python is installed: `python --version`
2. Make sure you're in the correct folder
3. Check for errors when running `python app.py`
4. Make sure port 5000 is not used by another program

### Problem: "ngrok is not installed"

**Solution:**
1. Download ngrok from: https://ngrok.com/download
2. Extract `ngrok.exe`
3. Add to PATH OR place in project folder
4. Run `ngrok version` to verify

### Problem: "Authtoken not configured"

**Solution:**
1. Sign up at: https://dashboard.ngrok.com/signup
2. Get authtoken from: https://dashboard.ngrok.com/get-started/your-authtoken
3. Run: `ngrok config add-authtoken YOUR_TOKEN`
4. Replace `YOUR_TOKEN` with your actual token

### Problem: "URL still doesn't work"

**Solutions:**
1. Make sure you're using the NEW URL (not the old one)
2. Make sure both Flask and ngrok are running
3. Check ngrok window for error messages
4. Try restarting both Flask and ngrok
5. Make sure you're using the HTTPS URL (not HTTP)

### Problem: "Port 5000 is already in use"

**Solution:**
1. Find what's using port 5000:
   ```
   netstat -ano | findstr :5000
   ```
2. Stop that program
3. Or use a different port (change in `app.py`)

---

## 🎯 Summary

1. **Start Flask server** → `python app.py`
2. **Start ngrok** → `ngrok http 5000`
3. **Copy NEW URL** → From ngrok window
4. **Test in browser** → Use the NEW URL
5. **Keep both windows open** → Don't close them!

**Remember:** The old URL is dead. Always use the NEW URL from ngrok window!

---

## 💡 Pro Tip

Want to see ngrok's web interface?
- Open: http://127.0.0.1:4040
- This shows all requests going through ngrok
- Useful for debugging!

---

## 📞 Still Having Issues?

Run the diagnostic script:
```
fix_offline_url.bat
```

This will tell you exactly what's wrong and how to fix it.

