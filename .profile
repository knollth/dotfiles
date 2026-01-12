export UNI="$HOME/Documents/Studium"
export EDITOR="emacs"
export CURSEM="WS25-26"

export OCAML_VERSION="5.1.1"
export OPAMNOENVNOTICE=true

export PATH="$HOME/.local/bin:$HOME/.opencode/bin:$PATH"

[ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"
[ -f "$HOME/.local/bin/env" ] && . "$HOME/.local/bin/env"
[ -f "/home/tom/.ghcup/env" ] && . "/home/tom/.ghcup/env" # ghcup-env


# >>> juliaup initialize >>>

# !! Contents within this block are managed by juliaup !!

case ":$PATH:" in
    *:/home/tom/.juliaup/bin:*)
        ;;

    *)
        export PATH=/home/tom/.juliaup/bin${PATH:+:${PATH}}
        ;;
esac

# <<< juliaup initialize <<<

export PATH="$HOME/.elan/bin:$PATH"
