# Complete ngrok Setup Guide

## What is ngrok?

ngrok creates a public URL (like `https://abc123.ngrok-free.app`) that tunnels to your local server. This means:
- ✅ Nice URL instead of IP address
- ✅ Works from anywhere (not just local network)
- ✅ Easy to share with others
- ✅ Free tier available

## Step-by-Step Setup

### Step 1: Download and Install ngrok

**Option A: Direct Download (Recommended)**
1. Go to: https://ngrok.com/download
2. Download for Windows
3. Extract the `ngrok.exe` file
4. Place it in a folder (e.g., `C:\ngrok\`)
5. Add to PATH (optional but recommended):
   - Right-click "This PC" → Properties
   - Advanced System Settings → Environment Variables
   - Edit "Path" → Add `C:\ngrok\`

**Option B: Using Package Manager**
```bash
# If you have Chocolatey installed:
choco install ngrok

# Or using Scoop:
scoop install ngrok
```

### Step 2: Sign Up for Free Account

1. Go to: https://dashboard.ngrok.com/signup
2. Sign up with email (free)
3. Verify your email
4. You'll be taken to the dashboard

### Step 3: Get Your Authtoken

1. In ngrok dashboard, go to: https://dashboard.ngrok.com/get-started/your-authtoken
2. Copy your authtoken (looks like: `2abc123def456ghi789jkl012mno345pq_6r7s8t9u0v1w2x3y4z5`)

### Step 4: Configure ngrok

Open Command Prompt and run:
```bash
ngrok config add-authtoken YOUR_AUTHTOKEN_HERE
```

Replace `YOUR_AUTHTOKEN_HERE` with the token you copied.

**Example:**
```bash
ngrok config add-authtoken 2abc123def456ghi789jkl012mno345pq_6r7s8t9u0v1w2x3y4z5
```

You should see: `Authtoken saved to configuration file`

### Step 5: Start Your Flask Server

1. Open Command Prompt
2. Go to your project folder:
   ```bash
   cd "C:\Users\vidhy\OneDrive - SRM Institute of Science & Technology\Desktop\customer"
   ```
3. Start the server:
   ```bash
   python app.py
   ```
4. Wait for: `* Running on http://127.0.0.1:5000`
5. **Keep this window open!**

### Step 6: Start ngrok Tunnel

1. **Open a NEW Command Prompt window** (keep Flask server running!)
2. Run:
   ```bash
   ngrok http 5000
   ```

3. You'll see something like:
   ```
   ngrok

   Session Status                online
   Account                       your-email@example.com
   Version                       3.x.x
   Region                        United States (us)
   Latency                       45ms
   Web Interface                 http://127.0.0.1:4040
   Forwarding                    https://abc123-def456.ngrok-free.app -> http://localhost:5000
   Forwarding                    http://abc123-def456.ngrok-free.app -> http://localhost:5000

   Connections                   ttl     opn     rt1     rt5     p50     p90
                                 0       0       0.00    0.00    0.00    0.00
   ```

4. **Copy the HTTPS URL** (the one starting with `https://`)
   - Example: `https://abc123-def456.ngrok-free.app`

### Step 7: Use the URL

Now you can use that URL anywhere:
- ✅ On your phone (any network)
- ✅ On other computers
- ✅ Share with friends
- ✅ Works from anywhere!

Just open: `https://abc123-def456.ngrok-free.app` in any browser!

## Quick Start Script

I've created an automated script for you!

### Using the Script:

1. **Start your Flask server first:**
   ```bash
   python app.py
   ```

2. **In another terminal, run:**
   ```bash
   python setup_easy_url.py
   ```

This will automatically start ngrok for you!

## Important Notes

### ⚠️ Free Tier Limitations:

1. **Random URL each time** - URL changes every time you restart ngrok
   - Unless you pay for a static domain

2. **Connection limits** - Free tier has some limits
   - Usually fine for personal use

3. **ngrok branding page** - First visit shows ngrok page
   - Click "Visit Site" to continue
   - Or pay to remove

### ✅ Tips:

1. **Keep both windows open:**
   - Flask server window
   - ngrok window

2. **URL changes on restart:**
   - Each time you restart ngrok, you get a new URL
   - Copy the new URL each time

3. **Web Interface:**
   - ngrok provides a web interface at `http://127.0.0.1:4040`
   - Shows requests, responses, and URL

4. **Stop ngrok:**
   - Press `Ctrl+C` in the ngrok window
   - Flask server keeps running

## Troubleshooting

### Problem: "ngrok: command not found"

**Solution:**
- ngrok is not in PATH
- Use full path: `C:\ngrok\ngrok.exe http 5000`
- Or add ngrok to PATH (see Step 1)

### Problem: "authtoken not found"

**Solution:**
- Run: `ngrok config add-authtoken YOUR_TOKEN`
- Make sure you copied the token correctly

### Problem: "port 5000 already in use"

**Solution:**
- Something else is using port 5000
- Change Flask port in `app.py` to 5001
- Then use: `ngrok http 5001`

### Problem: URL shows ngrok page

**Solution:**
- This is normal for free tier
- Click "Visit Site" button
- Or upgrade to paid plan

### Problem: Connection timeout

**Solution:**
- Make sure Flask server is running
- Check ngrok is pointing to correct port (5000)
- Restart both Flask and ngrok

## Advanced: Static Domain (Paid)

If you want the same URL every time:

1. **Upgrade to paid plan** ($8/month)
2. **Reserve a domain:**
   ```bash
   ngrok config edit
   ```
3. **Add domain:**
   ```
   tunnels:
     web:
       addr: 5000
       proto: http
       domain: yourname.ngrok-free.app
   ```
4. **Start with:**
   ```bash
   ngrok start web
   ```

## Quick Reference

### Start Everything:

**Terminal 1 (Flask):**
```bash
cd "C:\Users\vidhy\OneDrive - SRM Institute of Science & Technology\Desktop\customer"
python app.py
```

**Terminal 2 (ngrok):**
```bash
ngrok http 5000
```

### Stop Everything:

1. Press `Ctrl+C` in ngrok window
2. Press `Ctrl+C` in Flask window

### Check Status:

- ngrok web interface: `http://127.0.0.1:4040`
- Shows all requests and responses

## Example Workflow

```
1. Start Flask server:
   $ python app.py
   * Running on http://127.0.0.1:5000

2. Start ngrok (new terminal):
   $ ngrok http 5000
   Forwarding: https://abc123.ngrok-free.app -> http://localhost:5000

3. Use URL on phone:
   Open: https://abc123.ngrok-free.app
   ✅ Works!
```

## Summary

1. ✅ Install ngrok
2. ✅ Sign up and get authtoken
3. ✅ Configure: `ngrok config add-authtoken TOKEN`
4. ✅ Start Flask: `python app.py`
5. ✅ Start ngrok: `ngrok http 5000`
6. ✅ Use the URL shown!

That's it! You now have a nice URL instead of an IP address! 🎉


