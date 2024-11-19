#!/bin/bash

# Detect the OS
OS=$(uname)

if [ "$OS" != "Darwin" ]; then
	echo "This script is intended for macOS (Darwin). Your system is $OS."
	exit 1
fi

# Check if Homebrew is installed
if ! command -v brew &>/dev/null; then
	echo "Homebrew is not installed. Installing Homebrew..."
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
	echo "Homebrew is already installed."
fi

# Update Homebrew
echo "Updating Homebrew..."
brew update

# Install the latest version of Java using Homebrew
echo "Installing the latest version of Java..."
brew install java

# Check if the installation was successful
if ! command -v java &>/dev/null; then
	echo "Java installation failed. Please check your Homebrew setup."
	exit 1
fi

# Get the installed Java version
JAVA_VERSION=$(java -version 2>&1 | head -n 1 | awk -F '"' '{print $2}')

# Configure JAVA_HOME
echo "Setting up JAVA_HOME environment variable..."
JAVA_HOME=$(/usr/libexec/java_home)
if grep -q "JAVA_HOME" ~/.zshrc || grep -q "JAVA_HOME" ~/.bashrc; then
	echo "JAVA_HOME is already set in your shell configuration."
else
	echo "export JAVA_HOME=$JAVA_HOME" >> ~/.zshrc
	echo "export PATH=\$JAVA_HOME/bin:\$PATH" >> ~/.zshrc
	echo "JAVA_HOME and PATH added to ~/.zshrc"
fi

# Apply changes to the current session
export JAVA_HOME
export PATH=$JAVA_HOME/bin:$PATH

# Print confirmation
echo "Java $JAVA_VERSION has been installed and configured."
echo "JAVA_HOME is set to $JAVA_HOME"

