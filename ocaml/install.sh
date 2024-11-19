#!/usr/bin/env bash

set -e

echo "Setting up OCaml and OPAM via Homebrew..."

# Verify Homebrew is installed
if ! command -v brew &> /dev/null; then
  echo "Homebrew is not installed. Please install Homebrew first."
  exit 1
fi

# Install OCaml and OPAM via Homebrew
echo "Installing OCaml and OPAM via Homebrew..."
brew install ocaml opam

# Initialize OPAM if not already initialized
if [ ! -d "$HOME/.opam" ]; then
  echo "Initializing OPAM..."
  opam init -y --disable-sandboxing --auto-setup
else
  echo "OPAM is already initialized."
fi

# Set up the OPAM environment
echo "Setting up OPAM environment..."
eval "$(opam env)"

# Determine the latest available OCaml compiler version
echo "Fetching the latest OCaml compiler version..."
latest_version=$(opam switch list-available ocaml-base-compiler --short | sort -V | tail -n 1)

if [ -z "$latest_version" ]; then
  echo "Failed to fetch the latest OCaml compiler version."
  exit 1
fi

echo "Latest OCaml compiler version found: $latest_version"

# Check if the switch already exists
if opam switch list --short | grep -q "^default$"; then
  echo "Switch 'default' already exists."
else
  echo "Creating switch 'default' with OCaml compiler $latest_version..."
  opam switch create default "$latest_version" --yes
  eval "$(opam env)"
fi

# Install necessary OCaml packages
echo "Installing OCaml development packages..."
opam install -y ocaml-lsp-server odoc ocamlformat utop dune

echo "OCaml and OPAM setup complete!"

