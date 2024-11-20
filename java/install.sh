#!/bin/bash

# Detect the OS
OS=$(uname)

source "$ZSH/functions/logging.sh"

if [ "$OS" != "Darwin" ]; then
    echo "This script is intended for macOS (Darwin). Your system is $OS."
    exit 1
fi

# Check if Homebrew is installed
if ! command -v brew &>/dev/null; then
	echo "Homebrew is not installed. Skipping java installation..."
	exit
fi

# Install the latest version of Java using Homebrew
echo "Installing the latest version of Java..."
brew install java

# Check if the installation was successful
if ! command -v java &>/dev/null; then
    echo "Java installation failed. Please check your Homebrew setup."
    exit 1
fi

# Dynamically set JAVA_HOME using dirname
JAVA_HOME=$(dirname "$(dirname "$(readlink -f "$(command -v java)")")")

# Update shell configuration files to include JAVA_HOME
echo "Setting up JAVA_HOME environment variable..."
if grep -q "JAVA_HOME" ~/.zshrc || grep -q "JAVA_HOME" ~/.bashrc; then
    echo "JAVA_HOME is already set in your shell configuration."
else
    echo "export JAVA_HOME=\"$JAVA_HOME\"" >> ~/.zshrc
    echo "export PATH=\"\$JAVA_HOME/bin:\$PATH\"" >> ~/.zshrc
    echo "JAVA_HOME and PATH added to ~/.zshrc"
fi

# Apply changes to the current session
export JAVA_HOME
export PATH="$JAVA_HOME/bin:$PATH"

# Print confirmation
JAVA_VERSION=$(java -version 2>&1 | head -n 1 | awk -F '"' '{print $2}')
echo "Java $JAVA_VERSION has been installed and configured."
echo "JAVA_HOME is set to $JAVA_HOME"

if ! command -v sdk &>/dev/null; then
	info "Installing sdkman..."
	curl -s "https://get.sdkman.io" | bash
	info "setting up sdkman..."
	SDK_INSTALL_PATH = "$HOME/.sdkman/bin"
	chmod +x "$SDK_INSTALL_PATH/sdkman-init.sh"
	source "$SDK_INSTALL_PATH/sdkman-init.sh"
	success "sdkman ready"
else
	info "sdkman already installed"
fi

