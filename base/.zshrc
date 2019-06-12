source ~/bin/zplug/init.zsh


zplug "agkozak/agkozak-zsh-prompt"
zplug "clvv/fasd", as:command, use:fasd
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug load
bindkey -e

o () {
    (($# == 1)) && xdg-open "$1" &>/dev/null & disown
}

eval "$(fasd --init auto)"
alias ls='ls --color'
alias vim='nvim'
alias viml='nvim -c "set background=light | colorscheme solarized"'
alias gg='gcalcli --refresh agenda'
alias vw='vim ~/vimwiki/index.wiki'
alias p='o "$(rg --files -g "*pdf" | fzf)"'
alias n='nnn'
alias j='cd ~/notebooks/; jupyter lab'

alias sage='~/sage/sage'
alias sage_arch='/usr/bin/sage'
eval `dircolors ~/.dircolors`
alias sage_test='cd ~/sage; sage -btp ~/sage/src/sage/modular/abvar/abvar.py'
alias gwip='git add -A && git commit --no-verify -m "WIP"'
alias gwip_push='git add -A && git commit --no-verify -m "WIP"; git push -f me @:wip'

alias jsync='jupytext --sync --to py'


gq () { 
    gcalcli --calendar "Main Calendar" quick "$1"
    gcalcli --refresh agenda
}

# Dear future Kevin, you may be tempted to put environment variable here.
# Please put them in ~/.zshenv instead.
