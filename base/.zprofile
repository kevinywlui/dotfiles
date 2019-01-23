# if [ -z "$DISPLAY" ] && [ -n "$XDG_VTNR" ] && [ "$XDG_VTNR" -eq 1 ]; then
#   exec startx
# fi
# If running from tty1 start sway
if [ "$(tty)" = "/dev/tty1" ]; then
	sway
	exit 0
fi
