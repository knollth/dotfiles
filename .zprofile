export UNI="$HOME/Documents/Studium"
export ORG="$HOME/ORG"
export ORG-NOTES"$ORG/NOTES"

export CURSEM="WS25-26"
export EDITOR="hx"
export PATH="$HOME/.local/bin:$PATH"

# Wayland
export MOZ_ENABLE_WAYLAND=1
export QT_QPA_PLATFORM=wayland
export XDG_CURRENT_DESKTOP=river

# ===== dev environments =====

export PKG_CONFIG_PATH="/usr/local/lib64/pkgconfig:$PKG_CONFIG_PATH"

# ORACLEDB (IFS2)
export ORACLE_VERSION="23_26"
export ORACLE_HOME="$HOME/.local/opt/oracle/instantclient_$ORACLE_VERSION"

export LD_LIBRARY_PATH="$ORACLE_HOME${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}"
export PATH="$ORACLE_HOME:$PATH"

# OCaml/opam
export OCAML_VERSION="5.1.1"
export OPAMNOENVNOTICE=true
export PKG_CONFIG_PATH="/usr/local/lib64/pkgconfig:$PKG_CONFIG_PATH"
eval $(opam env)

# Others
[ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"
[ -f "$HOME/.ghcup/env" ] && . "$HOME/.ghcup/env"

export PATH="$PATH:$HOME/.juliaup/bin"

# Start river on tty1
#if [ -z "$WAYLAND_DISPLAY" ] && [ "$(tty)" = "/dev/tty1" ]; then
#    exec river
#fi
