#!/bin/sh

case "$1" in
dark)
	echo "initial-color-theme=3" >~/.config/foot/darkman.ini
	killall -s SIGUSR1 foot
	;;
light)
	echo "initial-color-theme=2" >~/.config/foot/darkman.ini
	killall -s SIGUSR2 foot
	;;
default) exit 1 ;;
esac
