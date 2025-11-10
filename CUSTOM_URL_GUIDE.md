# Custom URL Name for Your Website

## Current Situation

With ngrok **free tier**, you get random URLs like:
- `https://abc123-def456.ngrok-free.app` (changes each time)

## Options for Custom URL

### Option 1: ngrok Paid Plan (Easiest) ⭐

**Cost:** $8/month

**What you get:**
- Custom domain: `https://yourname.ngrok-free.app`
- Same URL every time
- No random changes

**Setup:**
1. Upgrade to paid plan: https://dashboard.ngrok.com/billing
2. Reserve a domain in dashboard
3. Use it in your config

**Example:**
```
https://churn-prediction.ngrok-free.app
```

### Option 2: ngrok Free Static Domain (Limited)

**Cost:** Free (but limited availability)

**What you get:**
- Sometimes ngrok offers free static domains
- Check your dashboard for availability

**Setup:**
1. Check: https://dashboard.ngrok.com/cloud-edge/domains
2. If available, reserve one
3. Use in config

### Option 3: Alternative Services (Free Options)

#### A. Cloudflare Tunnel (Free, Custom Domain)

**Cost:** Free (if you have a domain)

**Setup:**
1. Get a free domain (Freenom, etc.) or use existing
2. Set up Cloudflare Tunnel
3. Point your domain to it

**Pros:**
- Free
- Custom domain
- Permanent URL

**Cons:**
- More complex setup
- Need a domain name

#### B. Serveo (Free, No Signup)

**Cost:** Free

**Command:**
```bash
ssh -R yourname:80:localhost:5000 serveo.net
```

**URL:** `https://yourname.serveo.net`

**Pros:**
- Free
- Custom name
- No signup

**Cons:**
- Less reliable
- Requires SSH
- May not always work

#### C. LocalTunnel (Free)

**Cost:** Free

**Install:**
```bash
npm install -g localtunnel
```

**Use:**
```bash
lt --port 5000 --subdomain yourname
```

**URL:** `https://yourname.loca.lt`

**Pros:**
- Free
- Custom subdomain
- Easy setup

**Cons:**
- Requires Node.js
- URL changes if subdomain taken

### Option 4: Use Your Own Domain (Advanced)

If you have your own domain:

1. **Get a domain** (Namecheap, GoDaddy, etc.)
2. **Set up DNS** to point to ngrok
3. **Use custom domain** in ngrok config

**Cost:** Domain price (~$10-15/year)

## Recommended Solutions

### For Quick Testing: Use ngrok Free (Current)
- ✅ Free
- ✅ Works now
- ❌ Random URL

### For Permanent Custom URL: ngrok Paid
- ✅ Custom URL
- ✅ Same every time
- ✅ Reliable
- ❌ $8/month

### For Free Custom URL: LocalTunnel
- ✅ Free
- ✅ Custom subdomain
- ✅ Easy
- ❌ Requires Node.js

## Setting Up ngrok Custom Domain (Paid)

If you upgrade to paid:

1. **Upgrade:** https://dashboard.ngrok.com/billing

2. **Reserve domain:**
   - Go to: https://dashboard.ngrok.com/cloud-edge/domains
   - Click "Reserve Domain"
   - Choose name: `churn-prediction` (or your choice)
   - Domain: `churn-prediction.ngrok-free.app`

3. **Configure:**
   ```bash
   ngrok config edit
   ```
   
   Add:
   ```yaml
   tunnels:
     web:
       addr: 5000
       proto: http
       domain: churn-prediction.ngrok-free.app
   ```

4. **Start with:**
   ```bash
   ngrok start web
   ```

5. **Use:** `https://churn-prediction.ngrok-free.app`

## Setting Up LocalTunnel (Free Alternative)

### Step 1: Install Node.js
- Download: https://nodejs.org/
- Install it

### Step 2: Install LocalTunnel
```bash
npm install -g localtunnel
```

### Step 3: Use It
```bash
lt --port 5000 --subdomain churn-prediction
```

**URL:** `https://churn-prediction.loca.lt`

**Note:** If subdomain is taken, try a different name.

## Setting Up Serveo (Free, No Install)

### Step 1: Start Flask
```bash
python app.py
```

### Step 2: Start Serveo
```bash
ssh -R churn-prediction:80:localhost:5000 serveo.net
```

**URL:** `https://churn-prediction.serveo.net`

**Note:** Requires SSH (usually pre-installed on Windows 10+)

## Comparison Table

| Service | Cost | Custom URL | Reliability | Setup Difficulty |
|---------|------|------------|-------------|------------------|
| ngrok Free | Free | ❌ Random | ⭐⭐⭐⭐⭐ | ⭐ Easy |
| ngrok Paid | $8/mo | ✅ Yes | ⭐⭐⭐⭐⭐ | ⭐ Easy |
| LocalTunnel | Free | ✅ Yes | ⭐⭐⭐ | ⭐⭐ Medium |
| Serveo | Free | ✅ Yes | ⭐⭐ | ⭐⭐⭐ Hard |
| Cloudflare | Free* | ✅ Yes | ⭐⭐⭐⭐⭐ | ⭐⭐⭐⭐ Complex |

*Free if you have a domain

## My Recommendation

**For now (free):**
- Keep using ngrok free tier
- Or try LocalTunnel for custom subdomain

**For permanent solution:**
- Upgrade to ngrok paid ($8/month)
- Get custom domain: `churn-prediction.ngrok-free.app`

**For free custom URL:**
- Try LocalTunnel: `https://yourname.loca.lt`

## Quick Start: LocalTunnel (Free Custom URL)

1. **Install Node.js:** https://nodejs.org/

2. **Install LocalTunnel:**
   ```bash
   npm install -g localtunnel
   ```

3. **Start Flask:**
   ```bash
   python app.py
   ```

4. **Start LocalTunnel:**
   ```bash
   lt --port 5000 --subdomain churn-prediction
   ```

5. **Use:** `https://churn-prediction.loca.lt`

That's it! Free custom URL! 🎉



