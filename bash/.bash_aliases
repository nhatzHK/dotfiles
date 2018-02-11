vimruntimepath () {
  vim --cmd 'echo $VIMRUNTIME|q'
}

alias sudo='sudo '
alias ls='ls --color=auto' # color ls output
alias feh='feh --no-fehbg' # don't overwrite existing script
alias xclip='xclip -selection c' # Pastable copy to clipboard
alias wifi_home='wifi_setup -e BELL214 -i wlp1s0 -p 52EFF792'
alias vimruntime='vimruntimepath'
alias vim='vim --servername ERRPELLVIM'
# alias neofetch='neofetch --ascii_distro arch_old --disable gpu  -s $HOME/Pictures/Screenshots/neofetch_"$(date +%F)"'
alias gdx_setup='java -jar /opt/nhatz/gdx-setup.jar'
alias tpack='java -jar /opt/texturepacker.jar'
alias plp='java -jar /opt/plptool5/PLPToolStatic.jar -W -D /opt/plptool/extensions/ $@'
alias absolutely_bloatprietary='python /opt/absolutely-proprietary/main.py'
alias tree='tree -I .git'
