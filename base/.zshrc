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
alias gg='gcalcli --refresh agenda'
alias v='f -e nvim'   # quick opening files with vim
alias f='o "$(fzf --preview "~/bin/preview_cmd {}")"'
alias p='o "$(ag -U -g "(pdf|djvu)$" | fzf)"'
# alias f='o "$(fzf)"'

alias sage='~/sage/sage'
eval `dircolors ~/.dircolors`

gq () { 
    gcalcli --calendar "Main Calendar" quick "$1"
    gcalcli --refresh agenda
}

# Dear future Kevin, you may be tempted to put environment variable here.
# Please put them in ~/.zshenv instead.
