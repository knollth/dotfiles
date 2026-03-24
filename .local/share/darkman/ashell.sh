#!/bin/sh

killall ashell 2>/dev/null

case "$1" in
dark)  cp ~/.config/ashell/dark.toml ~/.config/ashell/config.toml ;;
light) cp ~/.config/ashell/light.toml ~/.config/ashell/config.toml ;;
*)     exit 1 ;;
esac

setsid ashell >/dev/null 2>&1 &
