if status is-interactive
    # Enable Vi mode
    fish_vi_key_bindings

    # Initialize zoxide
    zoxide init fish | source

    # Initialize fzf
    fzf --fish | source

    # Initialize starship
    starship init fish | source

    # Aliases
    alias ls='ls --color'
    alias vim='nvim'
    alias xm='xmodmap ~/.xmodmap'

    # Environment variables
    set -gx EDITOR nvim
    set -gx VISUAL nvim

    # Path
    fish_add_path $HOME/.local/bin
end
