{{ if eq .chezmoi.os "linux" }}
if [ -e "/home/linuxbrew/.linuxbrew/bin/brew" ]; then
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi
{{ end }}
{{ if eq .chezmoi.os "darwin" }}
if [ -e "/opt/homebrew/bin/brew" ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi
{{ end }}

# set PATH so it includes user's private bin directories if they exist
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

if [ -e "$HOME/.cargo/env" ]; then
    . "$HOME/.cargo/env"
fi

# Expand $PATH to include the directory where snappy applications go.
if [ -d "/snap/bin" ]; then
    case ":$PATH:" in
        *":/snap/bin:"*) ;;
        *) export PATH="$PATH:/snap/bin" ;;
    esac
fi

if command -v vivid >/dev/null 2>&1; then
    export LS_COLORS="$(vivid generate catppuccin-mocha)"
fi
export XDG_CONFIG_HOME="$HOME/.config"
