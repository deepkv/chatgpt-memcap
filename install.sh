#!/bin/bash
# Installs the watcher to ~/.local/bin and starts it at every login (launchd agent). Safe to re-run.
set -e
cd "$(dirname "$0")"
label=local.chatgpt-memcap
plist="$HOME/Library/LaunchAgents/$label.plist"

mkdir -p "$HOME/.local/bin" "$HOME/Library/LaunchAgents"
install -m 755 chatgpt-memcap "$HOME/.local/bin/chatgpt-memcap"

cat > "$plist" <<PLIST
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0"><dict>
  <key>Label</key><string>$label</string>
  <key>ProgramArguments</key><array><string>$HOME/.local/bin/chatgpt-memcap</string></array>
  <key>RunAtLoad</key><true/>
  <key>KeepAlive</key><true/>
  <key>StandardOutPath</key><string>$HOME/Library/Logs/chatgpt-memcap.log</string>
  <key>StandardErrorPath</key><string>$HOME/Library/Logs/chatgpt-memcap.log</string>
</dict></plist>
PLIST

launchctl bootout "gui/$(id -u)/$label" 2>/dev/null || true
launchctl bootstrap "gui/$(id -u)" "$plist"
echo "running; kills are logged to ~/Library/Logs/chatgpt-memcap.log"
