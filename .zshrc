# =============================================================================
# PATH & ENVIRONMENT VARIABLES
# =============================================================================

# Homebrew
export PATH="/opt/homebrew/bin:$PATH"

# Python Environment (pyenv)
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# direnv
eval "$(direnv hook zsh)"

# =============================================================================
# ZSH CORE SETTINGS
# =============================================================================

# History configuration
HISTSIZE=10000
SAVEHIST=10000
setopt HIST_IGNORE_DUPS
setopt HIST_FIND_NO_DUPS
setopt SHARE_HISTORY

# The following lines have been added by Docker Desktop to enable Docker CLI completions.
fpath=(/Users/kohtaroh/.docker/completions $fpath)
autoload -Uz compinit
compinit
# End of Docker CLI completions

# Completion behavior options
setopt AUTO_MENU
setopt COMPLETE_IN_WORD
setopt ALWAYS_TO_END

# =============================================================================
# COMPLETION STYLING & BEHAVIOR
# =============================================================================

# Menu appearance and behavior
zstyle ':completion:*' menu select
zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format '%B%d%b'
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format 'No matches for: %d'

# Completion matching and grouping
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' group-name ''

# =============================================================================
# KEY BINDINGS
# =============================================================================

# Tab completion
bindkey '^I' expand-or-complete

# Ghostty / VSCode のターミナル操作感統一のための単語単位ナビゲーション・削除
# ※ ターミナル側で Option/Alt が Meta キーとして設定されていることが前提
bindkey '\ef' forward-word          # Alt + f: 次の単語へ
bindkey '\eb' backward-word         # Alt + b: 前の単語へ
bindkey '\e\x7f' backward-kill-word # Alt + Backspace: カーソル前の1単語を削除
bindkey '^W' backward-kill-word     # Ctrl + w: カーソル前の1単語を削除（標準のフォールバック）

# =============================================================================
# CUSTOM FUNCTIONS
# =============================================================================

# Repository navigation with ghq+fzf
function g() {
    local repo_name=$(ghq list | fzf --preview 'eza --tree --level=2 --git --group-directories-first $(ghq root)/{}')
    if [ -n "$repo_name" ]; then
        cd "$(ghq root)/$repo_name"
    fi
}

# Git branch switching with fzf
function b() {
    local branch=$(git branch --sort=-committerdate | fzf)
    if [[ -n "$branch" ]]; then
        git switch "$(echo $branch | sed 's/^[ *]*//')"
    fi
}

alias lz='lazygit'

# Modern CLI alternatives
alias ls='eza --icons --git'
alias ll='eza -l -g --icons --git'
alias la='eza -la -g --icons --git'
alias cat='bat --style=plain'

# =============================================================================
# PLUGINS & EXTERNAL TOOLS
# =============================================================================

# Prompt
eval "$(starship init zsh)"

# zoxide (スマートな cd コマンド代替)
eval "$(zoxide init zsh)"
alias cd='z' # 従来のcdをzoxideに置き換える場合

# fzf-tab
source /opt/homebrew/share/fzf-tab/fzf-tab.zsh

# Auto suggestions
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_USE_ASYNC=true
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#586e75,bold"
bindkey '^f' vi-forward-word

# syntax highlighting
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
ZSH_HIGHLIGHT_STYLES[path]='none'
ZSH_HIGHLIGHT_STYLES[path_prefix]='none'
export FZF_DEFAULT_OPTS='--color=fg:-1,bg:-1,hl:#268bd2,fg+:-1,bg+:-1,hl+:#268bd2 --color=info:#b58900,prompt:#268bd2,pointer:#268bd2,marker:#268bd2,spinner:#268bd2,header:#268bd2'
