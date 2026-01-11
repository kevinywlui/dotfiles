if status is-interactive
    # Enable Vi mode
    fish_vi_key_bindings

    # Initialize zoxide
    zoxide init fish | source

    # Initialize fzf
    fzf --fish | source

    # Initialize starship
    starship init fish | source

    # Bind Ctrl+Space (interpreted as \x00) to accept autosuggestion
    # We bind it for both default (normal) and insert modes
    bind -M insert \x00 accept-autosuggestion
    bind \x00 accept-autosuggestion

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
