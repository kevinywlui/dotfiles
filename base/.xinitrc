xmodmap ~/.Xmodmap
xss-lock -- slock &
udiskie &
xbindkeys
ponymix mute --input
ponymix mute --output
[[ -x /usr/bin/dunst ]] && /usr/bin/dunst -config ~/.dunstrc &

if [ -x /usr/bin/gcalcli ]; then
  while true; do
    gcalcli remind 30 "notify-send -u critical -i appointment-soon -a gcalcli \%s"
    sleep 10m
  done &
fi
exec i3
