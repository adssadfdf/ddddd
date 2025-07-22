#!/bin/bash
set -e

echo "[+] Setting VNC password..."
mkdir -p ~/.vnc
echo "123123mM" | vncpasswd -f > ~/.vnc/passwd
chmod 600 ~/.vnc/passwd

echo "[+] Creating xstartup file..."
cat > ~/.vnc/xstartup <<EOF
#!/bin/sh
xrdb \$HOME/.Xresources
startxfce4 &
EOF
chmod +x ~/.vnc/xstartup

echo "[+] Starting VNC server..."
vncserver :1 -geometry 1280x720 -depth 24

echo "[+] Starting ttyd..."
ttyd -p 7681 bash &

echo "[+] Cloning noVNC..."
mkdir -p ~/novnc && cd ~/novnc
git clone https://github.com/novnc/noVNC.git . && git clone https://github.com/novnc/websockify

echo "[+] Starting noVNC..."
./utils/novnc_proxy --vnc localhost:5901 &

echo "[+] (Optional) Starting Cloudflare tunnel..."
cloudflared tunnel --url http://localhost:6080 || true

echo "[+] Ready. Keeping container alive..."
tail -f /dev/null
