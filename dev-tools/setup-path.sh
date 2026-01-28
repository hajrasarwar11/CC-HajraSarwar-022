#!/bin/bash

# Add dev-tools to PATH permanently
DEV_TOOLS_PATH="/workspaces/CC-HajraSarwar-022/dev-tools"

# Check if it's already in bashrc
if ! grep -q "dev-tools" ~/.bashrc; then
    echo "export PATH=\"$DEV_TOOLS_PATH:\$PATH\"" >> ~/.bashrc
    echo "Added dev-tools to PATH in ~/.bashrc"
else
    echo "dev-tools already in PATH"
fi

# Apply changes to current session
export PATH="$DEV_TOOLS_PATH:$PATH"
echo "PATH updated for current session"
echo "Run 'source ~/.bashrc' to apply permanently"
