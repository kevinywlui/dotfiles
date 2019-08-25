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

# REPORTTIME
REPORTTIME=1
TIMEFMT="'$fg[green]%J$reset_color' time: $fg[blue]%*E$reset_color, cpu: $fg[blue]%P$reset_color"

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

# Replace 'ls' with exa if it is available.
if command -v exa >/dev/null 2>&1; then
    alias ls="exa --git --color=automatic"
    alias ll="exa --all --long --git --color=automatic"
    alias la="exa --all --binary --group --header --long --git --color=automatic"
    alias l="exa --git --color=automatic"
fi

# Environment variables

# Path
export PATH=$PATH:~/.local/bin:~/bin
export PATH=$PATH:~/pre-commit-sage
export PGHOST="$HOME/postgres_data"

# Commands
export EDITOR='nvim'
export VISUAL='nvim'
export MANPAGER='nvim +Man!'
export FZF_DEFAULT_COMMAND='rg --files --no-ignore-vcs --hidden'
export MAKE='make -j 4'


# Python
export PYTHONBREAKPOINT=pudb.set_trace
export PYTHONPATH=${PYTHONPATH}:${HOME}/.local/lib/python2.7
export PYTHONPATH=/home/klui/.local/lib/python3.7/site-packages/:$PYTHONPATH

# Sage
export SAGE_ROOT=$HOME/sage


# Jupyter
export JUPYTERLAB_DIR=$HOME/.local/share/jupyter/lab

# Misc
export TEXINPUTS="SAGE_ROOT/local/share/texmf//:"

# GPG
export GPG_TTY=$(tty)
