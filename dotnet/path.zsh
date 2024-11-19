# OmniSharp Path Configuration

# Use XDG_CONFIG_HOME or fallback to default
DOTFILES_DIR="${XDG_CONFIG_HOME:-$HOME/.dotfiles}"
OMNISHARP_INSTALL_DIR="$HOME/.local/share/omnisharp"

# Export OmniSharp path
export OMNISHARP_PATH="$OMNISHARP_INSTALL_DIR"

