if [ -z "$DISPLAY" ] && [ -n "$XDG_VTNR" ] && [ "$XDG_VTNR" -eq 1 ]; then
  exec startx
fi
# if [ "$(tty)" = "/dev/tty1" ]; then
# 	sway
# 	exit 0
# fi
_byobu_sourced=1 . /usr/bin/byobu-launch 2>/dev/null || true
