#!/bin/sh

export XDG_SESSION_TYPE=wayland
export XDG_CURRENT_DESKTOP=niri
export XKB_DEFAULT_OPTIONS=caps:swapescape

exec niri-session
