if status is-interactive
    # Commands to run in interactive sessions can go here

    # Environment Variables
    set -gx EDITOR nvim
    set -gx VISUAL nvim

    # Add local bin to path
    fish_add_path $HOME/.local/bin

    # Aliases
    alias ls='ls --color=auto'
    alias vim='nvim'
    alias xm='xmodmap ~/.xmodmap'

    # Tools initialization
    if type -q zoxide
        zoxide init fish | source
    end

    if type -q starship
        starship init fish | source
    end

    if type -q fzf
        fzf --fish | source
    end
end
