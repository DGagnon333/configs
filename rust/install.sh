#!/usr/bin/env bash

# Define helper functions for logging
info() { printf "\r  [ \033[00;34m..\033[0m ] $1\n"; }
success() { printf "\r\033[2K  [ \033[00;32mOK\033[0m ] $1\n"; }
warning() { printf "\r  [ \033[00;33m!!\033[0m ] $1\n"; }
error() { printf "\r  [ \033[0;31mERROR\033[0m ] $1\n"; }

# Check and install Rustup if necessary
info "Checking for Rustup..."
if ! command -v rustup &>/dev/null; then
  warning "Rustup not found. Installing..."
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --no-modify-path
  if [ $? -ne 0 ]; then
    error "Failed to install Rustup. Exiting."
    exit 1
  fi
  success "Rustup installed."
else
  info "Rustup already installed. Updating..."
  rustup update
  success "Rustup updated."
fi

# Set up environment variables
info "Configuring Rust environment variables..."
echo "export CARGO_HOME=\"$HOME/.cargo\"" > "$HOME/.dotfiles/rust/path.zsh"
echo "export RUSTUP_HOME=\"$HOME/.rustup\"" >> "$HOME/.dotfiles/rust/path.zsh"
echo "export PATH=\"\$CARGO_HOME/bin:\$PATH\"" >> "$HOME/.dotfiles/rust/path.zsh"

# Install required Rust components and tools
info "Installing Rust components (rustfmt, clippy)..."
rustup component add rustfmt clippy
success "Rust components installed."

info "Installing Cargo tools (cargo-edit, cargo-watch)..."
cargo install cargo-edit cargo-watch
success "Cargo tools installed."

# Generate Cargo completions
info "Setting up Cargo completions..."
COMPLETIONS_DIR="$HOME/.cargo/completions"
mkdir -p "$COMPLETIONS_DIR"
rustup completions zsh > "$COMPLETIONS_DIR/_cargo" 2>/dev/null || {
  warning "Unable to generate Cargo completions. Ensure Rustup is set up correctly."
}
success "Cargo completions setup completed."

