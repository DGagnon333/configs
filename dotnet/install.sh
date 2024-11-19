#!/bin/bash

# Ensure the script exits on any command failure
set -e

# Step 1: Install .NET SDK
echo "Installing .NET SDK..."
if [[ "$OSTYPE" == "darwin"* ]]; then
    brew install --cask dotnet-sdk
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    if command -v apt-get &> /dev/null; then
        sudo apt-get update && sudo apt-get install -y dotnet-sdk-6.0
    elif command -v yum &> /dev/null; then
        sudo yum install -y dotnet-sdk-6.0
    fi
else
    echo "Unsupported OS for automatic .NET SDK installation. Please install it manually."
    exit 1
fi

# Verify .NET installation
if ! command -v dotnet &> /dev/null; then
    echo ".NET SDK installation failed. Please check your setup."
    exit 1
fi
echo ".NET SDK installed successfully."

# Step 2: Fetch and Install the Latest OmniSharp
echo "Fetching the latest OmniSharp release..."
LATEST_OMNISHARP_RELEASE=$(curl -s https://api.github.com/repos/OmniSharp/omnisharp-roslyn/releases/latest | grep '"tag_name"' | sed -E 's/.*"([^"]+)".*/\1/')
if [[ -z "$LATEST_OMNISHARP_RELEASE" ]]; then
    echo "Failed to fetch the latest OmniSharp version. Please check your internet connection."
    exit 1
fi
echo "Latest OmniSharp version: $LATEST_OMNISHARP_RELEASE"

# Determine the system's architecture
if [[ "$OSTYPE" == "darwin"* ]]; then
    OS="osx"
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    OS="linux-x64"
else
    echo "Unsupported OS for OmniSharp. Please check the OmniSharp releases page for manual installation."
    exit 1
fi

# Installation directory
INSTALL_DIR="$HOME/.local/share/omnisharp"
INSTALLED_VERSION_FILE="$INSTALL_DIR/version.txt"

# Check if OmniSharp is already installed and up-to-date
if [[ -f "$INSTALLED_VERSION_FILE" ]]; then
    INSTALLED_VERSION=$(cat "$INSTALLED_VERSION_FILE")
    if [[ "$INSTALLED_VERSION" == "$LATEST_OMNISHARP_RELEASE" ]]; then
        echo "OmniSharp is already up-to-date (version: $INSTALLED_VERSION)."
        exit 0
    fi
fi

# Download and install OmniSharp
OMNISHARP_URL="https://github.com/OmniSharp/omnisharp-roslyn/releases/download/$LATEST_OMNISHARP_RELEASE/omnisharp-$OS.tar.gz"
echo "Downloading OmniSharp from $OMNISHARP_URL..."
curl -L -o omnisharp.tar.gz "$OMNISHARP_URL"

echo "Extracting OmniSharp..."
if [[ -f /functions/extract ]]; then
    echo "Using custom extract function..."
    source /functions/extract
    extract omnisharp.tar.gz
else
    mkdir -p omnisharp_extracted
    tar -xzf omnisharp.tar.gz -C omnisharp_extracted
fi
rm -f omnisharp.tar.gz

echo "Installing OmniSharp to $INSTALL_DIR..."
mkdir -p "$INSTALL_DIR"
rm -rf "$INSTALL_DIR"/*  # Clean previous installation
mv omnisharp_extracted/* "$INSTALL_DIR/"
chmod +x "$INSTALL_DIR/run"
rm -rf omnisharp_extracted

# Save the latest version
echo "$LATEST_OMNISHARP_RELEASE" > "$INSTALLED_VERSION_FILE"

# Ensure ~/.local/share/bin exists and add to PATH
BIN_DIR="$HOME/.local/share/bin"
mkdir -p "$BIN_DIR"
ln -sf "$INSTALL_DIR/run" "$BIN_DIR/omnisharp"

if [[ ":$PATH:" != *":$BIN_DIR:"* ]]; then
    echo "Adding $BIN_DIR to PATH..."
    echo "export PATH=\"$BIN_DIR:\$PATH\"" >> "$HOME/.bashrc"
    echo "export PATH=\"$BIN_DIR:\$PATH\"" >> "$HOME/.zshrc"  # For Zsh users
    export PATH="$BIN_DIR:$PATH"
fi

# Verify OmniSharp installation
if ! command -v omnisharp &> /dev/null; then
    echo "OmniSharp installation failed. Please check your setup."
    exit 1
fi
echo "OmniSharp installed successfully."

# Use XDG_CONFIG_HOME for dotfiles location
DOTNET_PATH_FILE="${XDG_CONFIG_HOME:-$HOME/.dotfiles}/dotnet/path.zsh"

echo "Setting OMNISHARP_PATH in $DOTNET_PATH_FILE..."
mkdir -p "$(dirname "$DOTNET_PATH_FILE")"
echo "export OMNISHARP_PATH=\"$INSTALL_DIR\"" > "$DOTNET_PATH_FILE"

