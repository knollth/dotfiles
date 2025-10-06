[ -f $HOME/.profile ]  && . $HOME/.profile

source <(fzf --zsh)
eval "$(starship init zsh)"

fpath+=~/.zfunc

autoload -U compinit
compinit

# aliases
alias uni-push="rclone sync -v $UNI/Studium drive:/Studium"
alias uni-pull="rclone sync -v drive:/Studium $HOME/Documents/Studium"


