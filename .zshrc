autoload -U bashcompinit
bashcompinit

[ -f $HOME/.profile ] && source $HOME/.profile

source <(fzf --zsh)
eval "$(starship init zsh)"

fpath+=~/.zfunc

# aliasesj
RCLONE_FLAGS="--exclude '**/.git/**' --exclude '**/.venv/**' --fast-list -v"

alias uni="cd $UNI && yazi"
alias unidb="cd $UNI && ls && distrobox enter $CURSEM"
alias unipush="rclone sync $RCLONE_FLAGS $UNI/ drive:/Studium"
alias unipull="rclone sync $RCLONE_FLAGS drive:/Studium $UNI"
alias unicheck="rclone check $RCLONE_FLAGS $UNI/ drive:/Studium/"

CURSEM="WS25-26"
alias cs="cd $UNI/$CURSEM && yazi"
alias csdb="cd $UNI/$CURSEM && ls && distrobox enter $CURSEM"
alias cspush="rclone sync $RCLONE_FLAGS $UNI/$CURSEM/ drive:/Studium/$CURSEM"
alias cspull="rclone sync $RCLONE_FLAGS drive:/Studium/$CURSEM $UNI/$CURSEM"
alias cscheck="rclone check $RCLONE_FLAGS $UNI/$CURSEM drive:/Studium/$CURSEM"

oass() {
	local cwd="$(pwd)"
	local in="$cwd/Ausarbeitung/main.typ"
	local out="$cwd/Ausarbeitung/$(basename "$cwd").pdf"
	typst watch $in $out --open
	xdg-open "$cwd/Angabe.pdf" && cd $cwd/Ausarbeitung$
	wait
}
alias initass='cp -r ../Template ./Ausarbeitung'
alias hxass='hx ./Ausarbeitung/main.typ'

alias zath="zathura --fork"
alias dbe="distrobox enter"
alias lsa="ls -a"
alias vim="nvim"

# BEGIN opam configuration
# This is useful if you're using opam as it adds:
#   - the correct directories to the PATH
#   - auto-completion for the opam binary
# This section can be safely removed at any time if needed.
#[[ ! -r '/home/tom/.opam/opam-init/init.zsh' ]] || source '/home/tom/.opam/opam-init/init.zsh' > /dev/null 2> /dev/null
# END opam configuration

autoload -U compinit
compinit

. "$HOME/.local/bin/env"

[ -f "/home/tom/.ghcup/env" ] && . "/home/tom/.ghcup/env" # ghcup-env
