alias ls='lsd'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias lt='lsd --tree'
alias cat='bat --paging=never'
alias du='dust'
alias df='duf'

# Docker Compose
alias dcu='docker compose up -d'
alias dcd='docker compose down'

function yy() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}
