#!/bin/sh
export MOZ_ENABLE_WAYLAND=1
export QT_QPA_PLATFORM=wayland
export XDG_CURRENT_DESKTOP=niri

#systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP

kanshi &
/usr/bin/emacs --daemon &
swaybg --image ~/Pictures/Backgrounds/everforest/close_up/sakura.png --mode fill &
mako &
ashell &
