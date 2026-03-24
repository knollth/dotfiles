#!/bin/sh

LIGHT_BG=~/Pictures/Backgrounds/nautical/nautical_light.jpg
DARK_BG=~/Pictures/Backgrounds/nautical/nautical_dark2.jpg

killall wbg 2>/dev/null

case "$1" in
dark)  setsid wbg -s "$DARK_BG" >/dev/null 2>&1  & ;;
light) setsid wbg -s "$LIGHT_BG">/dev/null 2>&1 & ;;
*)     exit 1 ;;
esac
