export UNI="$HOME/Documents/Studium"
export CURSEM="WS25-26"
export EDITOR="hx"
export PATH="$HOME/.local/bin:$HOME/.opencode/bin:$HOME/.juliaup/bin:$HOME/.elan/bin:$PATH"

# dev environments
export OCAML_VERSION="5.1.1"
export OPAMNOENVNOTICE=true
export PKG_CONFIG_PATH="/usr/local/lib64/pkgconfig:$PKG_CONFIG_PATH"

# Tool envs
[ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"
[ -f "$HOME/.ghcup/env" ] && . "$HOME/.ghcup/env"

# Wayland
export MOZ_ENABLE_WAYLAND=1
export QT_QPA_PLATFORM=wayland
export XDG_CURRENT_DESKTOP=river

eval $(opam env)

# Start river on tty1
if [ -z "$WAYLAND_DISPLAY" ] && [ "$(tty)" = "/dev/tty1" ]; then
    exec river
fi
