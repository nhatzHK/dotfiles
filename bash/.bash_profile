#
# ~/.bash_profile
#


[[ -f ~/.bashrc ]] && . ~/.bashrc

nhatz_session

if [ -z "$DISPLAY" ] && [ -n "$XDG_VTNR" ] && [ "$XDG_VTNR" -eq 1 ]; then
	exec startx
fi
