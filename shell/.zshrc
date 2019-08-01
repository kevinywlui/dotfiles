source ~/bin/zplug/init.zsh

fpath+=~/.zfunc
zplug "agkozak/agkozak-zsh-prompt"
AGKOZAK_LEFT_PROMPT_ONLY=1
zplug "clvv/fasd", as:command, use:fasd
zplug "zsh-users/zsh-autosuggestions", defer:2
zplug "zsh-users/zsh-syntax-highlighting", defer:3
zplug "lib/history.zsh", from:oh-my-zsh
zplug load
bindkey -e

o () {
    (($# == 1)) && xdg-open "$1" &>/dev/null & disown
}

eval "$(fasd --init auto)"
alias ls='ls --color'
alias vim='nvim'
alias vw='vim ~/vimwiki/index.wiki'
alias p='o "$(rg --files -g "*pdf" | fzf)"'
alias n='nnn'
alias j='cd ~/Code/notebooks/; jupyter lab'

alias sage='~/sage/sage'
alias sage_arch='/usr/bin/sage'
eval `dircolors ~/.dircolors`
alias sage_test='cd ~/sage; sage -btp ~/sage/src/sage/modular/abvar/abvar.py'
alias gwip='git add -A && git commit --no-verify -m "WIP"'
alias gwip_push='git add -A && git commit --no-verify -m "WIP"; git push -f me @:wip'

alias jsync='jupytext --sync --to py'

##############################################################################
# History Configuration
##############################################################################
HISTSIZE=1000               #How many lines of history to keep in memory
HISTFILE=~/.zsh_history     #Where to save history to disk
SAVEHIST=1000               #Number of history entries to save to disk
HISTDUP=erase               #Erase duplicates in the history file
setopt    appendhistory     #Append history to the history file (no overwriting)
setopt    sharehistory      #Share history across terminals
setopt    incappendhistory  #Immediately append to the history file, not just when a term is killed

if [[ -f $HOME/.ssh/config ]]; then
  hosts=($(egrep '^Host.*' $HOME/.ssh/config | awk '{print $2}' | grep -v '^*' | sed -e 's/\.*\*$//'))
  zstyle ':completion:*:hosts' hosts $hosts
fi

alias in='task add +in'
tickle () {
    deadline=$1
    shift
    in +tickle wait:$deadline $@
}
alias tick=tickle
alias think='tickle +1d'
# Dear future Kevin, you may be tempted to put environment variable here.
## Base16 Shell
BASE16_SHELL="$HOME/.config/base16-shell/"
[ -n "$PS1" ] && \
    [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
        eval "$("$BASE16_SHELL/profile_helper.sh")" Please put them in ~/.zshenv instead.
