source ~/bin/antigen/bin/antigen.zsh

# Load the oh-my-zsh's library.
antigen use oh-my-zsh

antigen bundle git
antigen bundle clvv/fasd fasd
antigen bundle zsh-users/zsh-completions
antigen bundle zsh-users/zsh-syntax-highlighting


# Load the theme.
antigen theme candy

# Tell Antigen that you're done.
antigen apply

fignore=(\~ aux pdf log)

o () {
    (($# == 1)) && xdg-open "$1" &>/dev/null & disown
}

eval "$(fasd --init auto)"
alias vim='nvim'
alias gg='gcalcli --refresh agenda'
alias vw='vim ~/vimwiki/index.wiki'
alias p='o "$(ag -U -g "(pdf|djvu)$" | fzf)"'

alias sage='~/sage/sage'
eval `dircolors ~/.dircolors`
alias q='sage -btp ~/sage/src/sage/rings/number_field'
alias sq='sage -btp ~/sage/src/sage/rings/number_field'


gq () { 
    gcalcli --calendar "Main Calendar" quick "$1"
    gcalcli --refresh agenda
}

# Dear future Kevin, you may be tempted to put environment variable here.
# Please put them in ~/.zshenv instead.
