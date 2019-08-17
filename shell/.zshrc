source ~/bin/zplug/init.zsh

# Plugins

zplug "agkozak/agkozak-zsh-prompt"
AGKOZAK_LEFT_PROMPT_ONLY=1
zplug "clvv/fasd", as:command, use:fasd
zplug "zsh-users/zsh-autosuggestions", defer:2
zplug "zsh-users/zsh-syntax-highlighting", defer:3
zplug "lib/history.zsh", from:oh-my-zsh
zplug load
bindkey -e

# Fasd 
eval "$(fasd --init auto)"

# Alias

o () {
    (($# == 1)) && xdg-open "$1" &>/dev/null & disown 
}
alias ls='ls --color'
alias vim='nvim'
alias vw='vim ~/vimwiki/index.wiki'
alias p='o "$(rg --files -g "*pdf" | fzf)"'
alias n='nnn'
alias j='cd ~/Code/notebooks/; jupyter lab'

alias sage='~/sage/sage'
alias sage_arch='/usr/bin/sage'
eval `dircolors ~/.dircolors`
alias gwip='git add -A && git commit --no-verify -m "WIP"'
alias gwip_push='git add -A && git commit --no-verify -m "WIP"; git push -f me @:wip'

# History
HISTSIZE=1000               #How many lines of history to keep in memory
HISTFILE=~/.zsh_history     #Where to save history to disk
SAVEHIST=1000               #Number of history entries to save to disk
HISTDUP=erase               #Erase duplicates in the history file
setopt    appendhistory     #Append history to the history file (no overwriting)
setopt    sharehistory      #Share history across terminals
setopt    incappendhistory  #Immediately append to the history file, not just when a term is killed

bindkey "^[[A" history-beginning-search-backward
bindkey "^[[B" history-beginning-search-forward

# taskwarrior
alias in='task add +in'
tickle () {
    deadline=$1
    shift
    in +tickle wait:$deadline $@
}
alias tick=tickle
alias think='tickle +1d'

## Base16 Shell
BASE16_SHELL="$HOME/.config/base16-shell/"
[ -n "$PS1" ] && \
    [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
        eval "$("$BASE16_SHELL/profile_helper.sh")"

# Dear future Kevin, you may be tempted to put environment variable here.
# Please put them in ~/.zshenv instead.
