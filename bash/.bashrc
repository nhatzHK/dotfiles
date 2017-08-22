#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Display branch when in a git directory
GIT='$(__git_ps1 " (%s)")'

# Usual-basic prompt
PROMPT="[\u@\h \W${GIT}]\$ "

# Colours sequences (tput) 
GREEN="\[$(tput setaf 2)\]"
BLUE="\[$(tput setaf 4)\]"
YELLOW="\[$(tput setaf 3)\]"
MAG="\[$(tput setaf 5)\]"
CYAN="\[$(tput setaf 6)\]"
RESET="\[$(tput sgr0)\]"

# Display branch name when in a git directory
GIT='$(__git_ps1 "(%s)")'

# Usual-basic prompt
PROMPT="${GREEN}\u${BLUE}@\h ${MAG}\W/ ${YELLOW}${GIT}${GREEN}$ "

# Window title
#TITLE='\e\]2; \W/ \a'

# ${whatever} colour input
export PS1="${PROMPT}${RESET}"

# Retablish output colour
trap 'tput sgr0' DEBUG


#git
source ~/.git-prompt.sh

#color man pages
man () {
	LESS_TERMCAP_md=$'\e[01;31m' \
	LESS_TERMCAP_me=$'\e[0m' \
	LESS_TERMCAP_se=$'\e[0m' \
	LESS_TERMCAP_so=$'\e[01;44;33m' \
	LESS_TERMCAP_ue=$'\e[0m' \
	LESS_TERMCAP_us=$'\e[01;32m' \
	command man "$@"
}

#locally created/compiled scripts, games and utilities
export PATH="$PATH:/opt:/home/nhatz/.gem/ruby/2.4.0/bin:/home/nhatz/.local/bin"


export EDITOR=vim

# Import colorscheme from 'wal'
(wal -r &)

#Alias file
if [ -f ~/.bash_aliases ]; then
	. ~/.bash_aliases
fi

# Custom session file
if [ -f ~/.config/nhatz/session ]; then
    . ~/dotfiles/nhatz/.config/nhatz/session
fi

export THEME=~/.config/bash/themes/agnoster/agnoster.bash
if [[ -f $THEME ]]; then
    export DEFAULT_USER=`whoami`
    source $THEME
fi

export MANPAGER="/bin/sh -c \"col -b | vim -c 'set ft=man ts=8 nomod nolist nonu noma' -\""
