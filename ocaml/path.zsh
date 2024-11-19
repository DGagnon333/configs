# Add Homebrew's bin to PATH based on architecture
if [[ "$(uname -m)" == "Darwin" ]]; then
  export PATH="/opt/homebrew/bin:$PATH"  # Apple Silicon Macs
else
  export PATH="/usr/local/bin:$PATH"      # Intel Macs
fi
