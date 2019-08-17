# This is always sourced

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
export FZF_DEFAULT_COMMAND='rg --files --no-ignore-vcs --hidden'


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
