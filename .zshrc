fpath=(~/.zfunc $fpath)
fpath=(${fpath:#/usr/share/zsh/site-functions})

autoload -U compinit bashcompinit zmv
compinit
bashcompinit

[ -f "$HOME/.profile" ] && . "$HOME/.profile"

source <(fzf --zsh)
eval "$(starship init zsh)"

alias mount-media='sudo mount -t nfs 192.168.8.10:/mnt/hdd-data/media /mnt/nas-media'
alias umount-media='sudo umount /mnt/nas-media'

alias mount-archive='sudo mount -t nfs 192.168.8.10:/mnt/hdd-data/archive /mnt/nas-archive'
alias umount-archive='sudo umount /mnt/nas-archive'

alias mount-personal='sudo mount -t nfs 192.168.8.10:/mnt/ssd-personal /mnt/nas-personal'
alias umount-personal='sudo umount /mnt/nas-personal'

alias idea-open="/opt/idea-IU-261.22158.277/bin/idea nosplash"

alias initass='cp -r ../Template ./Ausarbeitung'
alias hxass='hx ./Ausarbeitung/main.typ'

alias zath="zathura --fork"
alias dbe="distrobox enter"
alias lsa="ls -a"

alias nvim=$EDITOR
alias mpvcache='mpv --cache=yes --cache-secs=99999 --demuxer-max-bytes=2G --demuxer-max-back-bytes=1G --keep-open=always --idle=yes'

eval $(keychain --eval --quiet)

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
