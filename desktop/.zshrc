source ~/bin/antigen/bin/antigen.zsh

# Load the oh-my-zsh's library.
antigen use oh-my-zsh

# Bundles from the default repo (robbyrussell's oh-my-zsh).
antigen bundle git
antigen bundle fasd

# Syntax highlighting bundle.
antigen bundle zsh-users/zsh-syntax-highlighting

# Load the theme.
antigen theme candy

# Tell Antigen that you're done.
antigen apply

alias vim='nvim'
eval `dircolors ~/.dircolors`
export PATH="$PATH:/home/klui/.local/bin/"
