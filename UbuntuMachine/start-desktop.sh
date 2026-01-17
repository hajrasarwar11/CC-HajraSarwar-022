#!/bin/bash
set -e

echo "[*] Updating system and installing dependencies..."
sudo apt update
sudo apt install -y \
  xfce4 xfce4-goodies \
  x11vnc xvfb novnc websockify \
  dbus-x11 x11-xserver-utils

export DISPLAY=:1

# Ensure /tmp/.X11-unix exists
if [ ! -d /tmp/.X11-unix ]; then
  sudo mkdir -p /tmp/.X11-unix
  sudo chmod 1777 /tmp/.X11-unix
fi

# Start virtual framebuffer if not running
if ! pgrep Xvfb > /dev/null; then
  echo "[*] Starting virtual X server..."
  Xvfb :1 -screen 0 1920x1080x24 &
  sleep 2
fi

# Start XFCE desktop
if ! pgrep xfce4-session > /dev/null; then
  echo "[*] Starting XFCE4 desktop..."
  startxfce4 &
  sleep 3
fi

# Create password if missing
if [ ! -f ~/.vnc/passwd ]; then
  echo "[*] Creating VNC password..."
  mkdir -p ~/.vnc
  x11vnc -storepasswd "codespace" ~/.vnc/passwd
fi

# Start VNC server
if ! pgrep x11vnc > /dev/null; then
  echo "[*] Starting x11vnc..."
  x11vnc -display :1 -rfbauth ~/.vnc/passwd -noxdamage -forever -shared -rfbport 5901 &
  sleep 2
fi

# Start noVNC (web access)
if ! pgrep -f "novnc_proxy" > /dev/null; then
  echo "[*] Starting noVNC server on port 6080..."
  /usr/share/novnc/utils/novnc_proxy --vnc localhost:5901 --listen 6080 &
  sleep 2
fi

echo "[✔] XFCE desktop environment is running!"
echo "🌐 Access it via the Codespaces HTTPS port (6080)"
