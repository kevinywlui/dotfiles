source ~/bin/antigen/bin/antigen.zsh

# Load the oh-my-zsh's library.
antigen use oh-my-zsh

antigen bundle git
antigen bundle clvv/fasd fasd

# Syntax highlighting bundle.
antigen bundle zsh-users/zsh-syntax-highlighting


# Load the theme.
antigen theme candy

# Tell Antigen that you're done.
antigen apply


eval "$(fasd --init auto)"
alias o='xdg-open'
alias vim='nvim'
alias gg='gcalcli agenda'
alias gq='gcalcli --calendar="Main Calendar" quick; gg'
alias v='f -e nvim'   # quick opening files with vim
alias f='o "$(fzf --preview "~/bin/preview_cmd {}")"'
alias p='o "$(ag -U -g "(pdf|djvu)$" | fzf)"'
alias t='vim "$(ag -U -g "tex$" | fzf)"'
# alias f='o "$(fzf)"'
alias sage='~/sage/sage'
eval `dircolors ~/.dircolors`
export EDITOR='nvim'
export VISUAL='nvim'
export PATH=$PATH:~/.local/bin
