# Setting Up Custom Domain for Easy Access

## What This Does

Instead of typing `http://localhost:8000`, you can access your website at:
- **http://churn-prediction:8000**
- **http://churnprediction:8000**

## Quick Setup

### Option 1: Automatic Setup (Recommended)

1. **Right-click** `setup_custom_domain.bat`
2. Select **"Run as administrator"**
3. Follow the prompts
4. Done!

### Option 2: Manual Setup

1. Open Notepad **as Administrator**:
   - Press `Win + S`
   - Type "Notepad"
   - Right-click Notepad → "Run as administrator"

2. Open the hosts file:
   - File → Open
   - Navigate to: `C:\Windows\System32\drivers\etc\`
   - Change file type to "All Files"
   - Open `hosts`

3. Add these lines at the end:
   ```
   127.0.0.1    churn-prediction
   127.0.0.1    churnprediction
   ```

4. Save the file (Ctrl+S)

5. Flush DNS cache:
   - Open Command Prompt as Administrator
   - Run: `ipconfig /flushdns`

## Using the Custom Domain

After setup, start your website normally:
```bash
python app.py
```

Then access it at:
- **http://churn-prediction:8000**
- **http://churnprediction:8000**

## Important Notes

1. **You still need the port number** (`:8000`) because we're using a custom domain
2. **Admin rights required** - The hosts file is protected
3. **Works only on your computer** - This is a local setup
4. **If it doesn't work** - Try clearing browser cache or use `http://127.0.0.1:8000`

## Alternative: Use localhost with a Bookmark

If you don't want to modify system files, you can:
1. Bookmark `http://localhost:8000` in your browser
2. Name it "Churn Prediction Website"
3. Access it with one click!

## Troubleshooting

### "Access Denied" Error
- Make sure you're running as Administrator

### Domain Not Working
- Try: `ipconfig /flushdns` in Command Prompt (as Admin)
- Clear browser cache
- Restart browser

### Still Can't Access
- Use `http://127.0.0.1:8000` instead
- Or `http://localhost:8000`


