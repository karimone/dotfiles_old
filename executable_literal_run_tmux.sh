#!/bin/sh

alias tmux="tmux -f ~/.config/tmux/config"

session="work"
tmux has-session -t $session

if [[ $? != 0 ]]; then
    tmux new-session -s $session -d 

    # tmux select-pane -t $session:0.1 C-m
    # Window 1
    tmux rename-window "Top"
    tmux split-window -v -t $session
    tmux send-keys -t "1.1" "bashtop" C-m

    # Window 2
    tmux new-window -n "Mario" -t $session
    tmux split-window -v -t $session
    tmux send-keys -t "2.1" "mario-tailwind" C-m
    tmux send-keys -t "2.2" "mario" C-m

    # Window 3
    tmux new-window -n "Kraken" -t $session
    tmux split-window -v -t $session
    tmux send-keys -t "3.1" "v up && v ssh" C-m
    tmux send-keys -t "3.2" "k" C-m

    # Window 4
    tmux new-window -n "Vim" -t $session
    tmux send-keys "my" C-m
fi

tmux attach -t $session
