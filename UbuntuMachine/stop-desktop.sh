#!/bin/bash
set -e

echo "[*] Stopping noVNC server..."
pkill -f "novnc_proxy" || echo "noVNC server not running."

echo "[*] Stopping x11vnc server..."
pkill x11vnc || echo "x11vnc server not running."

echo "[*] Stopping XFCE desktop session..."
pkill xfce4-session || echo "XFCE4 session not running."

echo "[*] Stopping virtual X server (Xvfb)..."
pkill Xvfb || echo "Xvfb not running."

echo "[✔] All services stopped."
