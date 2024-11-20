alias reload!='. ~/.zshrc'
alias vim='nvim'

alias cls='clear' # Good 'ol Clear Screen command
alias cg='cd $(git rev-parse --show-toplevel)'
alias pdf='function _pdf() { pdftotext "$1" - | vim -R -; }; _pdf'
