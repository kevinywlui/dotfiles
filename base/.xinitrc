xmodmap ~/.Xmodmap
xss-lock -- slock &
udiskie &
xbindkeys
ponymix mute --input
ponymix mute --output
[[ -x /usr/bin/dunst ]] && /usr/bin/dunst -config ~/.dunstrc &

exec i3
