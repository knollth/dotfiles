#!/bin/sh

case "$1" in
dark) cp ~/.config/fuzzel/themes/dark/ef-owl.ini ~/.config/fuzzel/colors.ini ;;
light) cp ~/.config/fuzzel/themes/light/modus-operandi.ini ~/.config/fuzzel/colors.ini ;;
default) exit 1 ;;
esac
