# Setup fzf
# ---------
if [[ ! "$PATH" == */Users/vihari/.fzf/bin* ]]; then
  export PATH="$PATH:/Users/vihari/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/Users/vihari/.fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/Users/vihari/.fzf/shell/key-bindings.zsh"

