function tm -a session_name -d "tmux shorthand to open new sessions"
  if test -n "$session_name"
    tmux attach -t $session_name || tmux new -s $session_name
  else
    tmux attach || tmux new -s main
  end
end
