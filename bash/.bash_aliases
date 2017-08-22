vimruntimepath () {
  vim --cmd 'echo $VIMRUNTIME|q'
}

pacnhatz () {
    case $1 in
        -S*|-R*|U*)
            sudo pacman "$@"
        ;;
        *)
            pacman "$@"
        ;;
    esac
}

alias sudo='sudo '
alias ls='ls --color=auto' # color ls output
alias feh='feh --no-fehbg' # don't overwrite existing script
alias xclip='xclip -selection c' # Pastable copy to clipboard
alias wifi_home='wifi_setup -e BELL214 -i wlp1s0 -p 52EFF792'
alias vimruntime=vimruntimepath
alias pacman=pacnhatz
# alias stfu='sudo !!' :(((
