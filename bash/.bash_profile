#
# ~/.bash_profile
#


[[ -f ~/.bashrc ]] && . ~/.bashrc

nhatz_session

#locally created/compiled scripts, games and utilities
export PATH="$PATH:/opt:$HOME/.gem/ruby/2.4.0/bin:$HOME/.local/bin"

if [ -z "$DISPLAY" ] && [ -n "$XDG_VTNR" ] && [ "$XDG_VTNR" -eq 1 ]; then
	exec startx
fi
