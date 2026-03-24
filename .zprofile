export PKG_CONFIG_PATH="${HOME}/.local/lib/pkgconfig:${HOME}/.local/share/pkgconfig"
export LD_LIBRARY_PATH="${HOME}/.local/lib"

path=(
	"$HOME/.local/bin"
	"$HOME/.cargo/bin"
	"$HOME/.scripts"
	$path
)
export PATH

#export UNI="$HOME/Documents/Studium"
export UNI="$HOME/uni"
export ORG="$HOME/ORG"
export EDITOR="kak"

# has to be set *before* river launching
# therefore: here and not in the river init script
export XKB_DEFAULT_OPTIONS=caps:swapescape

#export MOZ_ENABLE_WAYLAND=1
#export QT_QPA_PLATFORM=wayland
#export XDG_CURRENT_DESKTOP=niri
