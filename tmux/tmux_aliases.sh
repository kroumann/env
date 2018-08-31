# This defines tmux shell related aliases

# Attaches tmux to the last session; creates a new session if none exists.
alias t='tmux attach || tmux new-session'

# Attaches tmux to a session (example: ta portal)
alias ta='tmux attach -t'

# Creates a new session
alias tn='tmux new -d -s'

# Lists all ongoing sessions
alias tl='tmux ls'

#kill a session : e.g (tk test)
alias tk='tmux kill-session -t'

#kill all tmux sessions:
alias tkall='tmux kill-server'

