#envvars
export UNI="$HOME/Documents/Studium"
export EDITOR="hx"

# source rustup envvars
[ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"

. "$HOME/.local/bin/env"

[ -f "/home/tom/.ghcup/env" ] && . "/home/tom/.ghcup/env" # ghcup-env