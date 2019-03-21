source ~/bin/zplug/init.zsh


zplug "agkozak/agkozak-zsh-prompt"
zplug "clvv/fasd", as:command, use:fasd
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug load

# antigen bundle git
# antigen bundle clvv/fasd fasd
# antigen bundle zsh-users/zsh-completions
# antigen bundle zsh-users/zsh-syntax-highlighting
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
