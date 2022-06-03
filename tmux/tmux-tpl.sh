#!/bin/zsh

# tmux session setup script template. can be used as an entry point to create tmux session 
# for specific project. The name of the session is passed as a parameter of this script.
# inspired from fzero script on github.



SESSION=$1

# Tests to see if the session already exists. If it does, just skip everything and reattach.
if [ "$(tmux list-sessions 2> /dev/null | grep -o $SESSION)" != "$SESSION" ]; then
 
  tmux new-session -d -s $SESSION

  # NOTE: We have to call bash (or $SHELL) after every command, or else the window will quit.
  #       This is not necessary if you don't run any commands.

  # exple of running sub process: tmux new-window -t $SESSION:1 -n '(Q)scheduler' "cd ~/Code/queue_service; VERBOSE=1 bundle exec rake resque:scheduler; $SHELL"

  tmux new-window -t $SESSION:1 -n '(D)evelop' "cd ~/; $SHELL"
  tmux new-window -t $SESSION:2 -n '(B)uild' "cd ~/;; $SHELL"
  tmux new-window -t $SESSION:3 -n '(T)ests' "cd ~/; $SHELL"
  tmux new-window -t $SESSION:4 -n '(R)emote' "cd ~/; $SHELL"
 
  # Gets rid of window 0, which is not accessible right away (hence sleep 1)
  sleep 1
  tmux unlink-window -k -t $SESSION:0
 
else
  tmux attach -t $SESSION
fi
