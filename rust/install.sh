#!/usr/bin/env bash

# Define helper functions for logging
info() {
  printf "\r  [ \033[00;34m..\033[0m ] $1\n"
}

success() {
  printf "\r\033[2K  [ \033[00;32mOK\033[0m ] $1\n"
}

warning() {
  printf "\r  [ \033[00;33m!!\033[0m ] $1\n"
}

error() {
  printf "\r  [ \033[0;31mERROR\033[0m ] $1\n"
}

# Check if Rust is installed via Homebrew
info "Checking for existing Rust installation..."
if command -v rustc &>/dev/null && [[ "$(rustc --version)" == *"Homebrew"* ]]; then
  warning "Rust is already installed via Homebrew. Skipping Rustup installation."
  info "You may experience issues if using both Homebrew Rust and Rustup."
else
  # Install Rustup if not installed
  info "Checking for Rustup installation..."
  if ! command -v rustup &>/dev/null; then
    warning "Rustup not found. Attempting to install Rustup..."
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --no-modify-path

    if [ $? -ne 0 ]; then
      error "Failed to install Rustup. Please check your environment or existing Rust installation."
      exit 1
    fi

    success "Rustup installed successfully."
  else
    info "Rustup is already installed. Updating Rust..."
    rustup update
    if [ $? -ne 0 ]; then
      warning "Rust update encountered issues. Continuing with existing installation."
    else
      success "Rust updated successfully."
    fi
  fi
fi

# Ensure Rust environment variables are set up correctly
info "Configuring Rust environment variables..."

# Path to zshrc.symlink
ZSHRC_SYMLINK_PATH="$ZSH/zshrc.symlink"

# Check if Rust environment variables are already set in zshrc.symlink
if ! grep -q 'export CARGO_HOME' "$ZSHRC_SYMLINK_PATH"; then
  info "Adding Rust environment variables to zshrc.symlink..."
  cat << 'EOF' >> "$ZSHRC_SYMLINK_PATH"

EOF

  success "Rust environment variables added to zshrc.symlink."
else
  success "Rust environment variables already set in zshrc.symlink."
fi

# Skip Rust components installation if using Homebrew Rust
if command -v rustc &>/dev/null && [[ "$(rustc --version)" == *"Homebrew"* ]]; then
  warning "Skipping installation of Rust components (rustfmt, clippy) due to Homebrew Rust."
else
  # Install Rust components and tools
  info "Installing Rust components and tools..."
  rustup component add rustfmt clippy
  if [ $? -ne 0 ]; then
    warning "Failed to install Rust components (rustfmt, clippy). Check your Rustup setup."
  else
    success "Rust components installed successfully."
  fi
fi

# Install Cargo tools
info "Installing Cargo tools (cargo-edit, cargo-watch)..."
cargo install cargo-edit cargo-watch
if [ $? -ne 0 ]; then
  warning "Some Cargo tools failed to install. Check your internet connection or Cargo setup."
else
  success "Cargo tools installed successfully."
fi

success "Rust setup completed successfully!"

