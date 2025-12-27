xmodmap ~/.xmodmap
xrdb ~/.xresources
[ -f ~/.screenlayout/base.sh ] && . ~/.screenlayout/base.sh

exec i3
