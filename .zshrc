fpath=(~/scripts ~/.zfunc $fpath)

autoload -Uz env-ocaml oass

autoload -U compinit bashcompinit
compinit
bashcompinit

[ -f "$HOME/.profile" ] && . "$HOME/.profile"

source <(fzf --zsh)
eval "$(starship init zsh)"

# Aliasses: RCLONE and UNI
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

alias initass='cp -r ../Template ./Ausarbeitung'
alias hxass='hx ./Ausarbeitung/main.typ'

alias zath="zathura --fork"
alias dbe="distrobox enter"
alias lsa="ls -a"
alias vim="nvim"
