xmodmap ~/.Xmodmap
xss-lock -- slock &
udiskie &
xbindkeys
ponymix mute --input
ponymix mute --output
xinput set-button-map 11 1 0 3
[[ -x /usr/bin/dunst ]] && /usr/bin/dunst -config ~/.dunstrc &

exec i3
