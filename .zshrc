[ -f $HOME/.profile ] && source $HOME/.profile

source <(fzf --zsh)
eval "$(starship init zsh)"

fpath+=~/.zfunc

# aliases
alias uni-push="rclone sync -v $UNI/ drive:/Studium"
alias uni-pull="rclone sync -v drive:/Studium $UNI"
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
