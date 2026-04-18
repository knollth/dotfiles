fpath=(~/.zfunc $fpath)
fpath=(${fpath:#/usr/share/zsh/site-functions})

autoload -U compinit bashcompinit zmv
compinit
bashcompinit

[ -f "$HOME/.profile" ] && . "$HOME/.profile"

source <(fzf --zsh)
eval "$(starship init zsh)"

UNI_LOCAL="$HOME/uni"
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

alias mount-pi4='sudo mount -t nfs 192.168.8.10:/mnt/hdd-data /media/pi4'
alias umount-pi4='sudo umount /media/pi4'

alias idea-open="/opt/idea-IU-261.22158.277/bin/idea nosplash"

alias initass='cp -r ../Template ./Ausarbeitung'
alias hxass='hx ./Ausarbeitung/main.typ'

alias zath="zathura --fork"
alias dbe="distrobox enter"
alias lsa="ls -a"

alias vim=$EDITOR
alias nvim=$EDITOR

alias mpvcache='mpv --cache=yes --cache-secs=99999 --demuxer-max-bytes=2G --demuxer-max-back-bytes=1G --keep-open=always --idle=yes'

eval $(keychain --eval --quiet)

# opencode
export PATH=/home/tom/.opencode/bin:$PATH

vterm_printf() {
    if [ -n "$TMUX" ] \
        && { [ "${TERM%%-*}" = "tmux" ] \
            || [ "${TERM%%-*}" = "screen" ]; }; then
        # Tell tmux to pass the escape sequences through
        printf "\ePtmux;\e\e]%s\007\e\\" "$1"
    elif [ "${TERM%%-*}" = "screen" ]; then
        # GNU screen (screen, screen-256color, screen-256color-bce)
        printf "\eP\e]%s\007\e\\" "$1"
    else
        printf "\e]%s\e\\" "$1"
    fi
}
