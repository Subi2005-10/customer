# Get a Nice URL Instead of IP Address

## The Problem
Currently you need to use an IP address like `http://192.168.1.105:5000` which is hard to remember.

## Solution Options

### Option 1: Use ngrok (Easiest - Recommended) ⭐

**ngrok** creates a public URL like:
- `https://abc123.ngrok-free.app`
- Easy to remember and share
- Works from anywhere (not just local network)

#### Setup:

1. **Install ngrok:**
   - Download from: https://ngrok.com/download
   - Or install via package manager:
     ```bash
     # Using Chocolatey (if installed)
     choco install ngrok
     ```

2. **Sign up for free account:**
   - Go to: https://dashboard.ngrok.com/signup
   - Get your authtoken

3. **Configure ngrok:**
   ```bash
   ngrok config add-authtoken YOUR_TOKEN_HERE
   ```

4. **Start your Flask server:**
   ```bash
   python app.py
   ```

5. **In another terminal, start ngrok:**
   ```bash
   ngrok http 5000
   ```

6. **You'll get a URL like:**
   ```
   Forwarding: https://abc123.ngrok-free.app -> http://localhost:5000
   ```

7. **Use that URL on your phone or anywhere!**

#### Or use the automated script:
```bash
python setup_easy_url.py
```

### Option 2: Use Local Domain Name (Advanced)

Set up a local domain name that works on your network.

#### For Windows:

1. **On your computer:**
   - Edit hosts file: `C:\Windows\System32\drivers\etc\hosts`
   - Add: `127.0.0.1 churn-prediction.local`

2. **On your phone (if Android with root):**
   - Similar hosts file edit
   - Or use a local DNS app

**Note:** This is complex and requires root access on phone.

### Option 3: Use a QR Code (Simple Workaround)

Create a QR code with your IP address for easy access.

1. **Start server and note the IP address**

2. **Generate QR code:**
   - Use any QR code generator online
   - Enter: `http://YOUR_IP:5000`
   - Scan with phone camera

3. **Bookmark it on your phone** for easy access

### Option 4: Use a Bookmark (Simplest)

1. **Start server and get IP address**

2. **On your phone:**
   - Open browser
   - Go to the IP address
   - Bookmark it with a nice name like "Churn Prediction"

3. **Next time, just open the bookmark!**

## Recommended: ngrok Setup

### Why ngrok?
- ✅ Nice URL (not IP address)
- ✅ Works from anywhere
- ✅ Easy to share
- ✅ Free tier available
- ✅ No router configuration needed

### Quick Start with ngrok:

```bash
# 1. Install ngrok (download from ngrok.com)

# 2. Sign up and get authtoken

# 3. Configure:
ngrok config add-authtoken YOUR_TOKEN

# 4. Start Flask server:
python app.py

# 5. In another terminal:
ngrok http 5000

# 6. Use the URL shown (like https://xxxx.ngrok-free.app)
```

### ngrok Free Tier Limits:
- Random URL each time (unless you pay)
- Connection limits
- Perfect for testing and development

## Alternative: Use a Service

### Other Options:
1. **localtunnel** - Similar to ngrok
   ```bash
   npm install -g localtunnel
   lt --port 5000
   ```

2. **serveo** - No installation needed
   ```bash
   ssh -R 80:localhost:5000 serveo.net
   ```

3. **Cloudflare Tunnel** - Free, permanent URL
   - More complex setup
   - Good for production

## For Local Network Only

If you only need it on your local network:

### Create a Simple Landing Page:

1. **Bookmark the IP on your phone**
2. **Name it "Churn Prediction"**
3. **Access it with one tap**

### Or Use Router's Hostname:

Some routers let you access devices by name:
- Check your router settings
- May support: `http://computername.local:5000`

## My Recommendation

**For easiest setup:** Use ngrok
- Nice URL
- Works everywhere
- Easy to set up
- Free

**For local network only:** Use bookmark
- Simple
- No extra software
- Works great for personal use

## Quick Comparison

| Method | URL Format | Works From | Setup Difficulty |
|--------|-----------|------------|------------------|
| IP Address | `192.168.1.105:5000` | Local network | ⭐ Easy |
| ngrok | `abc123.ngrok-free.app` | Anywhere | ⭐⭐ Medium |
| Bookmark | Bookmark name | Local network | ⭐ Very Easy |
| Local Domain | `churn-prediction.local` | Local network | ⭐⭐⭐ Hard |

## Next Steps

1. **Try ngrok** for a nice URL (recommended)
2. **Or use bookmark** for simplest solution
3. **Or stick with IP** if it works for you

The IP address method is actually normal for local network websites - most local development uses IPs. But if you want something easier, ngrok is the best option!



