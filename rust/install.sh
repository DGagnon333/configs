#!/usr/bin/env bash

# Ensure the script exits on any command failure
set -e

# Use $ZSH for dotfiles location
LOGGING_FILE="$ZSH/functions/logging.sh"

# Source logging functions
if [ -f "$LOGGING_FILE" ]; then
  source "$LOGGING_FILE"
else
  echo "Error: Logging functions file not found at $LOGGING_FILE. Exiting."
  exit 1
fi

# Check and install Rustup if necessary
info "Checking for Rustup..."
if ! command -v rustup &>/dev/null; then
  warning "Rustup not found. Installing..."
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --no-modify-path
  if [ $? -ne 0 ]; then
    fail "Failed to install Rustup. Exiting."
  fi
  success "Rustup installed."
else
  info "Rustup already installed. Updating..."
  rustup update
  success "Rustup updated."
fi

# Set up environment variables dynamically
info "Configuring Rust environment variables..."
RUST_PATH_FILE="$ZSH/rust/path.zsh"
cat > "$RUST_PATH_FILE" <<EOF
export CARGO_HOME="$HOME/.cargo"
export RUSTUP_HOME="$HOME/.rustup"
export PATH="\$CARGO_HOME/bin:\$PATH"
EOF
success "Rust environment variables configured."

# Install required Rust components and tools
info "Installing Rust components (rustfmt, clippy)..."
rustup component add rustfmt clippy
success "Rust components installed."

info "Installing Cargo tools (cargo-edit, cargo-watch)..."
cargo install cargo-edit cargo-watch
success "Cargo tools installed."

# Generate Cargo completions
info "Setting up Cargo completions..."
COMPLETIONS_DIR="$CARGO_HOME/completions"
mkdir -p "$COMPLETIONS_DIR"
rustup completions zsh > "$COMPLETIONS_DIR/_cargo" 2>/dev/null || {
  warning "Unable to generate Cargo completions. Ensure Rustup is set up correctly."
}
success "Cargo completions setup completed."

