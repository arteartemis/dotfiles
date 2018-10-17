[ -f ~/.stripe-repos.sh ] && . ~/.stripe-repos.sh
[ -f ~/.rbenvrc ] && . ~/.rbenvrc

export PATH="$HOME/stripe/password-vault/bin:$PATH"
export PATH="$HOME/stripe/space-commander/bin:$PATH"
export PATH="$HOME/stripe/henson/bin:$PATH"

export PATH="$PATH:$HOME/stripe/sorbet/bazel-bin/main"

# preserve the ability to shift-tab complete

bindkey '^[[Z' reverse-menu-complete

# history
HISTFILE=~/.histfile
HISTSIZE=100000
SAVEHIST=100000
setopt HIST_IGNORE_DUPS appendhistory

# globbing settings
setopt extendedglob no_CASE_GLOB

# misc settings
setopt notify
unsetopt beep

# history search backwords with j/k in normal mode
bindkey '^[[A' history-beginning-search-backward
bindkey '^[[B' history-beginning-search-forward

# completion
zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' matcher-list 'm:{a-zA-Z-_}={A-Za-z_-}'
setopt completealiases completeinword
autoload -Uz compinit promptinit
compinit

# colors
autoload -U colors && colors

# version control info
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git
precmd() {
    vcs_info
}
zstyle ':vcs_info:git*' formats "%b"
setopt prompt_subst

# prompt
PROMPT='%1/ %F{blue}${vcs_info_msg_0_} ● %f'

# aliases
alias ps='cd ~/stripe/pay-server'
alias srb='cd ~/stripe/sorbet'
alias stripe='cd ~/stripe'
alias zoo='cd ~/stripe/zoolander'
alias up='cd ..'
alias viz='cd ~/stripe/viz'
alias clean='cd ~/Desktop; mv "Screen Shot"* old/; cd -'

# git
alias gl='git log'
alias gst='git status'
alias gpl='git pull'
alias gd='git diff'
alias grbmps='git fetch origin master-passing-tests:master-passing-tests && git rebase master-passing-tests'
alias gc="git commit -v"
alias gca="gc -a"
alias gcmd="git -c core.commentChar='%' commit -v --template=$HOME/.util/gitmessage.md"
alias gcm="git commit -m"
alias gcam="git commit -am"
alias gp="git push"
alias clear=‘echo no’
alias reload='source ~/.zshrc && source ~/.zshenv'

eval "$(rbenv init -)"
eval "$(nodenv init -)"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
