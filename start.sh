#!/bin/bash

# Set VNC password
mkdir -p ~/.vnc
echo "123123mM" | vncpasswd -f > ~/.vnc/passwd
chmod 600 ~/.vnc/passwd

# Create xstartup script for XFCE
cat > ~/.vnc/xstartup <<EOF
#!/bin/sh
xrdb \$HOME/.Xresources
startxfce4 &
EOF
chmod +x ~/.vnc/xstartup

# Start VNC server
vncserver :1 -geometry 1280x720 -depth 24

# Start ttyd in the background
ttyd -p 7681 bash &

# Start noVNC (websockify proxy)
mkdir -p ~/novnc && cd ~/novnc
git clone https://github.com/novnc/noVNC.git . && git clone https://github.com/novnc/websockify
./utils/novnc_proxy --vnc localhost:5901 &
sleep 3

# Start Cloudflare tunnel (optional)
cloudflared tunnel --url http://localhost:6080 || true

# Keep container running
tail -f /dev/null
