# Enable Cargo autocompletions
if [ -f "$CARGO_HOME/bin/cargo" ]; then
    COMPLETIONS_DIR="$CARGO_HOME/completions"
    COMPLETION_FILE="$COMPLETIONS_DIR/_cargo"

    # Ensure completions are generated if not already present
    if [ ! -f "$COMPLETION_FILE" ]; then
        echo "Generating Cargo completions for Zsh..."
        mkdir -p "$COMPLETIONS_DIR"
        rustup completions zsh > "$COMPLETION_FILE" 2>/dev/null || {
            echo "Warning: Unable to generate Cargo completions. Skipping."
            return
        }
    fi

    # Add to fpath and enable completions
    fpath=("$COMPLETIONS_DIR" $fpath)
else
    echo "Warning: Cargo binary not found at $CARGO_HOME/bin. Skipping completions."
fi

