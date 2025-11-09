"""
Setup script to get a nice URL for your website
Uses ngrok to create a public URL like: https://yourname.ngrok-free.app
"""
import subprocess
import sys
import os
import socket

print("="*60)
print("  Setting Up Easy URL with ngrok")
print("="*60)
print()

# Check if Flask server is running
def check_port(port):
    sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    result = sock.connect_ex(('127.0.0.1', port))
    sock.close()
    return result == 0

print("Checking if Flask server is running...")
if not check_port(5000):
    print("✗ Flask server is NOT running on port 5000!")
    print()
    print("Please start Flask server first:")
    print("  1. Open another terminal")
    print("  2. Run: python app.py")
    print("  3. Wait for 'Running on...' message")
    print("  4. Then run this script again")
    print()
    input("Press Enter to exit...")
    sys.exit(1)

print("✓ Flask server is running on port 5000")
print()

# Check if ngrok is installed
print("Checking if ngrok is installed...")
try:
    result = subprocess.run(['ngrok', 'version'], capture_output=True, text=True, timeout=5)
    print("✓ ngrok is installed")
    print(f"  {result.stdout.strip()}")
except FileNotFoundError:
    print("✗ ngrok is not installed")
    print()
    print("Please install ngrok:")
    print("  1. Download from: https://ngrok.com/download")
    print("  2. Extract ngrok.exe")
    print("  3. Add to PATH or place in project folder")
    print()
    print("Or install via package manager:")
    print("  - Chocolatey: choco install ngrok")
    print("  - Scoop: scoop install ngrok")
    print()
    input("Press Enter to exit...")
    sys.exit(1)
except subprocess.TimeoutExpired:
    print("⚠ ngrok check timed out")
except Exception as e:
    print(f"⚠ Error checking ngrok: {e}")

print()
print("="*60)
print("  Starting ngrok tunnel...")
print("="*60)
print()
print("Your website will be available at a URL like:")
print("  https://xxxx-xxxx.ngrok-free.app")
print()
print("The URL will be shown below.")
print()
print("IMPORTANT:")
print("  - Keep Flask server running in the other terminal")
print("  - Press Ctrl+C to stop ngrok")
print("  - Flask server will keep running")
print()
print("="*60)
print()

# Start ngrok
try:
    print("Starting ngrok...")
    subprocess.run(['ngrok', 'http', '5000'])
except KeyboardInterrupt:
    print("\n\n✓ Stopped ngrok tunnel")
    print("Flask server is still running in the other terminal")
except Exception as e:
    print(f"\n✗ Error: {e}")
    print("\nMake sure:")
    print("  - ngrok is installed and in PATH")
    print("  - Flask server is running on port 5000")
    print("  - You've configured ngrok authtoken")

