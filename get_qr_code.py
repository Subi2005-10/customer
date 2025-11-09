"""
Generate QR code for easy phone access
"""
try:
    import qrcode
    from PIL import Image
except ImportError:
    print("Installing required packages...")
    import subprocess
    subprocess.check_call(['pip', 'install', 'qrcode[pil]'])
    import qrcode
    from PIL import Image

import socket

def get_local_ip():
    """Get local IP address"""
    try:
        s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
        s.connect(("8.8.8.8", 80))
        ip = s.getsockname()[0]
        s.close()
        return ip
    except:
        return "localhost"

# Get IP address
ip = get_local_ip()
url = f"http://{ip}:5000"

print("="*50)
print("  QR Code Generator for Phone Access")
print("="*50)
print()
print(f"Your website URL: {url}")
print()
print("Generating QR code...")

# Create QR code
qr = qrcode.QRCode(
    version=1,
    error_correction=qrcode.constants.ERROR_CORRECT_L,
    box_size=10,
    border=4,
)
qr.add_data(url)
qr.make(fit=True)

# Create image
img = qr.make_image(fill_color="black", back_color="white")
img.save("website_qr_code.png")

print()
print("✓ QR code saved as: website_qr_code.png")
print()
print("To use:")
print("1. Open website_qr_code.png on your computer")
print("2. Scan it with your phone's camera")
print("3. Your phone will open the website!")
print()
print("="*50)


