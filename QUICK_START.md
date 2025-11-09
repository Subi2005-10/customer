# Quick Start Guide

## The Easiest Way to Start

**Just double-click `start_website.bat`** - That's it!

This will:
1. ✅ Check if Python is installed
2. ✅ Train the model (if needed)
3. ✅ Start the website
4. ✅ Open in your browser at http://localhost:8000

---

## Manual Steps (If Batch File Doesn't Work)

### Step 1: Open Terminal in Project Folder

**Important:** Make sure you're in the correct folder:
```
C:\Users\vidhy\OneDrive - SRM Institute of Science & Technology\Desktop\customer
```

### Step 2: Train the Model

```bash
python train_model.py
```

Wait for it to finish. You should see:
- "Generating sample dataset..."
- "Training KNN model..."
- "Model accuracy: 0.xxxx"
- "Model and encoders saved successfully!"

### Step 3: Start the Website

```bash
python app.py
```

You should see:
```
 * Running on http://127.0.0.1:8000
```

### Step 4: Open Browser

Go to: **http://localhost:8000**

---

## Troubleshooting "No such file or directory"

### Problem: Running from Wrong Directory

**Solution:** Make sure you're in the project folder:

```bash
cd "C:\Users\vidhy\OneDrive - SRM Institute of Science & Technology\Desktop\customer"
```

Then run:
```bash
python train_model.py
```

### Problem: Path with Spaces

The folder path has spaces. The scripts now handle this automatically, but if you still get errors:

1. **Use the batch file:** `start_website.bat` handles paths correctly
2. **Or use quotes in terminal:**
   ```bash
   cd "C:\Users\vidhy\OneDrive - SRM Institute of Science & Technology\Desktop\customer"
   ```

### Problem: Files Not Found

Make sure all these files exist in your project folder:
- ✅ `app.py`
- ✅ `train_model.py`
- ✅ `requirements.txt`
- ✅ `templates/` folder
- ✅ `static/` folder

---

## What Should Happen

1. **Training the model:**
   - Creates `models/` folder with 4 files (.pkl files)
   - Creates `data/` folder with sample_churn_data.csv
   - Takes about 10-30 seconds

2. **Starting the website:**
   - Flask server starts
   - Shows "Running on http://127.0.0.1:8000"
   - Website is accessible in browser

3. **Using the website:**
   - Home page loads
   - Can make predictions
   - Can upload CSV files
   - Can view dashboard

---

## Still Getting Errors?

1. **Check you're in the right folder:**
   ```bash
   dir
   ```
   Should show `app.py`, `train_model.py`, etc.

2. **Check Python works:**
   ```bash
   python --version
   ```

3. **Try the batch file:**
   - Double-click `start_website.bat`
   - It handles everything automatically

4. **Share the exact error message** - I can help fix it!

---

## Need Help?

- Check `TROUBLESHOOTING.md` for common issues
- Check `FIX_INSTALL_ERROR.md` for installation problems
- The batch files (`start_website.bat` or `run.bat`) should handle most issues automatically


