#!/bin/sh

TMUX_SESSION_NAME=tmux-ssh
TMUX_WINDOW_NAME=tmux-ssh-win

tmux start-server
tmux new-session -d -n $TMUX_WINDOW_NAME -s $TMUX_SESSION_NAME

for i in $@
do
	tmux split-window -v -t $TMUX_WINDOW_NAME
	tmux send-keys "ssh $i" C-m
done

tmux kill-pane -t 0
tmux select-pane -t 0
tmux select-layout -t $TMUX_WINDOW_NAME even-vertical
tmux set-window-option synchronize-panes on
tmux attach-session -t $TMUX_SESSION_NAME
