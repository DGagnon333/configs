# Enable cargo autocompletions
if [ -f "$CARGO_HOME/bin/cargo" ]; then
    source <("$CARGO_HOME/bin/cargo" completions zsh)
fi

