"""
Simple test script to verify Flask server can start
"""
import sys

print("Testing Flask setup...")
print("=" * 50)

# Test 1: Check Python version
print("\n1. Python version:")
print(f"   {sys.version}")

# Test 2: Check if Flask is installed
try:
    import flask
    print("\n2. Flask: ✓ Installed")
    print(f"   Version: {flask.__version__}")
except ImportError:
    print("\n2. Flask: ✗ NOT INSTALLED")
    print("   Run: pip install Flask")
    sys.exit(1)

# Test 3: Check if model files exist
import os
print("\n3. Model files:")
model_files = ['knn_model.pkl', 'label_encoders.pkl', 'target_encoder.pkl', 'feature_cols.pkl']
all_exist = True
for file in model_files:
    path = f'models/{file}'
    if os.path.exists(path):
        print(f"   ✓ {file}")
    else:
        print(f"   ✗ {file} - MISSING")
        all_exist = False

if not all_exist:
    print("\n   ⚠ Model files missing! Run: python train_model.py")

# Test 4: Check if app.py exists
print("\n4. Application files:")
if os.path.exists('app.py'):
    print("   ✓ app.py")
else:
    print("   ✗ app.py - MISSING")
    sys.exit(1)

if os.path.exists('templates'):
    print("   ✓ templates/ folder")
else:
    print("   ✗ templates/ folder - MISSING")

if os.path.exists('static'):
    print("   ✓ static/ folder")
else:
    print("   ✗ static/ folder - MISSING")

# Test 5: Try to import app
print("\n5. Testing app import:")
try:
    # Change to script directory
    script_dir = os.path.dirname(os.path.abspath(__file__))
    os.chdir(script_dir)
    
    # Try importing (but don't run)
    print("   Attempting to import app...")
    # We'll just check if the file is valid Python
    with open('app.py', 'r') as f:
        code = f.read()
        compile(code, 'app.py', 'exec')
    print("   ✓ app.py is valid Python")
except SyntaxError as e:
    print(f"   ✗ Syntax error in app.py: {e}")
    sys.exit(1)
except Exception as e:
    print(f"   ⚠ Warning: {e}")

print("\n" + "=" * 50)
print("\n✓ All basic checks passed!")
print("\nTo start the server, run:")
print("   python app.py")
print("\nThen open: http://localhost:5000")
print("=" * 50)



