function tm -a session_name -d "tmux shorthand to open new sessions"
  if test -n "$session_name"
    tmux attach -t $session_name; or tmux new -s $session_name;
  else
    tmux attach; or tmux new -s main;
  end
end
