#!//usr/bin/bash

path='/tmp/'
lock='/opt/nhatz/lock.png'

xset +dpms s 15
scrot ${path}locked_screen.png
convert ${path}locked_screen.png -scale 10% -scale 1000% -blur 5X5 ${path}locked_screen.png
[[ -f ${lock} ]] && convert ${path}locked_screen.png ${lock} -gravity center -composite -matte ${path}locked_screen.png
#https://github.com/savoca/dotfiles/blob/gray/home/.bin/scripts/lock.sh
i3lock -u -i ${path}locked_screen.png
rm ${path}locked_screen.png
sleep 20
xset s default
