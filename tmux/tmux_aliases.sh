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

# create session 
tss() {
	sname=$(printf "%s[%s]" $1 $2)
	echo "$sname"
	tn $sname
#	tmux new-window -t "$sname:1" -n "coca[TU]"
#	tmux new-window -t "$sname:2" -n "coca[git]"
#	tmux new-window -t "$sname:3" -n "coca[srv]"
#	tmux new-window -t "$sname:4" -n "coca[cli]"
#	tmux new-window -t "$sname:5" -n "lite[bld]"
#	tmux new-window -t "$sname:6" -n "lite[dbg]"
#	tmux new-window -t "$sname:7" -n "lite[git]"
#	tmux new-window -t "$sname:8" -n "logs[TU]"
#	tmux new-window -t "$sname:9" -n "logs[nrt]"
#	tmux select-window -t "$sname:1"
}


