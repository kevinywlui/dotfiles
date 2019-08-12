# This is always sourced
export EDITOR='nvim'
export VISUAL='nvim'
export PGHOST="$HOME/postgres_data"
export MAKE='make -j 4'
export FZF_DEFAULT_COMMAND='rg --files --no-ignore-vcs --hidden'
export PYTHONPATH=${PYTHONPATH}:${HOME}/.local/lib/python2.7
export PYTHONPATH=/home/klui/.local/lib/python3.7/site-packages/:$PYTHONPATH

export PATH=$PATH:~/.local/bin:~/bin
export PATH=$PATH:~/pre-commit-sage
export JUPYTERLAB_DIR=$HOME/.local/share/jupyter/lab
export SAGE_ROOT=$HOME/sage
export TEXINPUTS="SAGE_ROOT/local/share/texmf//:"
export FZF_DEFAULT_COMMAND='rg --files --no-ignore-vcs --hidden'
export MANPAGER='nvim +Man!'
