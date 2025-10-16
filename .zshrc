autoload -U bashcompinit
bashcompinit

[ -f $HOME/.profile ] && source $HOME/.profile

source <(fzf --zsh)
eval "$(starship init zsh)"

fpath+=~/.zfunc

# aliasesj
RCLONE_FLAGS="--exclude '**/.git/**' --exclude '**/.venv/**' --fast-list -v"

alias uni="cd $UNI && ls"
alias unipush="rclone sync $RCLONE_FLAGS $UNI/ drive:/Studium"
alias unipull="rclone sync $RCLONE_FLAGS drive:/Studium $UNI"
alias unicheck="rclone check $RCLONE_FLAGS $UNI/ drive:/Studium/"

CURSEM="WS25-26"
alias cs="cd $UNI/$CURSEM && ls"
alias cspush="rclone sync $RCLONE_FLAGS $UNI/$CURSEM/ drive:/Studium/$CURSEM"
alias cspull="rclone sync $RCLONE_FLAGS drive:/Studium/$CURSEM $UNI/$CURSEM"
alias cscheck="rclone check $RCLONE_FLAGS $UNI/$CURSEM drive:/Studium/$CURSEM"

alias zath="zathura --fork"
alias nvim="hx"

# BEGIN opam configuration
# This is useful if you're using opam as it adds:
#   - the correct directories to the PATH
#   - auto-completion for the opam binary
# This section can be safely removed at any time if needed.
#[[ ! -r '/home/tom/.opam/opam-init/init.zsh' ]] || source '/home/tom/.opam/opam-init/init.zsh' > /dev/null 2> /dev/null
# END opam configuration

autoload -U compinit
compinit
